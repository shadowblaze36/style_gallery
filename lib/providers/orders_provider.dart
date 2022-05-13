import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

class OrdersProvider extends ChangeNotifier {
  final String _baseUrl = 'http://10.48.26.21:7575/api/StyleGallery/';

  Map<String, Contents> orderContents = {};
  String _order = '';
  String _result = '';
  int _resultCode = 200;
  String _searchType = 'Order';

  String get searchType => _searchType;

  set searchType(String searchType) {
    _searchType = searchType;
  }

  int get resultCode => _resultCode;

  set resultCode(int resultCode) {
    _resultCode = resultCode;
  }

  String get result => _result;

  set result(String result) {
    _result = result;
  }

  String get order => _order;

  set order(String order) {
    _order = order;
  }

  Future<List<Content>> getContents() async {
    if (_order == '') {
      return [];
    }
    if (orderContents.containsKey(_order)) {
      print('building');
      _resultCode = 200;
      notifyListeners();
      return orderContents[_order]!.content;
    }
    //print('Entro a metodo');
    final response =
        await http.get(Uri.parse(_baseUrl + 'GetContent/?order=$_order'));
    //print(response);
    _resultCode = response.statusCode;
    if (response.statusCode == 200) {
      print(response.body);

      print(Contents.fromJson(response.body).content.length);
      orderContents[_order] = Contents.fromJson(response.body);
      notifyListeners();
      return Contents.fromJson(response.body).content;
    } else {
      print('failed response');
      _result = response.body;
      orderContents[_order] = Contents(order: _order, content: []);
      notifyListeners();
      return [];
      //throw Exception('Failed to load content');
    }
  }

  String getfullImagePath(name) {
    if (name != null) {
      return _baseUrl + 'GetImage?order=$_order&image=$name';
    }

    return 'https://i.stack.imgur.com/GNhxO.png';
  }
}

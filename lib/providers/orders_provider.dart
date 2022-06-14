import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

class OrdersProvider extends ChangeNotifier {
  final String _baseUrl = 'http://arnws001:7575/api/StyleGallery/';

  Map<String, Contents> orderContents = {};
  String order = '';
  String result = '';
  int resultCode = 200;
  String searchType = 'Order';

  Future<List<Content>> getContents() async {
    print('get order contents called');
    order == order.trim();
    if (order == '') {
      return [];
    }
    if (orderContents.containsKey(order)) {
      print('building');
      resultCode = 200;
      notifyListeners();
      return orderContents[order]!.content;
    }
    //print('Entro a metodo');
    print(_baseUrl + 'GetContent/?order=$order');
    final response =
        await http.get(Uri.parse(_baseUrl + 'GetContent/?order=$order'));
    print(response);
    resultCode = response.statusCode;
    if (response.statusCode == 200) {
      print(response.body);

      print(Contents.fromJson(response.body).content.length);
      orderContents[order] = Contents.fromJson(response.body);
      notifyListeners();
      return Contents.fromJson(response.body).content;
    } else {
      print('failed response');
      result = response.body;
      orderContents[order] = Contents(order: order, content: []);
      notifyListeners();
      return [];
      //throw Exception('Failed to load content');
    }
  }

  String getfullImagePath(name) {
    if (name != null) {
      return _baseUrl + 'GetImage?order=$order&image=$name';
    }
    return 'https://i.stack.imgur.com/GNhxO.png';
  }
}

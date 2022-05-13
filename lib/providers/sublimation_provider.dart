import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:style_gallery/helpers/debouncer.dart';
import 'package:style_gallery/models/models.dart';

class SublimationProvider extends ChangeNotifier {
  final String _baseUrl = 'http://10.48.26.21:7135/api/Sublimation/';

  Map<String, Contents> pathContents = {};
  String _path = 'home';
  // String _result = '';
  int _resultCode = 200;
  // String _searchType = 'Order';

  final debouncer = Debouncer(duration: const Duration(milliseconds: 500));
  final StreamController<List<Content>> _styleStreamController =
      StreamController.broadcast();
  Stream<List<Content>> get suggestionStream => _styleStreamController.stream;

  // String get searchType => _searchType;

  // set searchType(String searchType) {
  //   _searchType = searchType;
  // }

  // int get resultCode => _resultCode;

  // set resultCode(int resultCode) {
  //   _resultCode = resultCode;
  // }

  // String get result => _result;

  // set result(String result) {
  //   _result = result;
  // }

  // String get order => _order;

  // set order(String order) {
  //   _order = order;
  // }

  Future<List<Content>> getContents() async {
    if (pathContents.containsKey(_path)) {
      _resultCode = 200;
      notifyListeners();
      return pathContents[_path]!.content;
    }
    String uri = _baseUrl;
    if (_path == 'home') {
      uri += 'GetSublimationRootContent';
    } else {
      uri += 'GetSublimationContentByPath$_path';
    }

    final response = await http.get(Uri.parse(uri));
    _resultCode = response.statusCode;
    if (response.statusCode == 200) {
      print(Contents.fromJson(response.body).content.length);
      pathContents[_path] = Contents.fromJson(response.body);
      notifyListeners();
      return Contents.fromJson(response.body).content;
    } else {
      print('failed response');
      //_result = response.body;
      pathContents[_path] = Contents(order: _path, content: []);
      notifyListeners();
      return [];
      //throw Exception('Failed to load content');
    }
  }

  // String getfullImagePath(name) {
  //   if (name != null) {
  //     return _baseUrl + 'GetImage?order=$_order&image=$name';
  //   }

  //   return 'https://i.stack.imgur.com/GNhxO.png';
  // }

  Future<List<Content>> searchSyles(String query) async {
    final response =
        await http.get(Uri.parse(_baseUrl + 'GetContent/?order=$query'));

    //final searchResponse = SearchResponse.fromJson(response.body);
    return []; //searchResponse.results;
  }

  void getStylesByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await searchSyles(value);
      _styleStreamController.add(results);
    };
    final timer = Timer.periodic((const Duration(milliseconds: 300)), (_) {
      debouncer.value = searchTerm;
    });
    Future.delayed(const Duration(milliseconds: 301))
        .then((_) => timer.cancel());
  }
}

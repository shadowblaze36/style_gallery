import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:style_gallery/helpers/debouncer.dart';
import 'package:style_gallery/models/models.dart';

class SublimationProvider extends ChangeNotifier {
  final String _baseUrl = 'http://arnws001:7575/api/Sublimation/';

  SublimationProvider() {
    getContents();
  }
  Map<String, Contents> pathContents = {};
  bool isLoading = false;

  String _path = 'home';
  String get path => _path;
  set path(String path) {
    _path = path;
    notifyListeners();
  }

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
    isLoading = true;
    if (pathContents.containsKey(_path)) {
      _resultCode = 200;
      isLoading = false;
      notifyListeners();
      return pathContents[_path]!.content;
    }
    String uri = _baseUrl;
    if (_path == 'home') {
      uri += 'GetSublimationRootContent';
    } else {
      uri += 'GetSublimationContentByPath?path=$_path';
    }
    print(uri);
    final response = await http.get(
      Uri.parse(uri),
    );
    _resultCode = response.statusCode;
    if (response.statusCode == 200) {
      pathContents[_path] = Contents.fromJson(response.body);
      print(Contents.fromJson(response.body).content);
      isLoading = false;
      notifyListeners();
      return Contents.fromJson(response.body).content;
    } else {
      print('failed response');
      //_result = response.body;
      pathContents[_path] = Contents(order: _path, content: []);
      isLoading = false;
      notifyListeners();
      return [];
      //throw Exception('Failed to load content');
    }
  }

  void refresh() async {
    isLoading = true;
    String uri = _baseUrl;
    if (_path == 'home') {
      uri += 'GetSublimationRootContent';
    } else {
      uri += 'GetSublimationContentByPath?path=$_path';
    }
    final response = await http.get(Uri.parse(uri));
    _resultCode = response.statusCode;
    if (response.statusCode == 200) {
      pathContents[_path] = Contents.fromJson(response.body);
    } else {
      pathContents[_path] = Contents(order: _path, content: []);
    }
    isLoading = false;
    notifyListeners();
  }

  void generateNextRoute(String nextRoute) {
    if (_path == 'home') {
      _path = nextRoute;
    } else {
      _path += '/$nextRoute';
    }
    getContents();
    notifyListeners();
  }

  void generatePreviousRoute() {
    if (_path.contains('/')) {
      _path = _path.substring(0, _path.lastIndexOf('/'));
    } else {
      _path = 'home';
    }
    getContents();
    notifyListeners();
  }

  String getfullImagePath(name, type) {
    if (name != null && type != null) {
      String fullImagePath =
          '${_baseUrl}GetSublimationImage?path=$_path/$name$type';
      fullImagePath = fullImagePath.replaceAll(RegExp(' '), '%20');
      print(fullImagePath);
      return fullImagePath;
    }
    return 'https://i.stack.imgur.com/GNhxO.png';
  }

  Future<List<Content>> searchStyles(String query) async {
    final response =
        await http.get(Uri.parse(_baseUrl + 'GetContent/?order=$query'));

    //final searchResponse = SearchResponse.fromJson(response.body);
    return []; //searchResponse.results;
  }

  void getStylesByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await searchStyles(value);
      _styleStreamController.add(results);
    };
    final timer = Timer.periodic((const Duration(milliseconds: 300)), (_) {
      debouncer.value = searchTerm;
    });
    Future.delayed(const Duration(milliseconds: 301))
        .then((_) => timer.cancel());
  }
}

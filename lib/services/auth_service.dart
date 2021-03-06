import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'http://10.38.160.10:7878/api';
  final storage = const FlutterSecureStorage();

  Future<String?> login(String usuario, String password) async {
    final Map<String, dynamic> authData = {
      'username': 'tegraglobal\\$usuario',
      'password': password
    };
    final resp = await http.post(Uri.parse('$_baseUrl/auth/login'),
        body: jsonEncode(authData),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        }).timeout(const Duration(seconds: 10));
    final Map<String, dynamic> decodeResp = json.decode(resp.body);

    if (decodeResp.containsKey('token')) {
      await storage.write(key: 'token', value: decodeResp['idToken']);
      return null;
    } else {
      return decodeResp.containsKey('message')
          ? decodeResp['message']
          : 'Ocurrio un error de conexion';
    }
  }

  Future logout() async {
    await storage.delete(key: 'token');
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}

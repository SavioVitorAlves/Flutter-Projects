import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  static const _url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAnVUHWERGa-X5K-i53Sn_U09AMg603o5k';
  
  Future<void> _authentcate(String email, String password, String urlFragment) async{
    final url = 'https://identitytoolkit.googleapis.com/v1/accounts:$urlFragment?key=AIzaSyAnVUHWERGa-X5K-i53Sn_U09AMg603o5k';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      })
    );
    print(jsonDecode(response.body));
  }

  Future<void> signup(String email, String password) async {
    _authentcate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    _authentcate(email, password, 'signInWithPassword');
  }
}
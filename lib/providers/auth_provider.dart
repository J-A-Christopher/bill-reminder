import 'dart:convert';

import 'package:bill_reminder_app/Data/models/http_exception_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  String? get userId {
    return _userId;
  }

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> signUp(String email, String password) async {
    var url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCjOvL4dJO9VFxMpjzNKKzpy1gl2gOCzHA');
    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      //print('giana${json.decode(response.body)}');
      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(message: responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    var url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCjOvL4dJO9VFxMpjzNKKzpy1gl2gOCzHA');
    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      print('leo${json.decode(response.body)}');
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(message: responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}

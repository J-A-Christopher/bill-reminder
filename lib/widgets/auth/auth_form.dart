import 'package:bill_reminder_app/Data/models/http_exception_file.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  TextEditingController passwordEditCont = TextEditingController();
  var _isLogin = true;
  Map<String, dynamic> authData = {
    'userEmail': '',
    'userName': '',
    'userPassword': ''
  };

  void _showErrorDialog(String message) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('An error occured'),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ok'))
            ],
          );
        });
  }

  Future<void> _trySubmit() async {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        if (_isLogin) {
          await Provider.of<Auth>(context, listen: false)
              .login(authData['userEmail'], authData['userPassword']);
          // await Provider.of<Auth>(context, listen: false).retrieveUserData(
          //     authData['userEmail'], authData['userPassword']);
        } else {
          await Provider.of<Auth>(context, listen: false)
              .signUp(authData['userEmail'], authData['userPassword']);
        }

        setState(() {
          _isLoading = false;
        });
        // if (_isLogin) {

        // }
      } on HttpException catch (error) {
        var errorMessage = 'Authentication failed ';
        if (error.toString().contains('EMAIL_EXISTS')) {
          errorMessage = 'The email address is already in use.';
        } else if (error.toString().contains('INVALID_EMAIL')) {
          errorMessage = 'This is not a valid email address';
        } else if (error.toString().contains('WEAK_PASSWORD ')) {
          errorMessage = 'The password id too weak.';
        } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
          errorMessage = 'Could not find user with that email';
        } else if (error.toString().contains('INVALID_PASSWORD')) {
          errorMessage = 'Invalid password';
        }
        _showErrorDialog(errorMessage);
      } catch (error) {
        var errorMessage = 'Could not authenticate you. Try again later';
        _showErrorDialog(errorMessage);
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: const ValueKey('email'),
                    onSaved: (value) {
                      authData['userEmail'] = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                        const InputDecoration(labelText: 'EmailAddress'),
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('username'),
                      onSaved: (value) {
                        authData['userName'] = value!;
                      },
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return 'Username should be atleast 4 charachters';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'Username'),
                    ),
                  TextFormField(
                    controller: passwordEditCont,
                    key: const ValueKey('password'),
                    onSaved: (value) {
                      authData['userPassword'] = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Password should be atleast 7 characters long..';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('cpassword'),
                      validator: (value) {
                        if (value != passwordEditCont.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      // onSaved: (value) {
                      //    = value!;
                      // },
                      decoration:
                          const InputDecoration(labelText: 'Confirm Password'),
                      obscureText: true,
                    ),
                  const SizedBox(
                    height: 12,
                  ),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          onPressed: _trySubmit,
                          child: Text(_isLogin ? 'Login' : 'Signup')),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin
                          ? 'Create an account'
                          : 'Already have an account'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

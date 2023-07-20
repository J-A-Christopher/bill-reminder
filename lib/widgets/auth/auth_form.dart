import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String userEmail = '';
  String userName = '';
  String userPassword = '';
  void _trySubmit() {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      formKey.currentState!.save();
      print(userEmail);
      print(userName);
      print(userPassword);
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
                      userEmail = value!;
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
                        userName = value!;
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
                    key: const ValueKey('password'),
                    onSaved: (value) {
                      userPassword = value!;
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
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: 110,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        onPressed: _trySubmit,
                        child: Text(_isLogin ? 'Login' : 'Signup')),
                  ),
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

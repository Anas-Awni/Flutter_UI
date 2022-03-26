import 'package:flutter/material.dart';

class MyFormField extends StatefulWidget {
  const MyFormField({Key? key}) : super(key: key);

  @override
  _MyFormFieldState createState() => _MyFormFieldState();
}

enum AuthMode { SignUp, Login }

class _MyFormFieldState extends State<MyFormField> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;

  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  final _passwordController = TextEditingController();

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.SignUp;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Auth Screen',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  TextFormField(
                    cursorColor: Colors.indigo,
                    decoration: InputDecoration(
                      hintText: 'E-Mail',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return 'Please enter a valid e-mail';
                      }
                      return null;
                    },
                    onSaved: (val) {
                      _authData['email'] = val!;
                      print(_authData['email']);
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    cursorColor: Colors.indigo,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length <= 5) {
                        return 'Please enter a valid password';
                      }
                      return null;
                    },
                    onSaved: (val) {
                      _authData['password'] = val!;
                      print(_authData['password']);
                    },
                  ),
                  const SizedBox(height: 20),
                  if (_authMode == AuthMode.SignUp)
                    TextFormField(
                      enabled: _authMode == AuthMode.SignUp,
                      cursorColor: Colors.indigo,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      validator: _authMode == AuthMode.SignUp
                          ? (value) {
                              if (value != _passwordController.text) {
                                return 'The passwords do not match!';
                              }
                              return null;
                            }
                          : null,
                    ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    child:
                        Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                    onPressed: _submit,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.indigo),
                    ),
                  ),
                  TextButton(
                    child: Text(
                        '${_authMode == AuthMode.Login ? 'SIGN UP' : 'LOGIN'} INSTEAD'),
                    onPressed: _switchAuthMode,
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.indigo),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
    if (_authMode == AuthMode.Login) {
      //Log user in
    } else {
      //Sign user up
    }
  }
}

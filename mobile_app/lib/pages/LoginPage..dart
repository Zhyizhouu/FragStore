import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/pages/HomePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

const vSpacing = SizedBox(height: 12.0);

class _LoginPageState extends State<LoginPage> {
  String? _errorMessaageUsername;
  String? _errorMessaagePassword;

  final TextEditingController _usernameControoller = TextEditingController();
  final TextEditingController _passwordControoller = TextEditingController();

  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Row(
          children: [
            Image.asset(
              'assets/images/FragStore_Logo.png',
              fit: BoxFit.contain,
              height: 75,
            ),

            const SizedBox(height: 12.0),

            const Text(
              "FragStore",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              autocorrect: false,
              controller: _usernameControoller,
              decoration: InputDecoration(
                errorText: _errorMessaageUsername,
                labelText: "Input your username",
                contentPadding: EdgeInsets.all(5.0),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  if (value.length < 6) {
                    _errorMessaageUsername =
                        "Username must be more than 6 letterss";
                  } else {
                    _errorMessaageUsername = null;
                  }
                });
              },
            ),

            vSpacing,

            TextField(
              controller: _passwordControoller,
              obscureText: true,
              autocorrect: false,
              decoration: InputDecoration(
                errorText: _errorMessaagePassword,
                labelText: "Input Password",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(5.0),
              ),
              onChanged: (value) {
                setState(() {
                  if (value.length < 6)
                    _errorMessaagePassword =
                        "Password Length must be more than 6";
                  else {
                    _errorMessaagePassword = null;
                  }
                });
              },
            ),

            vSpacing,

            ElevatedButton(
              onPressed: () {
                String username = _usernameControoller.text;
                String password = _passwordControoller.text;

                if (username.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please fill the username and password"),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                if (_errorMessaageUsername != null ||
                    _errorMessaagePassword != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Please fix the wrong inputs"),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                String currUsername = _usernameControoller.text;
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Login Success"),
                      content: Text("Welcome on board, ${currUsername}"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Homepage(
                                    username: _usernameControoller.text,
                                  );
                                },
                              ),
                              (route) => false,
                            );
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text("Login"),
            ),

            vSpacing,
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:navigation/auth_service.dart';
import 'signup.dart';


import 'dart:math' as Math;

class LoginPage extends StatefulWidget {

  const LoginPage({super.key}); 

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String getFormattedEmail(String input) {
    return '$input@uw.edu';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/huskies.png', height: 100),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                suffixText: '@uw.edu',
              ),
              autocorrect: false,
              enableSuggestions: false,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
              obscureText: _obscureText,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await AuthService().signin(context: context, email: getFormattedEmail(_emailController.text), password: _passwordController.text);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, overlayColor: Colors.white),
              child: const Text(style:TextStyle(color: Colors.white), 'Login')
            ),
            TextButton(
              onPressed: () {
                Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupPage()),
                );
              });
              },
              child: const Text('Need to create an account? Register'),
            ),
          ],
        ),
      ),
    );
  }
}




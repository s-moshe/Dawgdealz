import 'package:flutter/material.dart';
import 'package:navigation/auth_service.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                suffixText: '@uw.edu',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: GestureDetector(
                  onTapDown: (_) {
                    setState(() {
                      _obscureText = false;
                    });
                  },
                  onTapUp: (_) {
                    setState(() {
                      _obscureText = true;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              obscureText: _obscureText,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                AuthService().signin(
                  context: context,
                  email: '${_emailController.text}@uw.edu',
                  password: _passwordController.text,
                );
              },
              child: const Text('Sign In'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()),
                );
              },
              child: const Text('Need to create an account? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

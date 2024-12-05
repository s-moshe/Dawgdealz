import 'package:flutter/material.dart';
import 'package:navigation/auth_service.dart';
import 'login.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key}); 
  
  @override
  SignupPageState createState() => SignupPageState();
}

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class SignupPageState extends State<SignupPage> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
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
            const Text('Your password must be at least 6 characters long!'),
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
                AuthService().signup(
                  context: context,
                  email: '${_emailController.text}@uw.edu',
                  password: _passwordController.text,
                );
              },
              child: const Text('Sign Up'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text('Need to login? Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}

   
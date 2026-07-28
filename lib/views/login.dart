import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dashboard_app/views/dashboard.dart';
import 'package:dashboard_app/views/registration.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  String _msg = "not saved login yet";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(237, 3, 12, 28),
      appBar: AppBar(
        title: const Text('login page'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo / Title
                  Icon(Icons.person_rounded),
                  const SizedBox(height: 8),
                  const Text(
                    'login',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Sign in to continue',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 28),

                  // Email field
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'you@example.com',
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Password field
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      // suffixIcon: IconButton(
                      //   icon: Icon(
                      //     _obscurePassword
                      //         ? Icons.visibility_off
                      //         : Icons.visibility,
                      //   ),
                      //   onPressed: () {
                      //     setState(() {
                      //       _obscurePassword = !_obscurePassword;
                      //     });
                      //   },
                      // ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Forgot password (dummy)
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: TextButton(
                  //     onPressed: () {},
                  //     child: const Text('Forgot password?'),
                  //   ),
                  // ),
                  // const SizedBox(height: 8),

                  // Login button
                  ElevatedButton(
                    onPressed: () {
                      // //  validation: if both fields are non-empty, navigate to  dashboard
                      // if (_emailController.text.isNotEmpty &&
                      //     _passwordController.text.isNotEmpty) {
                      //   Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (_) => const DashboardPage(),
                      //     ),
                      //   );
                      // } else {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(
                      //       content: Text('Please fill in all fields'),
                      //       backgroundColor: Colors.red,
                      //     ),
                      //   );
                      // }
                      login();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text('Login', style: TextStyle(fontSize: 18)),
                  ),
                  const SizedBox(height: 16),

                  // Register navigation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const RegisterPage(),
                            ),
                          );
                        },
                        child: const Text('Register'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Text(
                    _msg,
                    style: TextStyle(
                      fontSize: 50,
                      color: const Color.fromARGB(255, 103, 130, 117),
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

  void login() async {
    String url = "http://localhost/app1/login.php";
    final Map<String, dynamic> queryParams = {
      'username': _nameController.text,
      'password': _passwordController.text,
    };
    try {
      http.Response response = await http.get(
        Uri.parse(url).replace(queryParameters: queryParams),
      );
      if (response.statusCode == 200) {
        var user = jsonDecode(response.body);
        if (user.isNotEmpty) {
          setState(() {
            _msg = response.body;
          });
        } else {
          setState(() {
            _msg = "invalid username or password";
          });
        }
      } else {
        print('error : ${response.statusCode}');
      }
    } catch (error) {
      print("your cooked");
    }
  }
}

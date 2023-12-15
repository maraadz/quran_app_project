import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quranapp_project/controller/firebase_AuthController.dart';
import 'package:quranapp_project/shared/shared.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  final _emailTextfieldcontroller = TextEditingController();
  final _passwordTextfieldcontroller = TextEditingController();
  final FirebaseAuthController _auth = FirebaseAuthController();

  void dispose() {
    // TODO: implement dispose
    _emailTextfieldcontroller.dispose();
    _passwordTextfieldcontroller.dispose();
    super.dispose();
  }

  void signIn() async {
    String email = _emailTextfieldcontroller.text;
    String password = _passwordTextfieldcontroller.text;
    User? user = await _auth.loginwithEmailandPassword(email, password);
    if (user != null) {
      print("Login Success");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Login Success!"),
        backgroundColor: Colors.green,
      ));
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/',
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error Register! Try again"),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              SizedBox(
                height: 200,
              ),
              const Spacer(),
              const Text(
                "LOGIN",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _emailTextfieldcontroller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Email"),
                  prefixIcon: Icon(
                    Icons.email,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _passwordTextfieldcontroller,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  label: const Text("Password"),
                  prefixIcon: const Icon(
                    Icons.password,
                    size: 30,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    child: Icon(_isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MainColor,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: signIn,
                child: const Text("Login"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't Have an Account ? "),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/register'),
                    child: const Text("Register"),
                    style: TextButton.styleFrom(
                      foregroundColor: MainColor,
                    ),
                  )
                ],
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}

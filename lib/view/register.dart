import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quranapp_project/controller/firebase_AuthController.dart';
import 'package:quranapp_project/shared/shared.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isPasswordVisible = false;
  final _emailTextfieldcontroller = TextEditingController();
  final _passwordTextfieldcontroller = TextEditingController();
  final _fullnameTextfieldcontroller = TextEditingController();
  final _usernameTextfieldcontroller = TextEditingController();
  final FirebaseAuthController _auth = FirebaseAuthController();

  @override
  void dispose() {
    _emailTextfieldcontroller.dispose();
    _passwordTextfieldcontroller.dispose();
    _fullnameTextfieldcontroller.dispose();
    _usernameTextfieldcontroller.dispose();
    super.dispose();
  }

  void signup() async {
    String email = _emailTextfieldcontroller.text;
    String password = _passwordTextfieldcontroller.text;
    String fullname = _fullnameTextfieldcontroller.text;
    String username = _usernameTextfieldcontroller.text;

    User? user = await _auth.registerwithEmailandPassword(
        email, password, fullname, username);
    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Register Success!"),
        backgroundColor: Colors.green,
      ));
      Navigator.pop(context, '/login');
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
                height: 150,
              ),
              const Spacer(),
              const Text(
                "SIGN UP",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _fullnameTextfieldcontroller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Fullname"),
                  prefixIcon: Icon(
                    Icons.person,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _usernameTextfieldcontroller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Username"),
                  prefixIcon: Icon(
                    Icons.alternate_email,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
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
                    Icons.lock,
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
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: MainColor,
                ),
                onPressed: signup,
                child: const Text("Sign Up"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already Have an Account ? "),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Login"),
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

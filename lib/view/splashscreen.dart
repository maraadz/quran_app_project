import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quranapp_project/view/login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
          (route) => false);
    });

    return Scaffold(
      body: Center(
        child: Container(
          height: 350,
          width: 350,
          child: Image.asset(
            'assets/splashart.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

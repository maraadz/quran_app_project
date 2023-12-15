import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quranapp_project/controller/firebase_AuthController.dart';
import 'package:quranapp_project/firebase_options.dart';
import 'package:quranapp_project/view/home.dart';
import 'package:quranapp_project/view/login.dart';
import 'package:quranapp_project/view/register.dart';
import 'package:quranapp_project/view/splashscreen.dart';
import 'package:quranapp_project/view/surah.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final authController = FirebaseAuthController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: authController.authStatus,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return MaterialApp(
              title: 'Flutter Demo',
              initialRoute: snapshot.data != null ? '/' : '/login',
              routes: {
                '/': (context) => HomeScreen(),
                '/login': (context) => LoginPage(),
                '/register': (context) => RegisterPage(),
                '/surah': (context) => SurahDetail(),
              },
            );
          }
          return const Loading();
        });
  }
}

class Loading extends StatelessWidget {
  const Loading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

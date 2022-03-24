import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_trinity/screens/home.dart';
import 'package:project_trinity/screens/login.dart';
import 'package:project_trinity/screens/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const HomePage()),
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/signup', page: () => const SignUpPage()),
      ],
    );
  }
}

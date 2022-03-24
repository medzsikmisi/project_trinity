import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController username = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginPage'),
      ),
      body: Center(
        child: SizedBox(
            width: (Get.size.width.toDouble() * 0.5),
            child: TextField(
              decoration: const InputDecoration(
                  labelText: 'Username', border: OutlineInputBorder()),
              controller: username,
            )),
      ),
    );
  }
}

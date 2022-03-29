import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_trinity/controllers/login_controller.dart';
import 'package:project_trinity/utils/managers/authentication.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginPage'),
      ),
      body: Center(
        child: Form(
          key: controller.key.value,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: (Get.size.width.toDouble() * 0.5),
                    child: Obx(() => TextFormField(
                          validator: (v) {
                            if (v?.isEmpty ?? true) {
                              return 'Enter your username';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: 'Username',
                              border: OutlineInputBorder()),
                          controller: controller.username.value,
                        ))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: (Get.size.width.toDouble() * 0.5),
                    child: Obx(() => TextFormField(
                          validator: (v) {
                            if (v?.isEmpty ?? false) {
                              return 'Enter your password';
                            }
                            return null;
                          },
                          obscureText: true,
                          decoration: const InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder()),
                          controller: controller.password.value,
                        ))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: login, child: const Text('Login')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    onPressed: () => Get.offNamed('/signup'),
                    child: const Text('Sign up')),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    final valid = controller.key.value.currentState?.validate();
    if (!(valid ?? false)) return;
    final auth = Authenticator();
    final result = await auth.login(controller.username.value.text, controller.password.value.text);
    if(result)Get.offNamed('/');
  }
}

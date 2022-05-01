import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fzregex/fzregex.dart';
import 'package:fzregex/utils/pattern.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:project_trinity/controllers/signup_controller.dart';

import '../utils/managers/authentication.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  final controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SelectableText('LoginPage'),
      ),
      body: Center(
        child: Form(
          key: controller.key.value,
          child: SingleChildScrollView(
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
                                return 'Enter your full name';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                labelText: 'Full name',
                                border: OutlineInputBorder()),
                            controller: controller.name.value,
                          ))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: (Get.size.width.toDouble() * 0.5),
                      child: Obx(() => TextFormField(
                            validator: (s) {
                              if (!Fzregex.hasMatch(
                                  s.toString(), FzPattern.email)) {
                                return 'Type a real email address.';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder()),
                            controller: controller.email.value,
                          ))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: (Get.size.width.toDouble() * 0.5),
                      child: Obx(() => TextFormField(
                            validator: (v) {
                              if (v?.isEmpty ?? true) {
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
                  child: SizedBox(
                      width: (Get.size.width.toDouble() * 0.5),
                      child: Obx(() => TextFormField(
                            validator: (v) {
                              if (v?.isEmpty ?? true) {
                                return 'Enter your password again';
                              }
                              if (controller.password.value.text != v) {
                                return 'Passwords don\'t match.';
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: const InputDecoration(
                                labelText: 'Password confirmation',
                                border: OutlineInputBorder()),
                            controller: controller.password2.value,
                          ))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: (Get.size.width.toDouble() * 0.5),
                      child: Row(
                        children: [
                          Obx(() => SizedBox(
                                width: Get.width * 0.3,
                                child: TextFormField(
                                  validator: (s) {
                                    if (s?.isEmpty ?? false)
                                      return 'Type a country.';
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      labelText: 'Country',
                                      border: OutlineInputBorder()),
                                  controller: controller.country.value,
                                ),
                              )),
                          Obx(() => SizedBox(
                                width: Get.width * 0.2,
                                child: TextFormField(
                                  validator: (s) {
                                    if (s?.isEmpty ?? false)
                                      return 'Type a ZIP.';
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      labelText: 'ZIP',
                                      border: OutlineInputBorder()),
                                  controller: controller.zip.value,
                                ),
                              )),
                        ],
                      )),
                ),
                Obx(() => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: Get.width * 0.5,
                        child: TextFormField(
                          validator: (s) {
                            if (s?.isEmpty ?? false) return 'Type a city';
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: 'City', border: OutlineInputBorder()),
                          controller: controller.city.value,
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: (Get.size.width.toDouble() * 0.5),
                      child: Obx(() => TextFormField(
                            validator: (s) {
                              if (s?.isEmpty ?? false)
                                return 'Type a street and a number.';
                              return null;
                            },
                            decoration: const InputDecoration(
                                labelText: 'Street and number',
                                border: OutlineInputBorder()),
                            controller: controller.streetAndNumber.value,
                          ))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: signup, child: const Text('Sign up')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      onPressed: () {
                        Get.offNamed('/login');
                      },
                      child: const Text('Login')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signup() async {
    final valid = controller.key.value.currentState?.validate();
    if (!(valid ?? false)) return;
    final auth = Authenticator();
    final result = await auth.register(
        controller.email.value.text,
        controller.password.value.text,
        controller.name.value.text,
        controller.country.value.text,
        controller.zip.value.text,
        controller.streetAndNumber.value.text,
        controller.city.value.text);
    if (!result) {
      Fluttertoast.showToast(msg: 'Wrong credentials!');
      return;
    }
    final box = await Hive.openBox('settings');
    box.put('isLoggedIn', true);
    Get.offNamed('/');
  }
}

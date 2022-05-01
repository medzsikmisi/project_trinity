import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:project_trinity/controllers/order_controller.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        UserAccountsDrawerHeader(
            accountName: Text(Hive.box('settings').get('username').toString()),
            accountEmail: const SizedBox.shrink()),
        createButton('Home', () async {
          Get.back();
          Get.offNamed('/');
        }),
        createButton('Order a new server', () async {
          final controller = Get.find<OrderController>();
          controller.loadData();
          Get.back();
          Get.offNamed('/servers/new');
        }),
        createButton('Hostname lookup', () async {
          Get.back();
          Get.offNamed('/lookup');
        }),
        createButton('Owned servers', () async {
          Get.back();
          Get.offNamed('/owned');
        }),
        createButton('Profile', () async {
          Get.back();
          Get.offNamed('/profile');
        }),
        createButton('Log out', () async {
          Get.back();
          Get.offNamed('/login');
        }),
      ]),
    );
  }

  Widget createButton(String name, action) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        child: Text(name),
        onPressed: action,
      ),
    );
  }
}

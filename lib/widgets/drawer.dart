import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        const UserAccountsDrawerHeader(
            accountName: Text('Almafa123'), accountEmail: SizedBox.shrink()),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            child: const Text('Home'),
            onPressed: () async {
              Get.offNamed('/');
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            child: const Text('Hostname lookup'),
            onPressed: () async {
              Get.offNamed('/lookup');
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            child: const Text('Owned servers'),
            onPressed: () async {
              Get.offNamed('/owned');
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            child: const Text('Log out'),
            onPressed: () async {
              await Hive.deleteFromDisk();
              Get.offNamed('/login');
            },
          ),
        ),
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_trinity/controllers/owned_servers_controller.dart';
import 'package:project_trinity/widgets/drawer.dart';
import 'package:project_trinity/widgets/trinity.dart';

class OwnedServersPage extends StatelessWidget {
  OwnedServersPage({Key? key}) : super(key: key);
  final controller = Get.put(OwnedServersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Owned Servers'),
      ),
      drawer: const CustomDrawer(),
      body: ListView(
        children: [
          const TrinityLogo(),
          Obx(() => Column(
              children: List.generate(
                  controller.servers.length,
                  (index) => const ListTile(
                        title: Text('a'),
                      ))))
        ],
      ),
    );
  }
}

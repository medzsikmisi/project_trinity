import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_trinity/controllers/owned_servers_controller.dart';
import 'package:project_trinity/widgets/drawer.dart';
import 'package:project_trinity/widgets/trinity.dart';

class OwnedServersPage extends StatelessWidget {
  OwnedServersPage({Key? key}) : super(key: key);
  final controller = Get.find<OwnedServersController>();

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
                  (i) => Card(
                        child: SizedBox(
                          width: Get.width * 0.8,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Name'),
                                    Text(controller.servers[i].name.toString())
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Capacity'),
                                    Text(controller.servers[i].capacity
                                        .toString())
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Price'),
                                    Text(controller.servers[i].price.toString()+' HUF')
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))))
        ],
      ),
    );
  }
}

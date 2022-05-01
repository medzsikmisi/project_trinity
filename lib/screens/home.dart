import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_trinity/controllers/order_controller.dart';
import 'package:project_trinity/controllers/owned_servers_controller.dart';
import 'package:project_trinity/widgets/drawer.dart';
import 'package:project_trinity/widgets/trinity.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const SelectableText('HomePage'),
        ),
        drawer: const CustomDrawer(),
        body: ListView(
          children: [
            const TrinityLogo(),
            SizedBox(
              height: Get.height * 0.2,
            ),
            Expanded(
                child: Center(
              child: SizedBox(
                height: Get.height * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextButton(
                        child: Text('New order'),
                        onPressed: () {
                          final controller = Get.find<OrderController>();
                          controller.loadData();
                          Get.offNamed('/servers/new');
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextButton(
                          child: Text('My orders'),
                          onPressed: () async {
                            final controller =
                                Get.find<OwnedServersController>();
                            await controller.loadServers();

                            Get.offNamed('/owned');
                          }),
                    ),
                  ],
                ),
              ),
            ))
          ],
        ));
  }
}

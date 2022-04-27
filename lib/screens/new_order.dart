import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_trinity/controllers/order_controller.dart';
import 'package:project_trinity/utils/managers/order_manager.dart';
import 'package:project_trinity/widgets/drawer.dart';
import 'package:project_trinity/widgets/trinity.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class NewOrderPage extends StatelessWidget {
  NewOrderPage({Key? key}) : super(key: key);
  final controller = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('New order'),
        ),
        drawer: const CustomDrawer(),
        body: ListView(children: [
          TrinityLogo(),
          Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  controller.servers.length,
                  (i) => Card(
                        child: SizedBox(width: Get.width*0.8,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Name'),
                                    Text(controller.servers[i].name.toString())
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Capacity'),
                                    Text(controller.servers[i].capacity.toString())
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Price'),
                                    Text(controller.servers[i].price.toString())
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RoundedLoadingButton(
                                    controller: controller.buttonController.value,
                                    onPressed: () {},
                                    child: Text('Order')),
                              )
                            ],
                          ),
                        ),
                      )),
            ),
          ),
        ]));
  }

  fetchServers() async {
    controller.loading.toggle();
    final result = await OrderManager().fetchServers();
    controller.servers = result.obs;
    controller.loading.toggle();
  }
}

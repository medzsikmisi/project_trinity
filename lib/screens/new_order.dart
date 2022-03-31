import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_trinity/controllers/order_controller.dart';
import 'package:project_trinity/utils/managers/order_manager.dart';
import 'package:project_trinity/widgets/drawer.dart';
import 'package:project_trinity/widgets/trinity.dart';

class NewOrderPage extends StatelessWidget {
  NewOrderPage({Key? key}) : super(key: key);
  final controller = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('New order'),
        ),
        drawer: const CustomDrawer(),
        body: ListView(children: [
          TrinityLogo(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * 0.2,
              ),
              Obx(() => SizedBox(
                    width: Get.width * 0.4,
                    child: DropdownSearch<String>(
                      enabled: !controller.loading.value,
                      showSelectedItems: true,
                      onSaved: (_) {
                        controller.result.value = _.toString();
                      },
                      items: [
                        "Rackhost prémium server 10TB",
                        "Dell server 10 TB",
                        'Virtuális szerver 5 TB',
                        'Virtuális szerver 10 TB',
                        'Virtuális szerver 1 TB',
                        'Virtuális szerver 20 TB',
                        'Dell Szerver 20 TB,Google virtuális szerver 50 TB'
                      ],
                      selectedItem: controller.result.value,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: () {}, child: Text('Order')),
              )
            ],
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

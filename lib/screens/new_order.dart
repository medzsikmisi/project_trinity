import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_trinity/controllers/order_controller.dart';
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
      body: ListView(
        children: [
          TrinityLogo(),Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * 0.2,
              ),
              Obx(() => SizedBox(
                    width: Get.width * 0.4,
                    child: DropdownSearch<String>(enabled: !controller.loading.value,
                      showSelectedItems: true,
                      onSaved: (_) {
                        controller.result.value = _.toString();
                      },
                      items:controller.servers.value.map((e) => e.processor.toString()).toList(),
                      selectedItem: controller.result.value,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: () {}, child: Text('Order')),
              )
            ],
          ),
          Visibility(child: const Center(child:CircularProgressIndicator()),visible: controller.loading.value,)],
          )
        ],
      ),
    );
  }
}

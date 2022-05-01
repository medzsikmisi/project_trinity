import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:project_trinity/utils/managers/order_manager.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../models/server.dart';

class OrderController extends GetxController {
  Rx<String> result = ''.obs;
  RxBool loading = false.obs;
  RxList<Server> servers = <Server>[].obs;
  RxMap<String,RoundedLoadingButtonController> buttonControllers = RxMap();

  Future<void> loadData() async {
    loading.value = true;
    servers.value = await OrderManager().fetchServers();
    servers.forEach((element) {
      buttonControllers[element.id.toString()]=RoundedLoadingButtonController();
    });
    loading.value = false;
  }

  Future<bool> placeNewOrder(String serverId) async {
    Get.log('Placing order for a server with id: $serverId.');
    if (Hive.isBoxOpen('settings')) {
      Get.log('Box is not open');
      await Hive.openBox('settings');
    }
    Get.log('Hive box is open');
    final box = Hive.box('settings');
    final userId = box.get('userId');
    Get.log('User: $userId');
    final result = OrderManager().orderServer(serverId, userId);
    return result;
  }
}

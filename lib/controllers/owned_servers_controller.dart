import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:project_trinity/models/server.dart';
import 'package:project_trinity/utils/managers/order_manager.dart';

class OwnedServersController extends GetxController {
  RxList<Server> servers = <Server>[].obs;

  Future<void> loadServers() async {
    if (Hive.isBoxOpen('settigns')) {
      await Hive.openBox('settings');
    }
    final box = Hive.box('settings');
    final id = box.get('userId');
    final result = await OrderManager().fetchOrders(id);

    servers.value = result;
  }
}

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:project_trinity/utils/managers/order_manager.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../models/server.dart';

class OrderController extends GetxController {
  Rx<String> result = ''.obs;
  RxBool loading = false.obs;
  RxList<Server> servers = <Server>[].obs;
  final buttonController = RoundedLoadingButtonController().obs;

  Future<void> loadData() async {
    loading.value = true;
    servers.value = await OrderManager().fetchServers();
    loading.value = false;
  }

  Future<bool> placeNewOrder(String serverId) {
    if(Hive.isBoxOpen())
    OrderManager().orderServer(serverId, userId)
  }
}

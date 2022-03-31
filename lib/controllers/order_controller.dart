import 'package:get/get.dart';
import '../models/server.dart';
class OrderController extends GetxController {
  Rx<String> result = ''.obs;
  RxBool loading = false.obs;
  RxList<Server> servers = <Server>[].obs;
}

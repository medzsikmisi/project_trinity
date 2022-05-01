import 'package:get/get.dart';

import '../../models/server.dart';

class OrderManager extends GetConnect {
  OrderManager() {
    baseUrl = 'http://localhost:8080/api';
  }

  Future<List<Server>> fetchServers() async {
    final response = await get('/fetchservers.php');
    if (response.body == null ||
        response.statusCode != 200 ||
        !(response.body?['success'] ?? false)) return [];
    final body = response.body;
    final servers =
        body['data'].cast<Map<String, dynamic>>() as List<Map<String, dynamic>>;
    final returned = servers.map((e) => Server.fromJson(e)).toList();
    print(returned);
    return returned;
  }

  Future<bool> orderServer(String serverId, String userId) async {
    final response = await get('/placeneworder.php',
        query: {'user_id': userId, 'server_id': serverId});
    if (response.body == null) return false;
    final success = response.body['success'] ?? false;
    return success;
  }
}

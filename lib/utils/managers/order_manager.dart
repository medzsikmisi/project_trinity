import 'package:get/get.dart';

import '../../models/server.dart';

class OrderManager extends GetConnect {
  Future<List<Server>> fetchServers() async {
    final response = await post('http://localhost/api/fetchservers.php', {});
    final List<Map<dynamic, dynamic>> servers = response.body["servers"];
    return servers
        .map((e) => Server(
            id: e['id'], processor: e['processor'], location: e['location']))
        .toList();
  }
}

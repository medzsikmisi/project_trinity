import 'package:get/get.dart';

class LookupManager extends GetConnect {
  LookupManager() {
    baseUrl = 'http://localhost:8080/api/';
  }

  Future<bool> lookUp(String hostname) async {
    final response = await get('check_domain.php', query: {'name': hostname});
    final isFree = response.body?['available'];
    if (isFree == true) return true;
    return false;
  }
}

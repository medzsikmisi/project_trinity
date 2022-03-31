import 'package:get/get.dart';

class LookupManager extends GetConnect {
  Future<bool> lookUp(String hostname) async {
    final result =
        await post('http://localhost/api/lookup.php', {'hostname': hostname});
    final isFree = result.body['free'];
    if (isFree == true) return true;
    return false;
  }
}

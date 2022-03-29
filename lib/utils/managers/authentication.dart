import 'package:get/get.dart';

class Authenticator extends GetConnect {
  Future<bool> login(String username, String password) async {
    final response = await post('http://localhost/api/login.php',
        {'username': username, 'password': password});
    final bool? success = response.body['success']=='true';
    if (success ?? false) return true;
    return false;
  }
  Future<bool> register(String username, String password) async {
    final response = await post('http://localhost/api/register.php',
        {'username': username, 'password': password});
    final bool? success = response.body['success']=='true';
    if (success ?? false) return true;
    return false;
  }
}

import 'package:get/get.dart';

class Authenticator extends GetConnect {
  Authenticator() {
    baseUrl = 'http://localhost/api';
  }

  Future<bool> login(String username, String password) async {
    final response =
    await post('/login.php', {'username': username, 'password': password});
    print(response.body);

    final bool? success = response.body?['success'] == 'true';
    if (success ?? false) return true;
    return false;
  }

  Future<bool> register(String email, String password, String fullName,
      String country, String zip, String streetAndNumber) async {
    final response =
    await post('/register.php', {'email': email, 'password': password});
    final bool? success = response.body['success'] == 'true';
    if (success ?? false) return true;
    return false;
  }
}

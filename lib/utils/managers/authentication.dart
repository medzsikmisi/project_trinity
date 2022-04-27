import 'package:get/get.dart';

class Authenticator extends GetConnect {
  Authenticator() {
    baseUrl = 'http://localhost:8080/api';
  }

  Future<bool> login(String username, String password) async {
    Get.log('email:$username,password: $password');
    final response = await get('/login.php',
        query: {'email': username, 'password': password});
    print('body:${response.body}');
    Get.log('Request arrived with response code: ${response.statusCode}');
    final bool? success = (response.body as Map?)?['success'] ;
    if (success ?? false) return true;
    return false;
  }

  Future<bool> register(String email, String password, String fullName,
      String country, String zip, String streetAndNumber) async {
    final response = await get('/register.php', query: {
      'email': email,
      'password': password,
      'full_name': fullName,
      'country': country,
      'zip_code': zip,
      'street_and_number': streetAndNumber,
      'city':'HUN'
    });
    final bool? success = response.body['success'] ;
    if (success ?? false) return true;
    return false;
  }
}

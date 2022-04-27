import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginController extends GetxController {
  final buttonController = RoundedLoadingButtonController().obs;
  Rx<GlobalKey<FormState>> key = GlobalKey<FormState>().obs;
  Rx<TextEditingController> username = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
}

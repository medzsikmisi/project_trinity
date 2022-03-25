import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  Rx<GlobalKey<FormState>> key = GlobalKey<FormState>().obs;
  Rx<TextEditingController> username = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
  Rx<TextEditingController> password2 = TextEditingController().obs;
  Rx<TextEditingController> email = TextEditingController().obs;
}

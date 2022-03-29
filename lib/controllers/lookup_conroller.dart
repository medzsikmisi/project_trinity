import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LookupController extends GetxController {
  Rx<bool?> available = null.obs;
  Rx<TextEditingController> hostname = TextEditingController().obs;
}

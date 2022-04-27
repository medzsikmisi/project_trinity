import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_trinity/controllers/lookup_conroller.dart';
import 'package:project_trinity/utils/managers/lookup_manager.dart';
import 'package:project_trinity/widgets/drawer.dart';
import 'package:project_trinity/widgets/trinity.dart';

class HostLookupPage extends StatelessWidget {
  HostLookupPage({Key? key}) : super(key: key);

  final controller = Get.put(LookupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const SelectableText('Host Lookup'),
        ),
        drawer: const CustomDrawer(),
        body: ListView(
          children: [
            const TrinityLogo(),
            SizedBox(
              height: Get.height * 0.2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Get.width * 0.4,
                  child: Obx(() {
                    return TextField(
                      controller: controller.hostname.value,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Type in a hostname')),
                    );
                  }),
                ),
                IconButton(
                    onPressed: () async {
                      final manager = LookupManager();
                      final result =
                          await manager.lookUp(controller.hostname.value.text);
                      Get.snackbar('SUCCESSFUL HOSTNAME LOOKUP',
                          'This hostname is${result ? "" : "n't"} available.',
                          backgroundColor: Colors.greenAccent,
                          colorText: Colors.black);
                    },
                    icon: const Icon(FontAwesomeIcons.magnifyingGlass))
              ],
            )
          ],
        ));
  }
}

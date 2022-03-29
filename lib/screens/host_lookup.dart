import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_trinity/controllers/lookup_conroller.dart';
import 'package:project_trinity/widgets/drawer.dart';
import 'package:project_trinity/widgets/trinity.dart';

class HostLookupPage extends StatelessWidget {
  HostLookupPage({Key? key}) : super(key: key);

  final controller = Get.put(LookupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Host Lookup'),
        ),
        drawer: const CustomDrawer(),
        body: ListView(
          children: [
            const TrinityLogo(),
            const SizedBox(
              height: 200,
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
                    onPressed: () {},
                    icon: const Icon(FontAwesomeIcons.magnifyingGlass))
              ],
            )
          ],
        ));
  }
}

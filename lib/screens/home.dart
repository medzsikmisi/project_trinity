import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_trinity/widgets/drawer.dart';
import 'package:project_trinity/widgets/trinity.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const SelectableText('HomePage'),
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
              children: const [Text('Under development...',style: TextStyle(color: Colors.red),)],
            )
          ],
        ));
  }
}

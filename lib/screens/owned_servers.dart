import 'package:flutter/material.dart';
import 'package:project_trinity/widgets/drawer.dart';

class OwnedServersPage extends StatelessWidget {
  const OwnedServersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Owned Servers'),
      ),
      drawer: const CustomDrawer(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:project_trinity/widgets/drawer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SelectableText('Profile'),
      ),
      drawer: const CustomDrawer(),
      body: const Center(
        child: Text('Under development.'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:project_trinity/screens/home.dart';
import 'package:project_trinity/screens/host_lookup.dart';
import 'package:project_trinity/screens/login.dart';
import 'package:project_trinity/screens/owned_servers.dart';
import 'package:project_trinity/screens/signup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final settings = await Hive.openBox('settings');
  final isLoggedIn = settings.get('isLoggedIn', defaultValue: false);

  runApp(MyApp(initRoute: isLoggedIn ? '/' : '/login'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({Key? key, String initRoute = '/'})
      : initialRoute = initRoute,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      getPages: [
        GetPage(name: '/', page: () => const HomePage()),
        GetPage(name: '/login', page: () =>  LoginPage()),
        GetPage(name: '/signup', page: () =>  SignUpPage()),
        GetPage(name: '/lookup', page: () =>  HostLookupPage()),
        GetPage(name: '/owned', page: () =>  OwnedServersPage()),
      ],
      enableLog: true,
      defaultTransition: Transition.fadeIn,
      opaqueRoute: Get.isOpaqueRouteDefault,
      popGesture: Get.isPopGestureEnable,
      transitionDuration: Get.defaultDialogTransitionDuration,
    );
  }
}

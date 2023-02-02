import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:dutch_pay_it/Screens/addInfo.dart';
import 'package:dutch_pay_it/Screens/addlist.dart';
import 'package:dutch_pay_it/Screens/calculate.dart';
import 'package:dutch_pay_it/Screens/home.dart';
import 'package:dutch_pay_it/Screens/takercp.dart';
import 'package:get/get.dart';

// void main() {
//   runApp(const MyApp());
// }

void main() {
  runApp(MaterialApp(home: Scaffold(body: menuList())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: '/1', page: () => HomePage(title: '')),
        GetPage(name: '/2', page: () => AddList()),
        GetPage(name: '/3', page: () => TakeRcp()),
        GetPage(name: '/4', page: () => menuList()),
        GetPage(name: '/5', page: () => Calculate()),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: AnimatedSplashScreen(
        splash: Icons.monetization_on,
        duration: 3000,
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: HomePage(title: '목록'),
      ),
    );
  }
}


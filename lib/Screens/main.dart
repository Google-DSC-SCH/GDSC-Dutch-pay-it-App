import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:dutch_pay_it/Screens/addInfo.dart';
import 'package:dutch_pay_it/Screens/addlist.dart';
import 'package:dutch_pay_it/Screens/calculate.dart';
import 'package:dutch_pay_it/Screens/home.dart';
import 'package:dutch_pay_it/Screens/takercp.dart';
import 'package:get/get.dart';

 void main() {
   runApp(const MyApp());
 }

//void main() {
//  runApp(MaterialApp(home: Scaffold(body: MenuList(peoplelist: [],))));
//}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: '/1', page: () => const HomePage(title: '')),
        GetPage(name: '/2', page: () => const AddList()),
        GetPage(name: '/3', page: () => TakeRcp(peoplelist: const [], shop: '',)),
        GetPage(name: '/4', page: () => MenuList(peopleList: const [])),
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
        nextScreen: const HomePage(title: '목록'),
      ),
    );
  }
}


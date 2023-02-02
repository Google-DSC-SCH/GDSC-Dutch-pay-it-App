import 'package:flutter/material.dart';
import 'package:dutch_pay_it/Screens/main.dart';

import 'home.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 1500), (){});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage(
        title : 'App',
    )
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              child: Text('Duch Pay App', style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

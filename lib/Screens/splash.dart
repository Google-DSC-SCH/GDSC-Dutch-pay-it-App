import 'package:flutter/material.dart';
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
    await Future.delayed(const Duration(milliseconds: 1500), (){});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage(
        title : 'App',
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: const [
            Text('Duch Pay App', style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

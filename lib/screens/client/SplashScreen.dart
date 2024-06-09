import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int delaySeconds = 0;
  String initialRoute = '/';

  @override
  void initState() {
    super.initState();
    loadSplashConfig();
  }

  void loadSplashConfig() async {
    try {
      String jsonData =
          await rootBundle.loadString('lib/screens/client/splash_config.json');
      print("Splash config loaded: $jsonData");
      Map<String, dynamic> data = json.decode(jsonData);
      setState(() {
        delaySeconds = data['delaySeconds'];
        initialRoute = data['initialRoute'];
      });
      startTimer();
    } catch (e) {
      print("Error loading splash config: $e");
    }
  }

  void startTimer() {
    print("Timer started with $delaySeconds seconds delay");
    Timer(Duration(seconds: delaySeconds), () {
      print("Navigating to $initialRoute");
      GoRouter.of(context).go(initialRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                'assets/images/asd.gif',
                width: 200,
                height: 600,
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

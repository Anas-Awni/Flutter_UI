import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';

import 'main.dart';

class MainSplashScreen extends StatelessWidget {
  const MainSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: Scaffold(
        body: EasySplashScreen(
          backgroundColor: Colors.blueAccent,
          logo: Image.asset('images/s1.jpg'),
          logoSize: 170,
          title: const Text(
            'Title',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          showLoader: true,
          loadingText: const Text('Loading...'),
          navigator: const MyApp(),
          durationInSeconds: 0,
        ),
      ),
    );
  }
}

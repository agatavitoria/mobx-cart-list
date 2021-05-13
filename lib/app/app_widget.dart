import 'package:flutter/material.dart';
import 'pages/home/home_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MobX Cart',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}
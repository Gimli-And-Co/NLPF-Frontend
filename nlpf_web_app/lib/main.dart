import 'package:flutter/material.dart';
import 'package:nlpf_web_app/screens/dev.dart';
import 'package:nlpf_web_app/screens/profile.dart';
import 'package:nlpf_web_app/screens/home.dart';

void main() {
  runApp(App());
}


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: HomeScreen(),
      theme: ThemeData(
        primarySwatch: Colors.amber
      ),

      initialRoute: '/',
      routes: {
        '/': (context) => (HomeScreen()),
        '/home': (context) => (HomeScreen()),
        '/profile': (context) => ProfileScreen(),
        '/test':(context) => ProfileScreen(),
      },
    );
  }
}



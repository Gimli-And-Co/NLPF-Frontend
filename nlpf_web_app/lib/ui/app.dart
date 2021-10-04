import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nlpf_web_app/ui/screens/dev.dart';
import 'package:nlpf_web_app/ui/screens/map.dart';
import 'package:nlpf_web_app/ui/screens/profile.dart';
import 'package:nlpf_web_app/utils/constants/color.consts.dart';

class App extends StatelessWidget {
  static const String ACCESS_TOKEN = "pk.eyJ1IjoicHlyZCIsImEiOiJja3RteDh1aXMyOXdoMnBxbmFqMXFldXo0In0.liLIyYljrZI7V1Nw86cYXw";


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: COLOR_PRIMARY,
        accentColor: COLOR_ACCENT,
        scaffoldBackgroundColor: COLOR_SECONDARY,
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          color: COLOR_SECONDARY,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => (MapScreen()),
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
}

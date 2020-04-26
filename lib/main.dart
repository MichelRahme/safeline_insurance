import 'package:flutter/material.dart';
import 'package:safeline/screens/claim_page.dart';
import 'package:safeline/screens/coverage_page.dart';
import 'package:safeline/screens/home_page.dart';
import 'package:safeline/screens/profile_page.dart';
import 'package:safeline/screens/recent_claims_page.dart';
import 'package:safeline/screens/settings_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/claim': (context) => ClaimPage(),
        '/recent': (context) => RecentClaimsPage(),
        '/coverage': (context) => CoveragePage(),
        '/profile': (context) => ProfilePage(),
        '/settings': (context) => SettingsPage(),
      },
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

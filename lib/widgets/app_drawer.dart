import 'package:flutter/material.dart';
import 'package:safeline/app_constants.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: primary,
        child: SafeArea(
          child: ListView(),
        ),
      ),
    );
  }
}

import '../storage/app_constants.dart';
import 'package:flutter/material.dart';

//App Settings Screen
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: secondary,
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Settings"),
          color: secondary,
          textColor: whiteColor,
          onPressed: () {
            showDialog(
                context: context,
                child: new AlertDialog(
                  title: new Text("Feature Coming Soon!"),
                  content: new Text("Soen 357 Team"),
                ));
          },
        ),
      ),
    );
  }
}

import '../storage/app_constants.dart';
import 'package:flutter/material.dart';

//App Settings Screen
class RecentClaimsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recent Claims"),
        backgroundColor: secondary,
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Recent Claims"),
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

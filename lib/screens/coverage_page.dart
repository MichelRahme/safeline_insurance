import '../storage/app_constants.dart';
import 'package:flutter/material.dart';

//App Settings Screen
class CoveragePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coverage"),
        backgroundColor: secondary,
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Coverage"),
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

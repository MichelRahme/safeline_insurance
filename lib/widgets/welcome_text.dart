import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safeline/storage/app_constants.dart';

class WelcomeText extends StatefulWidget {
  @override
  _WelcomeTextState createState() => _WelcomeTextState();
}

class _WelcomeTextState extends State<WelcomeText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20.0),
      child: Container(
        width: 380,
        height: 110,
        child: RotateAnimatedTextKit(
          totalRepeatCount: 999,
          duration: Duration(seconds: 7),
          onTap: () {
            print("Tap Event");
          },
          text: [
            '''How can we help you
Today?''',
            '''Safeline 
Insurance''',
          ],
          textStyle: GoogleFonts.barlow(
              fontWeight: FontWeight.w600, fontSize: 35.0, color: onPrimary),
        ),
      ),
    );
  }
}

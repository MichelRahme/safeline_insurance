import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mlkit/mlkit.dart';
import 'package:safeline/storage/app_constants.dart' as constants;
import 'package:safeline/services/size_config.dart';
import 'package:safeline/widgets/welcome_text.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;
  static File file;
  static List<VisionText> currentLabels = <VisionText>[];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseVisionTextDetector detector = FirebaseVisionTextDetector.instance;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(
        context); //initialize Size Configuration for multi-size screen support
    return Scaffold(
      backgroundColor: constants.primary,
      body: Builder(
        builder: (ctx) => AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                WelcomeText(),
                SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          child: InkWell(
                            onTap: () {
                              containerForSheet<String>(
                                  context: ctx,
                                  child: CupertinoActionSheet(
                                      actions: <Widget>[
                                        CupertinoActionSheetAction(
                                          child: const Text("Camera"),
                                          onPressed: () async {
                                            try {
                                              var file =
                                                  await ImagePicker.pickImage(
                                                      source:
                                                          ImageSource.camera);
                                              if (file != null) {
                                                HomePage.file = file;
                                                HomePage.file =
                                                    await FlutterNativeImage
                                                        .compressImage(
                                                            file.path,
                                                            quality: 90);
                                                try {
                                                  var temp = await detector
                                                      .detectFromPath(
                                                          HomePage.file?.path);
                                                  setState(() {
                                                    HomePage.currentLabels =
                                                        temp;
                                                  });
                                                } catch (e) {
                                                  print(e.toString());
                                                }
                                                Navigator.pop(ctx);
                                                Navigator.of(context)
                                                    .pushNamed('/claim');
                                              }
                                            } catch (e) {
                                              print(e.toString());
                                            }
                                          },
                                        ),
                                        CupertinoActionSheetAction(
                                          child: const Text('Photo Library'),
                                          onPressed: () async {
                                            try {
                                              var file =
                                                  await ImagePicker.pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              if (file != null) {
                                                HomePage.file = file;
                                                HomePage.file =
                                                    await FlutterNativeImage
                                                        .compressImage(
                                                            file.path,
                                                            quality: 90);
                                                try {
                                                  var temp = await detector
                                                      .detectFromPath(
                                                          HomePage.file?.path);
                                                  setState(() {
                                                    HomePage.currentLabels =
                                                        temp;
                                                  });
                                                } catch (e) {
                                                  print(e.toString());
                                                }
                                                Navigator.pop(ctx);
                                                Navigator.of(context)
                                                    .pushNamed('/claim');
                                              }
                                            } catch (e) {
                                              print(e.toString());
                                            }
                                          },
                                        ),
                                      ],
                                      cancelButton: CupertinoActionSheetAction(
                                        child: const Text('Cancel'),
                                        isDefaultAction: true,
                                        onPressed: () {
                                          Navigator.pop(ctx);
                                        },
                                      )));
                            },
                            child: Card(
                              color: constants.secondary,
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              "Submit a Claim",
                                              style: GoogleFonts.barlow(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 33.0,
                                                  shadows: [
                                                    Shadow(
                                                      blurRadius: 1.0,
                                                      color: constants.primary
                                                          .withOpacity(0.3),
                                                      offset: Offset(1.0, 1.0),
                                                    ),
                                                  ],
                                                  color: constants.primary),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: 135.0,
                                              color: constants.primary
                                                  .withOpacity(0.25),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: GridView.count(
                            childAspectRatio: 4,
                            padding: const EdgeInsets.all(4.0),
                            mainAxisSpacing: 4.0,
                            crossAxisSpacing: 4.0,
                            crossAxisCount: 1,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed('/recent');
                                },
                                child: Card(
                                  elevation: 4.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.only(left: 25.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: Icon(
                                                    Icons.history,
                                                    size: 50.0,
                                                    color: constants.secondary
                                                        .withOpacity(0.8),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Container(
                                                  child: Text(
                                                    "Recent Claims",
                                                    style: GoogleFonts.barlow(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 23.0,
                                                        color: constants
                                                            .onPrimary
                                                            .withOpacity(0.9)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed('/coverage');
                                },
                                child: Card(
                                  elevation: 4.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.only(left: 25.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: Icon(
                                                    Icons.check_circle_outline,
                                                    size: 50.0,
                                                    color: constants.secondary
                                                        .withOpacity(0.8),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Container(
                                                  child: Text(
                                                    "Check Coverage",
                                                    style: GoogleFonts.barlow(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 23.0,
                                                        color: constants
                                                            .onPrimary
                                                            .withOpacity(0.9)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed('/profile');
                                },
                                child: Card(
                                  elevation: 4.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.only(left: 25.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: Icon(
                                                    Icons.person,
                                                    size: 50.0,
                                                    color: constants.secondary
                                                        .withOpacity(0.8),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Container(
                                                  child: Text(
                                                    "Profile",
                                                    style: GoogleFonts.barlow(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 23.0,
                                                        color: constants
                                                            .onPrimary
                                                            .withOpacity(0.9)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed('/settings');
                                },
                                child: Card(
                                  elevation: 4.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.only(left: 25.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: Icon(
                                                    Icons.settings,
                                                    size: 50.0,
                                                    color: constants.secondary
                                                        .withOpacity(0.8),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Container(
                                                  child: Text(
                                                    "Settings",
                                                    style: GoogleFonts.barlow(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 23.0,
                                                        color: constants
                                                            .onPrimary
                                                            .withOpacity(0.9)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void containerForSheet<T>({BuildContext context, Widget child}) {
    showCupertinoModalPopup<T>(
      context: context,
      builder: (BuildContext context) => child,
    );
  }
}

import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mlkit/mlkit.dart';
import 'package:safeline/screens/home_page.dart';
import 'package:safeline/storage/app_constants.dart' as constants;
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

// ignore: must_be_immutable
class ClaimPage extends StatelessWidget {
  bool safety = true;
  File _file = HomePage.file;
  List<VisionText> _currentLabels = HomePage.currentLabels;

  FirebaseVisionTextDetector detector = FirebaseVisionTextDetector.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Claim"),
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: constants.secondary,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildImage() {
    return SizedBox(
      height: 300.0,
      child: Center(
        child: _file == null
            ? SizedBox(height: 50, child: Text('No Image'))
            : FutureBuilder<Size>(
                future: _getImageSize(Image.file(_file, fit: BoxFit.fitWidth)),
                builder: (BuildContext context, AsyncSnapshot<Size> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                        child: Image.file(_file, fit: BoxFit.fill));
                  } else {
                    return Text('Detecting...');
                  }
                },
              ),
      ),
    );
  }

  Future<Size> _getImageSize(Image image) {
    Completer<Size> completer = Completer<Size>();
    image.image.resolve(ImageConfiguration()).addListener(ImageStreamListener(
        (ImageInfo info, bool _) => completer.complete(
            Size(info.image.width.toDouble(), info.image.height.toDouble()))));
    return completer.future;
  }

  Widget _buildBody(context) {
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildImage(),
            SizedBox(
              height: 10,
            ),
            _buildList(_currentLabels, context),
          ],
        ),
      ),
    );
  }

  Widget _buildList(List<VisionText> texts, context) {
    int count = 0;
    void containerForSheet<T>({BuildContext context, Widget child}) {
      showCupertinoModalPopup<T>(
        context: context,
        builder: (BuildContext context) => child,
      );
    }

    for (int i = 0; i < texts.length; i++) {
      count += texts[i].text.length;
    }

    if (texts.length == 0 || count < 15) {
      safety = false;
      return Builder(
          builder: (ctx) => Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                    Text(
                      "Could not detect text.",
                      style: GoogleFonts.barlow(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                          shadows: [
                            Shadow(
                              blurRadius: 1.0,
                              color: constants.primary.withOpacity(0.3),
                              offset: Offset(1.0, 1.0),
                            ),
                          ],
                          color: constants.onPrimary),
                    ),
                    Text(
                      "Please make sure the photo is focused",
                      style: GoogleFonts.barlow(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                          shadows: [
                            Shadow(
                              blurRadius: 1.0,
                              color: constants.primary.withOpacity(0.3),
                              offset: Offset(1.0, 1.0),
                            ),
                          ],
                          color: constants.onPrimary),
                    ),
                    Text(
                      "and is close enough.",
                      style: GoogleFonts.barlow(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                          shadows: [
                            Shadow(
                              blurRadius: 1.0,
                              color: constants.primary.withOpacity(0.3),
                              offset: Offset(1.0, 1.0),
                            ),
                          ],
                          color: constants.onPrimary),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                        color: constants.secondary,
                        child: Text(
                          "Click here to try again!",
                          style: TextStyle(color: constants.whiteColor),
                        ),
                        onPressed: () {
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
                                                  source: ImageSource.camera);
                                          if (file != null) {
                                            HomePage.file = file;
                                            HomePage.file =
                                                await FlutterNativeImage
                                                    .compressImage(file.path,
                                                        quality: 90);
                                            try {
                                              var temp =
                                                  await detector.detectFromPath(
                                                      HomePage.file?.path);
                                              HomePage.currentLabels = temp;
                                            } catch (e) {
                                              print(e.toString());
                                            }
                                            Navigator.pop(ctx);
                                            Navigator.pop(ctx);
                                            Navigator.of(ctx)
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
                                                  source: ImageSource.gallery);
                                          if (file != null) {
                                            HomePage.file = file;
                                            HomePage.file =
                                                await FlutterNativeImage
                                                    .compressImage(file.path,
                                                        quality: 90);
                                            try {
                                              var temp =
                                                  await detector.detectFromPath(
                                                      HomePage.file?.path);
                                              HomePage.currentLabels = temp;
                                            } catch (e) {
                                              print(e.toString());
                                            }
                                            Navigator.pop(ctx);
                                            Navigator.pop(ctx);
                                            Navigator.of(ctx)
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
                        })
                  ])));
    }

    return SizedBox(
      height: (texts.length <= 4)
          ? (texts.length * 350).toDouble()
          : (texts.length * 250).toDouble(),
      width: 350,
      child: Column(
        children: <Widget>[
          Text(
            "You can Click and Edit before submitting: ",
            style: GoogleFonts.barlow(
                fontWeight: FontWeight.w600,
                fontSize: 23.0,
                shadows: [
                  Shadow(
                    blurRadius: 1.0,
                    color: constants.primary.withOpacity(0.3),
                    offset: Offset(1.0, 1.0),
                  ),
                ],
                color: constants.onPrimary),
          ),
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: texts.length,
              itemBuilder: (context, i) {
                return _buildRow(texts[i].text);
              }),
          SafeArea(
            top: false,
            child: RaisedButton(
              color: safety ? constants.secondary : constants.error,
              child: Container(
                height: 50,
                width: 100,
                child: Center(
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      color:
                          safety ? constants.whiteColor : constants.onPrimary,
                    ),
                  ),
                ),
              ),
              onPressed: () {
                if (safety) Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: constants.whiteColor,
        ),
        child: TextField(
          decoration: new InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding:
                EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
          ),
          controller: TextEditingController(text: "$text"),
        ),
      ),
    );
  }
}

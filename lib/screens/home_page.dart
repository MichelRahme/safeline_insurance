import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mlkit/mlkit.dart';
import 'package:safeline/storage/app_constants.dart' as constants;
import 'package:safeline/services/size_config.dart';
import 'package:safeline/widgets/welcome_text.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File _file;
  List<VisionText> _currentLabels = <VisionText>[];

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
      body: AnnotatedRegion<SystemUiOverlayStyle>(
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
                          onTap: () {},
                          child: Card(
                            color: constants.secondary,
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Container(
//                              margin: EdgeInsets.only(left: 25.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                              onTap: () {},
                              child: Card(
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(left: 25.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                      color: constants.onPrimary
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
                              onTap: () {},
                              child: Card(
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(left: 25.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                      color: constants.onPrimary
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
                              onTap: () {},
                              child: Card(
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(left: 25.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                      color: constants.onPrimary
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
                              onTap: () {},
                              child: Card(
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(left: 25.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                      color: constants.onPrimary
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
    );
  }

  Widget button() {
    return FloatingActionButton(
      onPressed: () async {
        try {
          //var file = await ImagePicker.pickImage(source: ImageSource.camera);
          var file = await ImagePicker.pickImage(source: ImageSource.gallery);
          if (file != null) {
            setState(() {
              _file = file;
            });
            try {
              var currentLabels = await detector.detectFromPath(_file?.path);
              setState(() {
                _currentLabels = currentLabels;
              });
            } catch (e) {
              print(e.toString());
            }
          }
        } catch (e) {
          print(e.toString());
        }
      },
      child: Icon(
        Icons.add,
        color: constants.primary,
        size: 30.0,
      ),
      backgroundColor: constants.secondary,
      tooltip: "Add Claim",
    );
  }

  Widget _buildImage() {
    return SizedBox(
      height: 500.0,
      child: Center(
        child: _file == null
            ? Text('No Image')
            : FutureBuilder<Size>(
                future: _getImageSize(Image.file(_file, fit: BoxFit.fitWidth)),
                builder: (BuildContext context, AsyncSnapshot<Size> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                        foregroundDecoration:
                            TextDetectDecoration(_currentLabels, snapshot.data),
                        child: Image.file(_file, fit: BoxFit.fitWidth));
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

  Widget _buildBody() {
    return Container(
      child: Column(
        children: <Widget>[
          _buildImage(),
          _buildList(_currentLabels),
        ],
      ),
    );
  }

  Widget _buildList(List<VisionText> texts) {
    if (texts.length == 0) {
      return Text('Empty');
    }
    return Expanded(
      child: Container(
        child: ListView.builder(
            padding: const EdgeInsets.all(1.0),
            itemCount: texts.length,
            itemBuilder: (context, i) {
              return _buildRow(texts[i].text);
            }),
      ),
    );
  }

  Widget _buildRow(String text) {
    return ListTile(
      title: Text(
        "Text: $text",
      ),
      dense: true,
    );
  }
}

class TextDetectDecoration extends Decoration {
  final Size _originalImageSize;
  final List<VisionText> _texts;
  TextDetectDecoration(List<VisionText> texts, Size originalImageSize)
      : _texts = texts,
        _originalImageSize = originalImageSize;

  @override
  BoxPainter createBoxPainter([VoidCallback onChanged]) {
    return _TextDetectPainter(_texts, _originalImageSize);
  }
}

class _TextDetectPainter extends BoxPainter {
  final List<VisionText> _texts;
  final Size _originalImageSize;
  _TextDetectPainter(texts, originalImageSize)
      : _texts = texts,
        _originalImageSize = originalImageSize;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final paint = Paint()
      ..strokeWidth = 2.0
      ..color = constants.secondary
      ..style = PaintingStyle.stroke;
    print("original Image Size : $_originalImageSize");

    final _heightRatio = _originalImageSize.height / configuration.size.height;
    final _widthRatio = _originalImageSize.width / configuration.size.width;
    for (var text in _texts) {
      print("text : ${text.text}, rect : ${text.rect}");
      final _rect = Rect.fromLTRB(
          offset.dx + text.rect.left / _widthRatio,
          offset.dy + text.rect.top / _heightRatio,
          offset.dx + text.rect.right / _widthRatio,
          offset.dy + text.rect.bottom / _heightRatio);
      //final _rect = Rect.fromLTRB(24.0, 115.0, 75.0, 131.2);
      print("_rect : $_rect");
      canvas.drawRect(_rect, paint);
    }

    print("offset : $offset");
    print("configuration : $configuration");

    final rect = offset & configuration.size;

    print("rect container : $rect");

    //canvas.drawRect(rect, paint);
    canvas.restore();
  }
}

import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onlyone/Core/color_theme.dart';
import 'package:onlyone/Core/font_theme.dart';
import 'package:onlyone/models/challenge_response.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

class ChallengeShareView extends StatefulWidget {
  final ChallengeResponse challenge;

  const ChallengeShareView({Key? key, required this.challenge})
      : super(key: key);
  @override
  _ChallengeShareViewState createState() =>
      _ChallengeShareViewState(this.challenge);
}

class _ChallengeShareViewState extends State<ChallengeShareView> {
  final ChallengeResponse challenge;

  final double size = 328;
  Uint8List? _imageFile;
  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  _ChallengeShareViewState(this.challenge);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Screenshot(
                controller: screenshotController,
                child: buildView(),
              ),
            ),
            _imageFile == null ? Container() : Image.memory(_imageFile!),
            Spacer(),
            Container(
              padding: EdgeInsets.all(16),
              child: TextButton(
                onPressed: () {
                  screenshotController.capture().then((Uint8List? image) async {
                    //Capture Done
                    // setState(() {
                    //   _imageFile = image;
                    // });
                    if (image == null) {
                      return;
                    }
                    final RenderBox box =
                        context.findRenderObject() as RenderBox;
                    final directory =
                        (await getApplicationDocumentsDirectory()).path;
                    final fileName =
                        '$directory/${DateTime.now().hashCode}.png';
                    File imgFile = new File(fileName);
                    await imgFile.writeAsBytes(image);
                    // Share.shareFiles(Image.memory(image!));
                    // Share.share(image);
                    // Image.memory(image!);
                    Share.shareFiles([fileName],
                        mimeTypes: ['image/png'],
                        subject: '공유하기',
                        text: '이미지를 공유하세요.',
                        sharePositionOrigin:
                            box.localToGlobal(Offset.zero) & box.size);
                  }).catchError((onError) {
                    print(onError);
                  });
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => CreateChallengeView()));
                },
                child: Container(
                  height: 56,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text("공유하기", style: FontTheme.h4_with(Colors.white)),
                ),
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(ColorTheme.point400),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: ColorTheme.point400),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  buildView() {
    return Container(
      // color: ColorTheme.gray200,
      alignment: Alignment.bottomCenter,
      width: size, //MediaQuery.of(context).size.width - 32,
      height: size, //MediaQuery.of(context).size.width - 32,
      decoration: new BoxDecoration(
          color: Colors.green,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(40.0),
            topRight: const Radius.circular(40.0),
          )),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            child: ExtendedImage.asset(
              "images/img_certificate_bg.png",
              width: size,
              height: size,
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 129),
            alignment: Alignment.bottomCenter,
            width: 100,
            child: Material(
              child: ExtendedImage.network(
                challenge.bookResponse.thumbnailImagePath,
              ),
              elevation: 30,
            ),
          ),
          Container(
            child: ExtendedImage.asset(
              "images/img_certificate_flag.png",
              width: size,
              height: size,
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 24),
            child: Text(
              date(),
              style: FontTheme.blockquote2_with(ColorTheme.gray700),
            ),
          ),
        ],
      ),
    );
  }

  String date() {
    final startData = DateFormat('yyyy.MM.dd').format(challenge.startDate);
    final endData = DateFormat('yyyy.MM.dd').format(challenge.endDate);
    return startData + " ~ " + endData;
  }

  AppBar _buildAppBar() {
    return AppBar(
        leading: Text(""),
        leadingWidth: 10,
        title: Text(
          "",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.clear, size: 30),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Padding(padding: EdgeInsets.only(right: 10)),
        ]);
  }
}

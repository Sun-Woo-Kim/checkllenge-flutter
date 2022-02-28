// 05_MY_프로필수정_default
//
//
import 'package:flutter/material.dart';
import 'package:onlyone/Core/color_theme.dart';
import 'package:onlyone/Core/font_theme.dart';

class MyProfileImageEditView extends StatefulWidget {
  @override
  _MyProfileImageEditViewState createState() => _MyProfileImageEditViewState();
}

class _MyProfileImageEditViewState extends State<MyProfileImageEditView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              color: ColorTheme.gray300,
            )
          ],
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Image.asset("images/ic_32_arrow_left.png", height: 32),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text("프로필 수정하기", style: FontTheme.h4_with(ColorTheme.gray900)),
      backgroundColor: Colors.white,
      elevation: 0, // 그림자
    );
  }
}

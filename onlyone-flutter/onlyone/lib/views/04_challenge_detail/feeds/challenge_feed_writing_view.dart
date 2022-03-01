// 04_챌린지상세_피드_글쓰기

// FireBase Storage Test

import 'package:flutter/material.dart';
import 'package:onlyone/Core/color_theme.dart';
import 'package:onlyone/Core/font_theme.dart';

class FirebaseStorageView extends StatefulWidget {
  @override
  _FirebaseStorageViewState createState() => _FirebaseStorageViewState();
}

class _FirebaseStorageViewState extends State<FirebaseStorageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Image.network(
          "gs://checkllenge.appspot.com/feed/tXJgz5Edh0UmQ4ZMRxOkNetpZzh2",
          fit: BoxFit.fill),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        leading: IconButton(
            icon: Image.asset("images/ic_32_arrow_left.png", height: 32),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "파이어베이스 이미지 확인하기",
          style: FontTheme.h4_with(ColorTheme.gray900),
        ),
        backgroundColor: Colors.white,
        elevation: 0, // 그림자
        centerTitle: true,
        actions: [
          IconButton(
              icon: Image.asset("images/ic_32_close.png", height: 32),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              }),
          Padding(padding: EdgeInsets.only(right: 20)),
        ]);
  }
}

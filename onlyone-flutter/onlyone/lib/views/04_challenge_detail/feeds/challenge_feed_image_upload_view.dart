// 04_책린지상세_피드_사진올리기

import 'package:flutter/material.dart';
import 'package:onlyone/Core/color_theme.dart';
import 'package:onlyone/Core/font_theme.dart';

class ChallengeFeedImageUploadView extends StatefulWidget {
  @override
  _ChallengeFeedImageUploadViewState createState() =>
      _ChallengeFeedImageUploadViewState();
}

class _ChallengeFeedImageUploadViewState
    extends State<ChallengeFeedImageUploadView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(),
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
          "사진올리기",
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

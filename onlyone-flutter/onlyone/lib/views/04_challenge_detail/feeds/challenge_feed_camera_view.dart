// 04_책린지상세_피드_사진촬영

import 'package:flutter/material.dart';
import 'package:onlyone/Core/color_theme.dart';
import 'package:onlyone/Core/font_theme.dart';

class ChallengeFeedCameraView extends StatefulWidget {
  @override
  _ChallengeFeedCameraViewState createState() =>
      _ChallengeFeedCameraViewState();
}

// 상황봐서 이 창 안띄우고, default 카메라 또는 앨범 기능 있으면 그런거 활용도 생각할 수 있을 것 같네요.
// 완료되시면, iOS 쪽은 제가 확인해볼게요 - harry

class _ChallengeFeedCameraViewState extends State<ChallengeFeedCameraView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        leading: Text(""), // 감추기용
        leadingWidth: 10,
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
            onPressed: () =>
                Navigator.of(context).popUntil((route) => route.isFirst),
          ),
          Padding(padding: EdgeInsets.only(right: 20)),
        ]);
  }
}

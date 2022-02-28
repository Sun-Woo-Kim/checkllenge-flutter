// 06_책린지 뉴스 웹뷰
//
//
import 'package:flutter/material.dart';
import 'package:onlyone/Core/color_theme.dart';
import 'package:onlyone/Core/font_theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChallengeNewsWebView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        child: WebView(
          initialUrl:
              "https://www.notion.so/neolee/f1670f1b16484e409ec888fae6929035",
          javascriptMode: JavascriptMode.unrestricted,
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
            }),
      title: Text("책린지 뉴스", style: FontTheme.h4_with(ColorTheme.gray900)),
      backgroundColor: Colors.white,
      elevation: 0, // 그림자
    );
  }
}

// 04_챌린지상세_종료후_실패
import 'package:flutter/material.dart';
import 'package:onlyone/Core/color_theme.dart';
import 'package:onlyone/Core/font_theme.dart';
import 'package:onlyone/models/challenge_response.dart';
import 'package:onlyone/models/challenge_result_response.dart';
import 'package:onlyone/views/03_challenge_creation/create_challenge_view.dart';

class ChallengeFailureView extends StatefulWidget {
  final ChallengeResultResponse result;
  final ChallengeResponse challenge;

  const ChallengeFailureView({
    Key? key,
    required this.result,
    required this.challenge,
  }) : super(key: key);

  @override
  _ChallengeFailureViewState createState() =>
      _ChallengeFailureViewState(result: result, challenge: challenge);
}

class _ChallengeFailureViewState extends State<ChallengeFailureView> {
  final ChallengeResultResponse result;
  final ChallengeResponse challenge;

  _ChallengeFailureViewState({
    required this.result,
    required this.challenge,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            SizedBox(height: 10),
            Image.asset("images/img_fail_02.png"),
            SizedBox(height: 8),
            Text("아앗,,\n목표달성에 실패했어요ㅠ",
                textAlign: TextAlign.center,
                style: FontTheme.h1_with(ColorTheme.gray900)),
            SizedBox(height: 8),
            Spacer(),
            Text(
                "하지만 이번 책린지를 통해\n총 ${result.certificationTotalCount}회를 읽는 성과를 얻었습니다!",
                textAlign: TextAlign.center,
                style: FontTheme.p_with(ColorTheme.gray800)),
            SizedBox(height: 12),
            Text("다음 번엔 더 잘할것같아요.\n책린지를 한번 만들어보세요!",
                textAlign: TextAlign.center,
                style: FontTheme.p_with(ColorTheme.gray800)),
            Spacer(),
            Container(
              padding: EdgeInsets.all(16),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => CreateChallengeView()));
                },
                child: Container(
                  height: 56,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text("책린지 만들러 가기",
                      style: FontTheme.h4_with(Colors.white)),
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

  AppBar _buildAppBar() {
    return AppBar(
        leading: Text(""),
        leadingWidth: 10,
        title: Text(
          "",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.clear, size: 30),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Padding(padding: EdgeInsets.only(right: 10)),
        ]);
  }
}

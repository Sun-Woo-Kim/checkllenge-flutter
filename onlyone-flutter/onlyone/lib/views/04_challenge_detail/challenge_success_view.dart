// 04_챌린지상세_종료후_성공
import 'package:flutter/material.dart';
import 'package:onlyone/Core/color_theme.dart';
import 'package:onlyone/Core/font_theme.dart';
import 'package:onlyone/Core/network_manager.dart';
import 'package:onlyone/models/challenge_response.dart';
import 'package:onlyone/models/challenge_result_response.dart';
import 'package:onlyone/models/member_response.dart';
//import 'package:onlyone/views/03_challenge_creation/create_challenge_view.dart';
import 'package:onlyone/views/04_challenge_detail/challenge_share_view.dart';

class ChallengeSuccessView extends StatefulWidget {
  final ChallengeResultResponse result;
  final ChallengeResponse challenge;

  const ChallengeSuccessView({
    Key? key,
    required this.challenge,
    required this.result,
  }) : super(key: key);

  @override
  _ChallengeSuccessViewState createState() => _ChallengeSuccessViewState(
        result: this.result,
        challenge: this.challenge,
      );
}

class _ChallengeSuccessViewState extends State<ChallengeSuccessView> {
  final ChallengeResultResponse result;
  final ChallengeResponse challenge;
  MemberResponse? memberResponse;
  _ChallengeSuccessViewState({
    required this.result,
    required this.challenge,
  }) {
    loadMember();
  }

  loadMember() async {
    final response = await NetworkManager().getMember();
    setState(() {
      memberResponse = response.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (this.memberResponse == null) {
      return Scaffold();
    }

    final memberResponse = this.memberResponse!;

    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            SizedBox(height: 10),
            Image.asset("images/img_success.png"),
            SizedBox(height: 8),
            Text("${memberResponse.displayName}님, 축하합니다!\n목표를 달성했어요!",
                textAlign: TextAlign.center,
                style: FontTheme.h1_with(ColorTheme.gray900)),
            SizedBox(height: 8),
            Spacer(),
            Text(
                "이번 책린지를 통해\n총 ${memberResponse.successChallengeCount}회를 읽었습니다.",
                textAlign: TextAlign.center,
                style: FontTheme.p_with(ColorTheme.gray800)),
            SizedBox(height: 12),
            Text("또 다른 책린지에 도전해보세요!",
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
                          builder: (context) =>
                              ChallengeShareView(challenge: this.challenge)));
                },
                child: Container(
                  height: 56,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child:
                      Text("인증서 발급받기", style: FontTheme.h4_with(Colors.white)),
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

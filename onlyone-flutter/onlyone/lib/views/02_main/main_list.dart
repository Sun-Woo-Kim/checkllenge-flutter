// 02_main_모집중인 챌린지
import 'package:flutter/material.dart';
import 'package:onlyone/Core/color_theme.dart';
import 'package:onlyone/Core/data_manager.dart';
import 'package:onlyone/Core/font_theme.dart';
import 'package:onlyone/models/challenge_response.dart';
import 'package:onlyone/models/enum/challenge_status.dart';
import 'package:onlyone/views/01_onboarding/login_view.dart';
// import 'package:onlyone/models/challenge_info.dart';
import 'package:onlyone/views/02_main/row.dart';
import 'package:onlyone/views/03_challenge_creation/create_challenge_view.dart';
import 'package:onlyone/views/04_challenge_detail/challenge_before_view.dart';
import 'package:onlyone/views/04_challenge_detail/challenge_info_view.dart';
import 'package:provider/provider.dart';

class MainChallengeListView extends StatefulWidget {
  @override
  _MainChallengeListView createState() => _MainChallengeListView();
}

class _MainChallengeListView extends State<MainChallengeListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: _buildListView(),
    );
  }

  Widget _buildListView() {
    final challengeList = context.watch<DataManager>().challengeList;

    if (challengeList.isEmpty) {
      return Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 53),
            Align(
              child: Image.asset('images/img_main_03.png', width: 350.0),
              alignment: Alignment.bottomCenter,
            ),
            SizedBox(height: 8),
            Text(
              "모집중인 책린지가 없습니다.",
              style: FontTheme.h3_with(ColorTheme.gray800),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
        itemCount: challengeList.length,
        itemBuilder: (BuildContext context, int index) {
          Widget widget;
          if (challengeList.length == index + 1) {
            widget = Column(
              children: [_row(challengeList[index]), _suggestionView()],
            );
          } else {
            widget = _row(challengeList[index]);
          }

          if (index == 0) {
            return Container(
              margin: EdgeInsets.only(top: 32),
              child: widget,
            );
          } else {
            return widget;
          }
        });
  }

  Widget _row(ChallengeResponse challenge) {
    return GestureDetector(
      child: ChallengeRow(challenge),
      onTap: () {
        // 비로그인 예외 처리
        if (DataManager().isUserSignedIn == false) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) {
                    return LoginView();
                  }));
          return;
        }

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          if (challenge.challengeStatus == ChallengeStatus.RECRUIT) {
            return ChallengeBeforeView(challenge);
          } else {
            return ChallengeInfoView(challenge);
          }
        }))
          ..whenComplete(() => DataManager().updateChallengeList());
      },
    );
  }

  Widget _suggestionView() {
    return Container(
      child: Column(
        children: <Widget>[
          Image.asset('images/img_main_01.png', width: 280, height: 280),
          SizedBox(height: 8),
          Text(
            "원하는 책린지가 없으신가요?\n책린지를 직접 만들어서 같이 읽어보세요!",
            style: FontTheme.h5_with(ColorTheme.gray900),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) {
                        return CreateChallengeView();
                      }))
                ..whenComplete(() => DataManager().updateChallengeList());
            },
            child: Container(
              height: 48,
              width: 150,
              alignment: Alignment.center,
              child: Text("책린지 만들기", style: FontTheme.h5_with(Colors.white)),
            ),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor:
                  MaterialStateProperty.all<Color>(ColorTheme.point400),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: ColorTheme.point400),
                ),
              ),
            ),
          ),
          SizedBox(height: 90),
        ],
      ),
    );
  }
}

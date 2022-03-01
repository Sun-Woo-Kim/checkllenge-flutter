// 02_main_내 챌린지
import 'package:flutter/material.dart';
import 'package:onlyone/Core/color_theme.dart';
import 'package:onlyone/Core/data_manager.dart';
import 'package:onlyone/Core/font_theme.dart';
import 'package:onlyone/models/enum/challenge_status.dart';
import 'package:onlyone/views/01_onboarding/login_view.dart';
//import 'package:onlyone/models/challenge_info.dart';
import 'package:onlyone/views/02_main/row.dart';
import 'package:onlyone/views/04_challenge_detail/challenge_before_view.dart';
import 'package:onlyone/views/04_challenge_detail/challenge_info_view.dart';
import 'package:provider/provider.dart';

class MyChallengeListView extends StatefulWidget {
  @override
  _MyChallengeListView createState() => _MyChallengeListView();
}

class _MyChallengeListView extends State<MyChallengeListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: _buildListView(),
    );
  }

  Widget _buildListView() {
    // 로그인 체크
    if (!DataManager().isUserSignedIn) {
      return Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 53),
            Align(
              child: Image.asset('images/img_main_04.png', width: 350.0),
              alignment: Alignment.bottomCenter,
            ),
            SizedBox(height: 8),
            Text(
              "로그인이 필요합니다.",
              style: FontTheme.h3_with(ColorTheme.gray800),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) {
                          return LoginView();
                        }))
                  ..whenComplete(() => DataManager().updateChallengeList());
              },
              child: Container(
                height: 48,
                width: 150,
                alignment: Alignment.center,
                child: Text("로그인 하기", style: FontTheme.h5_with(Colors.white)),
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
            )
          ],
        ),
      );
    }

    final challengeList = context.watch<DataManager>().myChallengeList;
    if (challengeList.isEmpty) {
      return Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 53),
            Align(
              child: Image.asset('images/img_main_02.png', width: 350.0),
              alignment: Alignment.bottomCenter,
            ),
            SizedBox(height: 8),
            Text(
              "참여한 책린지가 없습니다.",
              style: FontTheme.h3_with(ColorTheme.gray800),
            )
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: challengeList.length,
      itemBuilder: (BuildContext context, int index) {
        final widget = GestureDetector(
          child: ChallengeRow(challengeList[index]),
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
              if (challengeList[index].challengeStatus ==
                  ChallengeStatus.RECRUIT) {
                return ChallengeBeforeView(challengeList[index]);
              } else {
                return ChallengeInfoView(challengeList[index]);
              }
            }))
              ..whenComplete(() => DataManager().updateChallengeList());
          },
        );

        if (index == 0) {
          return Container(
            margin: EdgeInsets.only(top: 32),
            child: widget,
          );
        } else {
          return widget;
        }
      },
    );
  }
}

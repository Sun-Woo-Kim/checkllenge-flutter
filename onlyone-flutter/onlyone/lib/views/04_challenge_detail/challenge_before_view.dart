// 04_챌린지상세_시작전_신청하기
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:onlyone/Core/color_theme.dart';
import 'package:onlyone/Core/data_manager.dart';
import 'package:onlyone/Core/font_theme.dart';
import 'package:onlyone/Core/network_manager.dart';
import 'package:onlyone/models/apply_challenge.dart';
import 'package:onlyone/models/challenge_response.dart';
import 'package:onlyone/models/enum/current_member_status.dart';
import 'package:onlyone/views/01_onboarding/login_view.dart';
import 'package:onlyone/views/04_challenge_detail/challenge_info_view.dart';
import 'package:onlyone/views/components/popup_view.dart';

import 'book_info_view.dart';

class ChallengeBeforeView extends StatefulWidget {
  final ChallengeResponse challenge;

  ChallengeBeforeView(this.challenge);

  @override
  _ChallengeBeforeView createState() => _ChallengeBeforeView(this.challenge);
}

class _ChallengeBeforeView extends State<ChallengeBeforeView> {
  late ChallengeResponse challenge;

  _ChallengeBeforeView(this.challenge) {
    // getChallenge();
  }

  getChallenge() async {
    final response =
        await NetworkManager().getChallenge(this.challenge.challengeId);
    setState(() {
      if (response.data == null) {
        return;
      }
      this.challenge = response.data!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Colors.white,
      body: _content(),
    );
  }

  Widget _content() {
    return Container(
        margin: EdgeInsets.fromLTRB(16, 8, 16, 16),
        color: Colors.white,
        // width: double.infinity,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, // 주 축 기준 중앙
            children: <Widget>[
              BookInfoView(challenge),
              SizedBox(height: 16),
              _UserInfo(challenge),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Text(challenge.challengeName,
                    style: FontTheme.h3_with(ColorTheme.gray900), maxLines: 2),
                alignment: Alignment.centerLeft,
              ),
              SizedBox(height: 8),
              _buildTypeView(),
              SizedBox(height: 16),
              Container(
                  height: 1, width: double.infinity, color: ColorTheme.gray300),
              SizedBox(height: 16),
              _UserList(challenge),
              SizedBox(height: 16),
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: double.infinity,
                    color: ColorTheme.gray200,
                    padding: EdgeInsets.all(16),
                    child: Text(
                      challenge.description,
                      style: FontTheme.p_with(ColorTheme.gray900),
                    ),
                  )),
              Spacer(),
              _bottomButton(),
              SizedBox(height: 32),
            ]));
  }

  Widget _buildTypeView() {
    var types = [challenge.period(), challenge.typeString];
    return SizedBox(
      height: 28,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: types.length,
        itemBuilder: (context, index) {
          return Container(
            height: 28,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            margin: EdgeInsets.only(right: 5),
            child: Text(
              types[index],
              style: FontTheme.blockquote2_with(ColorTheme.gray700),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.white,
              border: Border.all(width: 1.0, color: ColorTheme.gray700),
            ),
          );
        },
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
          icon: Image.asset("images/ic_32_arrow_left.png", height: 32),
          onPressed: () {
            Navigator.pop(context);
          }),
      backgroundColor: Colors.white,
      elevation: 0, // 그림자
      actions: [
        // SizedBox(
        //   height: 32,
        //   child: Bubble(
        //       // https://pub.dev/packages/bubble
        //       color: ColorTheme.point400,
        //       elevation: 4,
        //       shadowColor: ColorTheme.point400.withAlpha(255 ~/ 5),
        //       nip: BubbleNip.rightCenter,
        //       alignment: Alignment.centerRight,
        //       child: Text('친구와 함께 읽어보세요!', style: FontTheme.blockquote2)),
        // ),
        // InkWell(
        //   child: Image.asset("images/ic_32_share.png"),
        //   onTap: () {
        //     // Navigator.pop(context);
        //   },
        // ),
      ],
    );
  }

  Widget _bottomButton() {
    switch (challenge.currentMemberStatusResponse.currentMemberStatus) {

      // 모임에 속해있지 않음
      case CurrentMemberStatus.NONE:
        return Container(
          width: double.infinity,
          height: 56,
          decoration: new BoxDecoration(
              color: ColorTheme.point400,
              borderRadius: BorderRadius.circular(8)),
          child: TextButton(
            child: Text(
              "참여 신청하기",
              style: FontTheme.h4_with(Colors.white),
            ),
            onPressed: () async {
              if (!DataManager().isUserSignedIn) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginView(),
                    ));
                return;
              }

              await EasyLoading.show(maskType: EasyLoadingMaskType.black);
              final ApplyChallenge request =
                  ApplyChallenge(challengeId: challenge.challengeId);
              final response = await NetworkManager().applyChallenge(request);
              if (response.didSucceed) {
                await getChallenge();
                EasyLoading.dismiss();
                // Navigator.pop(context);
              } else {
                EasyLoading.dismiss();
                await showDialog(
                    context: context,
                    builder: (context) {
                      return PopupView(
                        title: response.error?.message,
                        action: () {
                          Navigator.pop(context);
                        },
                        actionText: "확인",
                      );
                    });
              }
            },
          ),
        );

      // 모임에 속해있음. 구성원
      case CurrentMemberStatus.BELONG:
        return Container(
          width: double.infinity,
          height: 56,
          decoration: new BoxDecoration(
              color: ColorTheme.point400,
              borderRadius: BorderRadius.circular(8)),
          child: TextButton(
            child: Text(
              "신청 취소하기",
              style: FontTheme.h4_with(Colors.white),
            ),
            onPressed: () async {
              await EasyLoading.show(maskType: EasyLoadingMaskType.black);

              final response = await NetworkManager()
                  .deleteApplyChallenge(challenge.challengeId);
              if (response.didSucceed) {
                // await getChallenge();
                Navigator.pop(context);
              } else {
                await showDialog(
                    context: context,
                    builder: (context) {
                      return PopupView(
                        title: response.error?.message,
                        action: () {
                          Navigator.pop(context);
                        },
                        actionText: "확인",
                      );
                    });
              }

              EasyLoading.dismiss();
            },
          ),
        );

      // 방장
      case CurrentMemberStatus.CREATOR:

        // 1인 인 경우 -> "바로 시작하기" | "챌린지 삭제하기"
        if (challenge.groupSize == 1) {
          return Row(children: [
            Expanded(
                child: Container(
              height: 56,
              decoration: new BoxDecoration(
                  color: ColorTheme.point400,
                  borderRadius: BorderRadius.circular(8)),
              child: TextButton(
                child: Text(
                  "바로 시작하기",
                  style: FontTheme.h4_with(Colors.white),
                ),
                onPressed: () async {
                  await EasyLoading.show(maskType: EasyLoadingMaskType.black);
                  final response = await NetworkManager()
                      .startNowChallenge(challenge.challengeId);
                  await EasyLoading.dismiss();
                  if (response.didSucceed) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ChallengeInfoView(challenge)));
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return PopupView(
                            title: response.error?.message,
                            action: () {
                              Navigator.pop(context);
                            },
                            actionText: "확인",
                          );
                        });
                  }
                },
              ),
            )),
            SizedBox(width: 10),
            Expanded(
                child: Container(
              height: 56,
              decoration: new BoxDecoration(
                  border: Border.all(
                    color: ColorTheme.point400,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(8)),
              child: TextButton(
                child: Text(
                  "챌린지 삭제하기",
                  style: FontTheme.h4_with(ColorTheme.point400),
                ),
                onPressed: () async {
                  await EasyLoading.show(maskType: EasyLoadingMaskType.black);
                  final response = await NetworkManager()
                      .deleteChallenge(challenge.challengeId);
                  await EasyLoading.dismiss();
                  if (response.didSucceed) {
                    Navigator.pop(context);
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return PopupView(
                            title: response.error?.message,
                            action: () {
                              Navigator.pop(context);
                            },
                            actionText: "확인",
                          );
                        });
                  }
                },
              ),
            ))
          ]);
        } else {
          return Container(
            // 여러명 일 경우 -> "챌린지 삭제하기"
            width: double.infinity,
            height: 56,
            decoration: new BoxDecoration(
                color: ColorTheme.point400,
                borderRadius: BorderRadius.circular(8)),
            child: TextButton(
              child: Text(
                "챌린지 삭제하기",
                style: FontTheme.h4_with(Colors.white),
              ),
              onPressed: () async {
                await EasyLoading.show(maskType: EasyLoadingMaskType.black);
                final response = await NetworkManager()
                    .deleteChallenge(challenge.challengeId);
                await EasyLoading.dismiss();
                if (response.didSucceed) {
                  Navigator.pop(context);
                } else {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return PopupView(
                          title: response.error?.message,
                          action: () {
                            Navigator.pop(context);
                          },
                          actionText: "확인",
                        );
                      });
                }
              },
            ),
          );
        }
    }
  }
}

class _UserInfo extends StatelessWidget {
  final ChallengeResponse challege;
  _UserInfo(this.challege);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _image(),
          SizedBox(width: 4),
          Text(challege.createMemberName ?? "닉네임없음",
              style: FontTheme.blockquote2_with(ColorTheme.gray800)),
        ],
      ),
    );
  }

  _image() {
    return Container(
        width: 24.0,
        height: 24.0,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.fill,
                image: new NetworkImage(challege.photoUrlList.isEmpty
                    ? ''
                    : challege.photoUrlList[0]))));
  }
}

class _UserList extends StatelessWidget {
  final ChallengeResponse? challenge;

  _UserList(this.challenge);
  @override
  Widget build(BuildContext context) {
    double profileSize = 32;
    double margin = 8;
    int maxImage = 5;

    final photoUrlList = challenge?.photoUrlList ?? [];

    // final testUrl =
    //     'https://lh3.googleusercontent.com/a-/AOh14GgZdVQn2cgN1xFyPo1fE_ijtyMQMVktWVQdB57uuKE=s96-c';
    // final photoUrlList = [testUrl, testUrl, testUrl, testUrl, testUrl, testUrl];

    return SizedBox(
      height: profileSize,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: (profileSize + margin) *
                (photoUrlList.length <= maxImage
                    ? photoUrlList.length
                    : maxImage),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List<Widget>.generate(
                photoUrlList.length,
                (index) => Padding(
                  padding: EdgeInsets.only(right: margin),
                  child: Container(
                    width: profileSize,
                    height: profileSize,
                    child: Container(
                        width: 24.0,
                        height: 24.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: new NetworkImage(photoUrlList[index])))),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text(
              photoUrlList.length <= maxImage
                  ? ''
                  : '+${photoUrlList.length - maxImage}',
              style: FontTheme.p_with(ColorTheme.gray700)),
          Spacer(),
          RichText(
            text: TextSpan(
              text: '',
              style: FontTheme.p_with(ColorTheme.gray900),
              children: <TextSpan>[
                TextSpan(
                    text: '${challenge?.currentMemberSize}명',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: ' 참여중'),
              ],
            ),
          )
        ],
      ),
    );
  }
}

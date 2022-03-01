// 05_MY

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:onlyone/Core/color_theme.dart';
import 'package:onlyone/Core/font_theme.dart';
import 'package:onlyone/Core/data_manager.dart';
import 'package:onlyone/Core/network_manager.dart';
import 'package:onlyone/models/member_response.dart';
import 'package:onlyone/views/02_main/home.dart';
import 'package:onlyone/views/05_my_info/my_nickname_edit_view.dart';
import 'package:onlyone/views/05_my_info/my_profile_image_edit_view.dart';
import 'package:onlyone/views/05_my_info/challenge_news_webview.dart';

class MyInfoView extends StatefulWidget {
  @override
  _MyInfoViewState createState() => _MyInfoViewState();
}

class _MyInfoViewState extends State<MyInfoView> {
  MemberResponse member = MemberResponse("blank", "", "", "", 0, 0, 0, "0.0");

  @override
  void initState() {
    super.initState();

    getMember();
  }

  Future getMember() async {
    final response = await NetworkManager().getMember();
    if (response.data != null) {
      setState(() {
        this.member = response.data!;
        if (this.member.displayName == "") {
          this.member.displayName = "blank";
        }
      });
    }
  }

  FutureOr onGoBack(dynamic value) {
    getMember();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        child: Column(
          children: [
            _myProfile(),
            _challengeInfo(),
            _Row(
              "책린지 소식",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChallengeNewsWebView(),
                  ),
                );
              },
            ),
            _Row(
              "서비스 문의하기",
              onPressed: () =>
                  launchBrowser("http://pf.kakao.com/_cnLxhs/chat"),
            ),
            _Row("로그아웃", onPressed: () async {
              FirebaseApp defaultApp = await Firebase.initializeApp();
              final auth = FirebaseAuth.instanceFor(app: defaultApp);
              auth.signOut();
              DataManager().isUserSignedIn = false;
              NetworkManager().logout();
              await Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ChallengeListHome()),
                  (route) => false);
            }),
            // _Row("탈퇴하기", onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget _myProfile() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          _profileImage(),
          Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(member.socialProvider, textAlign: TextAlign.left),
                ),
                Container(
                  child: Row(
                    children: [
                      Text(
                        member.displayName,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        child: Image.asset("images/ic_edit.png", height: 26),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyNicknameEditView(),
                              )).then(onGoBack);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileImage() {
    const double size = 70.0;
    return Container(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: NetworkImage(member.photoURL))),
          ),
          // GestureDetector(
          //   child: _cameraButton(),
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => MyProfileImageEditView(),
          //         ));
          //   },
          // ),
          // Container(
          //   height: 30,
          //   width: 30,
          //   margin: EdgeInsets.all(3),
          //   decoration: BoxDecoration(
          //       border: Border.all(
          //         width: 2.0,
          //         color: Colors.white,
          //       ),
          //       borderRadius: BorderRadius.all(Radius.circular(
          //               10.0) //                 <--- border radius here
          //           )),
          //   child: ClipRRect(
          //       borderRadius: BorderRadius.circular(8.0),
          //       child: Container(
          //           color: ColorTheme.gray300,
          //           child: Image.asset("images/ic_32_camera.png"))),
          // ),
        ],
      ),
    );
  }

  Widget _cameraButton() {
    return Container(
      width: 30.0,
      height: 30.0,
      decoration: new BoxDecoration(
        color: const Color(0xff7c94b6),
        image: new DecorationImage(
          alignment: Alignment.center,
          image: new AssetImage("images/ic_32_camera.png"),
          fit: BoxFit.cover,
        ),
        borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
        border: new Border.all(
          color: Colors.red,
          width: 4.0,
        ),
      ),
    );
  }

  Widget _challengeInfo() {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Expanded(
              child: _challenge(
                  "성공한 챌린지", member.successChallengeCount.toString())),
          Expanded(
              child:
                  _challenge("나의 성공률", member.successChallengePercent + "%")),
        ],
      ),
    );
  }

  Widget _challenge(String title, String description) {
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: ColorTheme.gray600,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(
                color: ColorTheme.point400,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
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
        "MY",
        style: TextStyle(
            color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      elevation: 0, // 그림자
      centerTitle: true,
    );
  }
}

class _Row extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  _Row(this.title, {this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: TextButton(
        child: Text(
          title,
          style: FontTheme.h4_with(ColorTheme.gray900),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

launchBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: false, forceWebView: false);
  } else {
    throw 'could not launch';
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:onlyone/Core/color_theme.dart';
import 'package:onlyone/Core/font_theme.dart';
import 'package:onlyone/views/01_onboarding/login_view.dart';
import 'package:onlyone/views/01_onboarding/onboarding_view.dart';
import 'package:onlyone/views/04_challenge_detail/feeds/challenge_feed_camera_view.dart';
import 'package:onlyone/views/04_challenge_detail/feeds/challenge_feed_image_upload_view.dart';
import 'package:onlyone/views/04_challenge_detail/feeds/challenge_feed_write_view.dart';
import 'package:onlyone/views/04_challenge_detail/feeds/challenge_feed_writing_view.dart';
import 'package:onlyone/views/components/popup_view.dart';

import '../../Core/network_manager.dart';
import '../../network_test.dart';

class TempListView extends StatefulWidget {
  @override
  _TempListViewState createState() => _TempListViewState();
}

class _TempListViewState extends State<TempListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Temp Test")),
      body: ListView(
        children: [
          SizedBox(height: 10),
          Text("팝업", textAlign: TextAlign.center, style: FontTheme.h5),
          SizedBox(height: 10),
          TextButton(
            child: Text("로그인 팝업"),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return PopupView(
                        description: "로그인이 필요합니다.",
                        actionText: "확인",
                        action: () {
                          Navigator.pop(context);
                        });
                  });
            },
          ),
          TextButton(
            child: Text("책린지 3개 이상 참여 팝업"),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return PopupView(
                        description:
                            "책린지를 3개 이상 참여하고 있어요!\n현재 챌린지가 끝나면 다시\n만들어보세요.",
                        actionText: "돌아가기",
                        action: () {
                          Navigator.pop(context);
                        });
                  });
            },
          ),
          TextButton(
            child: Text("책린지 성공 기준 안내 팝업"),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return PopupView(
                        title: "책린지 성공 기준 안내",
                        description: "총 횟수의 70% 이상 인증 시: 성공\n70% 이하 인증 시: 실패",
                        actionText: "닫기",
                        action: () {
                          Navigator.pop(context);
                        });
                  });
            },
          ),
          SizedBox(height: 10),
          Text("사진, 이미지 관련", textAlign: TextAlign.center, style: FontTheme.h5),
          SizedBox(height: 10),
          TextButton(
            child: Text("책린지 피드 사진촬영"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChallengeFeedCameraView(),
                    fullscreenDialog: true, // 모달창 기능
                  ));
            },
          ),
          TextButton(
            child: Text("책린지 피드 사진올리기"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChallengeFeedImageUploadView(),
                  ));
            },
          ),
          TextButton(
            child: Text("책린지 피드 글쓰기"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChallengeFeedWriteView(0),
                  ));
            },
          ),
          TextButton(
            child: Text("FireBase 이미지"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FirebaseStorageView(),
                  ));
            },
          ),
          SizedBox(height: 10),
          Text("Onboarding", textAlign: TextAlign.center, style: FontTheme.h5),
          SizedBox(height: 10),
          TextButton(
            child: Text("로그인"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginView(),
                      fullscreenDialog: true));
            },
          ),
          SizedBox(height: 10),
          TextButton(
            child: Text("로그아웃"),
            onPressed: () async {
              FirebaseApp defaultApp = await Firebase.initializeApp();
              final auth = FirebaseAuth.instanceFor(app: defaultApp);
              auth.signOut();
              NetworkManager().logout();
            },
          ),
          SizedBox(height: 10),
          TextButton(
            child: Text("Intro page"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OnboardingView(),
                      fullscreenDialog: true));
            },
          ),
          TextButton(
            child: Text("Network test"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NetworkTest(),
                      fullscreenDialog: true));
            },
          ),
        ],
      ),
    );
  }
}

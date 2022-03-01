// import 'package:flutter/rendering.dart';

// challenge list view
// my challenge list
// challenge info (detail)
// challenge
// create challenge view

// create comment view
// comment list view

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onlyone/Core/color_theme.dart';
import 'package:onlyone/Core/data_manager.dart';
import 'package:onlyone/Core/font_theme.dart';
import 'package:onlyone/Core/network_manager.dart';
import 'package:onlyone/views/01_onboarding/login_view.dart';
import 'package:onlyone/views/01_onboarding/onboarding_view.dart';
import 'package:onlyone/views/03_challenge_creation/create_challenge_view.dart';
import 'package:onlyone/views/05_my_info/my_info_view.dart';

import 'package:onlyone/views/custom/custom_bottom_tabbar_indicator.dart';
import 'package:onlyone/views/components/temp_list.dart';

import 'main_list.dart';
import 'my_list.dart';

class ChallengeListHome extends StatefulWidget {
  @override
  _ChallengeListHome createState() => _ChallengeListHome();
}

class _ChallengeListHome extends State<ChallengeListHome> {
  @override
  void initState() {
    super.initState();

    NetworkManager().checkVerify();
    DataManager().updateChallengeList();

    if (DataManager().isUserSignedIn == false &&
        DataManager().didShowIntroView == false) {
      Timer(Duration(milliseconds: 0), () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OnboardingView(),
                fullscreenDialog: true));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(

        // 탭바를 사용하기 위해 추가
        length: 2,
        child: Scaffold(
          appBar: _buildAppBar(),
          body: TabBarView(
            children: [MainChallengeListView(), MyChallengeListView()],
          ),
          floatingActionButton: _floationButton(),
        ));
  }

  AppBar _buildAppBar() {
    return AppBar(
        title: InkWell(
          child: Image.asset(
            "images/logo_02.png",
            height: 24,
            width: 60,
          ),
          onTap: () {
            if (kDebugMode) {
              // 디버그 모드일 때만 보이도록 처리
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TempListView(),
                  fullscreenDialog: true));
            }
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0, // 그림자
        centerTitle: false,
        actions: [
          // Text(
          //   text,
          //   style: FontTheme.p_with(Colors.black),
          // ),
          IconButton(
            // 프로필
            icon: Image.asset("images/ic_32_my.png", width: 32),
            color: Colors.black,
            onPressed: () {
              if (DataManager().isUserSignedIn) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyInfoView(),
                    ));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginView(),
                    ));
              }
            },
          ),
          Padding(padding: EdgeInsets.only(right: 10)),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Container(
            width: double.infinity,
            child: Padding(
                padding: EdgeInsets.only(left: 15), child: buildTabBar()),
          ),
        ));
  }

  Widget _floationButton() {
    return Container(
      height: 56,
      width: 56,
      child: FittedBox(
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateChallengeView(),
                    fullscreenDialog: true));
          },
          child: Icon(Icons.add, size: 40),
          backgroundColor: ColorTheme.point400,
        ),
      ),
    );
  }

  Widget buildTabBar() {
    return TabBar(
      indicator: CustomUnderlineTabIndicator(
        borderSide: BorderSide(
          width: 4,
          color: ColorTheme.point400,
        ),
      ),
      isScrollable: true,
      labelPadding: EdgeInsets.only(left: 0, right: 0),
      labelColor: ColorTheme.gray900,
      labelStyle: FontTheme.h4,
      unselectedLabelColor: ColorTheme.gray700,
      unselectedLabelStyle: FontTheme.h4,
      tabs: [
        Padding(
          padding: EdgeInsets.only(right: 40),
          child: Tab(text: "모집중인 챌린지"),
        ),
        Padding(
          padding: EdgeInsets.only(right: 8),
          child: Tab(text: "내 챌린지"),
        ),
      ],
    );
  }
}

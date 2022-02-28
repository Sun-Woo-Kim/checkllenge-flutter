// 04_챌린지상세_나의 활동
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onlyone/Core/color_theme.dart';
import 'package:onlyone/Core/font_theme.dart';
import 'package:onlyone/Core/network_manager.dart';
import 'package:onlyone/models/challenge_response.dart';
import 'package:onlyone/models/challenge_result_response.dart';
import 'package:onlyone/models/enum/challenge_member_status.dart';
import 'package:onlyone/views/04_challenge_detail/challenge_failure_view.dart';
import 'package:onlyone/views/04_challenge_detail/challenge_success_view.dart';
import 'package:onlyone/views/custom/custom_bottom_tabbar_indicator.dart';

import 'challenge_calendar_view.dart';
import 'challenge_feed_image_grid_view.dart';
import 'challenge_my_activity_list_view.dart';

class ChallengeMyActivityView extends StatefulWidget {
  final ChallengeResponse challenge;

  const ChallengeMyActivityView(this.challenge);

  @override
  _ChallengeMyActivityViewState createState() =>
      _ChallengeMyActivityViewState(challenge);
}

class _ChallengeMyActivityViewState extends State<ChallengeMyActivityView>
    with SingleTickerProviderStateMixin {
  final ChallengeResponse challenge;

  ChallengeResultResponse? result;

  late TabController _tabController = TabController(length: 3, vsync: this);

  _ChallengeMyActivityViewState(this.challenge) {
    _loadChallengeResult();
  }

  _loadChallengeResult() async {
    final response =
        await NetworkManager().getChallengeResult(challenge.challengeId);
    if (response.didSucceed) {
      setState(() {
        this.result = response.data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: _buildAppBar(),
          body: TabBarView(
            controller: _tabController,
            children: [
              ChallengeMyActivityListView(
                  challenge.feeds, challenge.photoUrlList),
              ChallengeFeddImageGridView(challenge: challenge),
              ChallengeCalendarView(challenge)
            ],
          )),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        leading: Container(),
        leadingWidth: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(53),
          child: Container(
              color: Colors.white,
              width: double.infinity,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(height: 1, color: ColorTheme.gray300),
                  Container(
                    padding: EdgeInsets.all(16),
                    height: 66,
                    child: Row(
                      children: [
                        Text(
                          "인증정보",
                          style: TextStyle(
                            color: ColorTheme.gray800,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Padding(
                            padding: EdgeInsets.only(left: 0),
                            child: _buildTabBar())
                      ],
                    ),
                  ),
                  Container(height: 1, color: ColorTheme.gray300),
                ],
              )),
        ),
        flexibleSpace: _buildResult());
  }

  Widget _buildResult() {
    if (this.result == null) {
      return StateView(challenge: challenge);
    }

    final result = this.result!;

    switch (result.challengeMemberStatus) {
      case ChallengeMemberStatus.NONE:
        return StateView(challenge: challenge);
      case ChallengeMemberStatus.FAIL:
        return FailedView(challenge: challenge, result: result);
      case ChallengeMemberStatus.SUCCESS:
        return SuccessView(challenge: challenge, result: result);
    }
  }

  TabBar _buildTabBar() {
    return TabBar(
      controller: _tabController,
      indicator: CustomUnderlineTabIndicator(
        borderSide: BorderSide(
          width: 4,
          color: Colors.white,
        ),
      ),
      isScrollable: true,
      labelPadding: EdgeInsets.only(left: 16, right: 0),
      labelColor: ColorTheme.point400,
      // labelStyle: FontTheme.h5,
      unselectedLabelColor: ColorTheme.gray700,
      // unselectedLabelStyle: FontTheme.p,
      tabs: [
        Tab(icon: new CustomIcon("images/ic_32_list.png")),
        Tab(icon: new CustomIcon("images/ic_32_list_2.png")),
        Tab(icon: new CustomIcon("images/ic_32_calendar.png")),

        // Padding(
        //   padding: EdgeInsets.only(right: 40),
        //   child: Tab(text: "나의 활동"),
        // ),
        // Padding(
        //   padding: EdgeInsets.only(right: 40),
        //   child: Tab(text: "피드"),
        // ),
      ],
    );
  }
}

class CustomIcon extends StatelessWidget {
  const CustomIcon(
    this.name, {
    this.size,
    this.color,
  });

  final String name;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    final double iconOpacity = iconTheme.opacity!;
    Color iconColor = color ?? iconTheme.color!;

    if (iconOpacity != 1.0)
      iconColor = iconColor.withOpacity(iconColor.opacity * iconOpacity);
    return Image.asset(
      name,
      color: iconColor,
      height: size,
    );
  }
}

class StateView extends StatelessWidget {
  final ChallengeResponse challenge;

  const StateView({Key? key, required this.challenge}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 92,
      alignment: Alignment.topCenter,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "현재",
                    style: FontTheme.p_with(ColorTheme.gray800),
                  ),
                  Text(
                    " ${-challenge.dDayStart}일",
                    style: FontTheme.h5_with(ColorTheme.gray800),
                  ),
                  Text(
                    "째 읽고있어요.",
                    style: FontTheme.p_with(ColorTheme.gray800),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                "${startDate()} 시작",
                style: FontTheme.blockquote2_with(ColorTheme.gray700),
              ),
            ],
          ),
          Spacer(),
          Text(
            "${challenge.currentMemberStatusResponse.feedsCount}",
            style: FontTheme.h1_with(ColorTheme.point400),
          ),
          Text(
            "/${challenge.certificationCount}",
            style: FontTheme.h1_with(ColorTheme.gray800),
          )
        ],
      ),
    );
  }

  String startDate() {
    return DateFormat('yyyy.MM.dd').format(challenge.startDate);
  }
}

class SuccessView extends StatelessWidget {
  final ChallengeResultResponse result;
  final ChallengeResponse challenge;

  const SuccessView({
    Key? key,
    required this.result,
    required this.challenge,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      alignment: Alignment.topCenter,
      // width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("챌린지 성공!", style: FontTheme.h1_with(ColorTheme.point400)),
          Spacer(),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => ChallengeSuccessView(
                            challenge: challenge,
                            result: result,
                          )));
            },
            child: Container(
              child: Text("인증서 발급받기", style: FontTheme.p_with(Colors.white)),
              height: 30,
              width: 150,
              alignment: Alignment.center,
            ),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
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
        ],
      ),
    );
  }
}

class FailedView extends StatelessWidget {
  final ChallengeResultResponse result;
  final ChallengeResponse challenge;

  const FailedView({
    Key? key,
    required this.result,
    required this.challenge,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("챌린지 실패!", style: FontTheme.h1_with(ColorTheme.gray800)),
          Spacer(),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => ChallengeFailureView(
                            challenge: challenge,
                            result: result,
                          )));
            },
            child: Container(
              height: 30,
              width: 150,
              alignment: Alignment.center,
              child: Text("책린지 만들러 가기", style: FontTheme.p_with(Colors.white)),
            ),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
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
        ],
      ),
    );
  }
}

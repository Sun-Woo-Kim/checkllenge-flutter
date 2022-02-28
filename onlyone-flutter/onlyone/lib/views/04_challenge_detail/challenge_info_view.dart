// 04_챌린지상세_정보

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:onlyone/Core/color_theme.dart';
import 'package:onlyone/Core/font_theme.dart';
import 'package:onlyone/Core/network_manager.dart';
import 'package:onlyone/models/challenge_response.dart';
import 'package:onlyone/views/04_challenge_detail/feeds/challenge_feed_write_view.dart';
import 'package:onlyone/views/components/popup_view.dart';
import 'package:onlyone/views/custom/custom_bottom_tabbar_indicator.dart';
import 'challenge_detail_info_view.dart';
import 'feeds/challenge_feed_view.dart';
import 'my_activities/challenge_my_activity_view.dart';

class ChallengeInfoView extends StatefulWidget {
  final ChallengeResponse challenge;
  ChallengeInfoView(this.challenge);

  @override
  _ChallengeInfoViewState createState() => _ChallengeInfoViewState(challenge);
}

class _ChallengeInfoViewState extends State<ChallengeInfoView>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollViewController = ScrollController();
  late TabController _tabController;

  ChallengeResponse challenge;
  _ChallengeInfoViewState(this.challenge);

  @override
  initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    getChallenge();
  }

  Future<ChallengeResponse> getChallenge() async {
    final response = await NetworkManager().getChallenge(challenge.challengeId);

    if (response.data == null) {
      return challenge;
    }
    return response.data!;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          controller: _scrollViewController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              _buildAppBar(innerBoxIsScrolled),
            ];
          },
          body: FutureBuilder<ChallengeResponse>(
            future: getChallenge(),
            builder: (BuildContext context,
                AsyncSnapshot<ChallengeResponse> snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }

              if (snapshot.hasError) {
                return Container();
              }
              ChallengeResponse challenge = snapshot.data!;

              return TabBarView(
                controller: _tabController,
                children: [
                  ChallengeMyActivityView(challenge),
                  ChallengeFeedView(challenge),
                  ChallengeDetailInfoView(challenge)
                ],
              );
            },
          ),
        ),
        bottomSheet: Container(
          width: double.infinity,
          height: 56,
          margin: EdgeInsets.fromLTRB(16, 16, 16, 24),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorTheme.point400,
            border: Border.all(color: ColorTheme.point400),
            borderRadius: BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: ColorTheme.point400.withAlpha(255 ~/ 5),
                spreadRadius: 0,
                blurRadius: 20,
                offset: Offset(0, 10), // changes position of shadow
              ),
            ],
          ),
          child: TextButton(
            child: Text(
              "글쓰기",
              style: FontTheme.h4_with(Colors.white),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ChallengeFeedWriteView(challenge.challengeId),
                  ))
                ..whenComplete(() => getChallenge());
            },
          ),
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar(bool innerBoxIsScrolled) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 270,
      leading: IconButton(
        icon: Image.asset(
          "images/ic_32_arrow_left.png",
          color: Colors.white,
          height: 32 * 0.9,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: challenge.isEnded
                    ? 38 * 0.9
                    : 42 * 0.9, // 이상하게 여기는 비율이 다르게 보여서 이렇게 처리
                height: 23 * 0.9,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: challenge.isEnded
                        ? ColorTheme.gray700
                        : ColorTheme.point400,
                    border: Border.all(
                        color: challenge.isEnded
                            ? ColorTheme.gray700
                            : ColorTheme.point400),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text(
                  challenge.isEnded ? "종료" : "D-${challenge.dDayEnd}",
                  // style: FontTheme.blockquote3_with(Colors.white),
                  style: TextStyle(
                      color: Colors.white,
                      // fontFamily: _fontFamily,
                      fontWeight: FontWeight.w700,
                      fontSize: 11),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                challenge.challengeName,
                maxLines: 2,
                style: FontTheme.h6_with(Colors.white),
              ),
              SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
        background: Image.asset(
          'images/background_0${challenge.challengeId % 6 + 1}.png',
          fit: BoxFit.cover,
          color: Colors.black.withOpacity(0.3),
          colorBlendMode: BlendMode.srcATop,
        ),

        // Image.network(
        //   challenge.bookResponse.thumbnailImagePath,
        //   fit: BoxFit.cover,
        //   color: Colors.black.withOpacity(0.3),
        //   colorBlendMode: BlendMode.srcATop,
        // ),
      ),
      backgroundColor: Colors.white,
      elevation: 0, // 그림자
      centerTitle: false,
      actions: [
        IconButton(
          icon: Image.asset(
            "images/ic_32_info.png",
            color: Colors.white,
            height: 32 * 0.9,
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return PopupView(
                    title: "책린지 성공 기준 안내",
                    description: "총  횟수의 70% 이상 인증 시: 성공\n70% 이하 인증 시: 실패",
                    action: () {
                      Navigator.pop(context);
                    },
                    actionText: "닫기",
                  );
                });
          },
        ),
        Padding(padding: EdgeInsets.only(right: 10)),
      ],

      floating: true,
      forceElevated: innerBoxIsScrolled,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(53),
        child: Container(
          color: Colors.white,
          width: double.infinity,
          child: Padding(
              padding: EdgeInsets.only(left: 15), child: _buildTabBar()),
        ),
      ),
    );
  }

  TabBar _buildTabBar() {
    return TabBar(
      controller: _tabController,
      indicator: CustomUnderlineTabIndicator(
        borderSide: BorderSide(
          width: 4,
          color: ColorTheme.point400,
        ),
      ),
      isScrollable: true,
      labelPadding: EdgeInsets.only(left: 0, right: 0),
      labelColor: ColorTheme.gray900,
      labelStyle: FontTheme.p,
      unselectedLabelColor: ColorTheme.gray700,
      unselectedLabelStyle: FontTheme.p,
      tabs: [
        Padding(
          padding: EdgeInsets.only(right: 40),
          child: Tab(text: "나의 활동"),
        ),
        Padding(
          padding: EdgeInsets.only(right: 40),
          child: Tab(text: "피드"),
        ),
        Padding(
          padding: EdgeInsets.only(right: 8),
          child: Tab(text: "정보"),
        ),
      ],
    );
  }
}

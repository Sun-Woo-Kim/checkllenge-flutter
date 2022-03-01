// 04_챌린지상세_전체피드보기
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:onlyone/Core/color_theme.dart';
import 'package:onlyone/Core/font_theme.dart';
import 'package:onlyone/Core/network_manager.dart';
import 'package:onlyone/models/book.dart';
import 'package:onlyone/models/feed_response.dart';

import 'challenge_feed_detail_view.dart';

class ChallengeFeedTotalView extends StatefulWidget {
  final Book book;

  const ChallengeFeedTotalView({Key? key, required this.book})
      : super(key: key);
  @override
  _ChallengeFeedTotalViewState createState() =>
      _ChallengeFeedTotalViewState(book);
}

class _ChallengeFeedTotalViewState extends State<ChallengeFeedTotalView> {
  final Book book;

  List<FeedResponse> feedList = [];

  _ChallengeFeedTotalViewState(this.book) {
    getFeeds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: feedList.length,
        itemBuilder: (context, index) {
          final feed = feedList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChallengeFeedDetailView(
                            challengeId: feed.challengeId,
                            feedId: feed.feedId,
                          )));
            },
            child: Container(child: _buildRow(feed), color: Colors.white),
          );
        },
      ),
    );
  }

  getFeeds() async {
    final response = await NetworkManager().getTotalFeedList(book.isbn);
    setState(() {
      if (response.didSucceed) {
        feedList = response.data ?? [];
      } else {
        feedList = [];
      }
    });
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Image.asset("images/ic_32_arrow_left.png", height: 32),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text("'${book.name}' 전체 피드",
          style: FontTheme.h4_with(ColorTheme.gray900)),
      backgroundColor: Colors.white,
      elevation: 0, // 그림자
    );
  }

  Widget _buildRow(FeedResponse feed) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                child: Container(
                  height: 64,
                  width: 64,
                  child: feed.isSpoiler
                      ? ExtendedImage.asset(
                          "images/img_spoiler.png",
                          shape: BoxShape.rectangle,
                          fit: BoxFit.cover,
                          borderRadius: BorderRadius.circular(8),
                        )
                      : ExtendedImage.network(
                          feed.feedImageUrlList.isEmpty
                              ? ""
                              : feed.feedImageUrlList.first,
                          shape: BoxShape.rectangle,
                          fit: BoxFit.cover,
                          borderRadius: BorderRadius.circular(8),
                        ),
                )),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 30,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      feed.title,
                      style: FontTheme.h3_with(ColorTheme.gray900),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 24,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      feed.isSpoiler ? "스포일러가 포함된 글입니다." : feed.content,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: FontTheme.p_with(feed.isSpoiler
                          ? ColorTheme.error
                          : ColorTheme.gray800),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 20,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      DateFormat("yyyy.MM.dd HH:mm").format(feed.createDate),
                      style: FontTheme.blockquote2_with(ColorTheme.gray700),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        Container(
            height: 1,
            color: ColorTheme.gray300,
            margin: EdgeInsets.symmetric(horizontal: 16)),
        SizedBox(height: 10),
        Container(
          height: 24,
          child: Row(
            children: [
              SizedBox(width: 16),
              Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(feed.createMemberPhotoUrl ?? ''))),
              ),
              const SizedBox(width: 8),
              Container(
                height: 20,
                alignment: Alignment.centerLeft,
                child: Text(
                  feed.createdMemberName ?? "닉네임없음",
                  style: FontTheme.blockquote2_with(ColorTheme.gray700),
                ),
              ),
              const Spacer(),
              GestureDetector(
                child: Image.asset(feed.isMyLiked ?? false
                    ? "images/ic_24_favorite_foc.png"
                    : "images/ic_28_favorite_nor.png"),
                onTap: () async {
                  EasyLoading.show();
                  await NetworkManager().likeFeed(feed.feedId);
                  await getFeeds();
                  EasyLoading.dismiss();
                },
              ),
              // Image.asset("images/ic_24_favorite_foc.png"),
              const SizedBox(width: 4),
              Text("${feed.likeCount}",
                  style: FontTheme.blockquote2_with(ColorTheme.gray700)),
              const SizedBox(width: 16),
              Image.asset("images/ic_32_comment.png"),
              const SizedBox(width: 4),
              Text("${feed.commentCount}",
                  style: FontTheme.blockquote2_with(ColorTheme.gray700)),
              const SizedBox(width: 4),
              const SizedBox(width: 16),
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(height: 8, color: ColorTheme.gray200),
      ],
    );
  }
}

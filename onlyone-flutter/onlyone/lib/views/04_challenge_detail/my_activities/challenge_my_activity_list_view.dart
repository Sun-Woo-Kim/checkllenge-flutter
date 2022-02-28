// 04_책린지상세_나의 활동_리스트
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:onlyone/Core/color_theme.dart';
import 'package:onlyone/Core/font_theme.dart';
import 'package:onlyone/Core/network_manager.dart';
import 'package:onlyone/models/feed_response.dart';

import '../feeds/challenge_feed_detail_view.dart';

class ChallengeMyActivityListView extends StatefulWidget {
  final List<FeedResponse> feeds;
  final List<String> profileImages;

  const ChallengeMyActivityListView(this.feeds, this.profileImages);
  @override
  _ChallengeMyActivityListViewState createState() =>
      _ChallengeMyActivityListViewState(feeds, profileImages);
}

class _ChallengeMyActivityListViewState
    extends State<ChallengeMyActivityListView> {
  final List<FeedResponse> feeds;
  final List<String> profileImages;

  _ChallengeMyActivityListViewState(this.feeds, this.profileImages);
  @override
  Widget build(BuildContext context) {
    if (feeds.isEmpty) {
      return Scaffold();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: feeds.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChallengeFeedDetailView(
                            challengeId: feeds[index].challengeId,
                            feedId: feeds[index].feedId,
                          )));
            },
            child:
                Container(child: _Row(feed: feeds[index]), color: Colors.white),
          );
        },
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final FeedResponse feed;

  const _Row({Key? key, required this.feed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                  child: ExtendedImage.network(
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
                      feed.content,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: FontTheme.p_with(ColorTheme.gray800),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 20,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      DateFormat('yyyy.MM.dd HH:mm').format(feed.createDate),
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
                  feed.createdMemberName ?? "",
                  style: FontTheme.blockquote2_with(ColorTheme.gray700),
                ),
              ),
              const Spacer(),
              Image.asset(feed.isMyLiked ?? false
                  ? "images/ic_24_favorite_foc.png"
                  : "images/ic_28_favorite_nor.png"),
              // GestureDetector(
              //   child: Image.asset("images/ic_28_favorite_nor.png"),
              //   onTap: () async {
              //     EasyLoading.show();
              //     await NetworkManager().likeFeed(feed.feedId);
              //     await getFeeds();
              //     EasyLoading.dismiss();
              //   },
              // ),
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

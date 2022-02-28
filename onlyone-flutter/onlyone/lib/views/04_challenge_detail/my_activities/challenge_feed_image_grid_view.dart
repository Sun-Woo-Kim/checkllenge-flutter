// 04_책린지상세_나의 활동_사진모아보기

//import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:onlyone/models/challenge_response.dart';
import 'package:onlyone/views/04_challenge_detail/feeds/challenge_feed_detail_view.dart';

class ChallengeFeddImageGridView extends StatefulWidget {
  final ChallengeResponse challenge;

  const ChallengeFeddImageGridView({Key? key, required this.challenge})
      : super(key: key);
  @override
  _ChallengeFeddImageGridViewState createState() =>
      _ChallengeFeddImageGridViewState(challenge);
}

class _ChallengeFeddImageGridViewState
    extends State<ChallengeFeddImageGridView> {
  final ChallengeResponse challenge;

  _ChallengeFeddImageGridViewState(this.challenge);
  @override
  Widget build(BuildContext context) {
    if (challenge.feeds.isEmpty) {
      return Scaffold();
    }
    return Scaffold(
        backgroundColor: Colors.white,
        body: GridView.builder(
          itemCount: challenge.feeds.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),
          itemBuilder: (cotext, index) {
            final feed = challenge.feeds[index];
            print(feed.feedImageUrlList);
            return GestureDetector(
              // When the child is tapped, show a snackbar.
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChallengeFeedDetailView(
                              challengeId: feed.challengeId,
                              feedId: feed.feedId,
                            )));
              },
              // The custom button
              child: ExtendedImage.network(
                challenge.feeds[index].feedImageUrlList.first,
                fit: BoxFit.cover,
              ),
            );
          },
        ));
  }
}

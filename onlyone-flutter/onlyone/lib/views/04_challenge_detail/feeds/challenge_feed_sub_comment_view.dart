// 04_챌린지상세_피드_상세

//import 'package:carousel_slider/carousel_controller.dart';
//import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:onlyone/Core/color_theme.dart';
import 'package:onlyone/Core/font_theme.dart';
import 'package:onlyone/Core/network_manager.dart';
import 'package:onlyone/models/child_comment_response.dart';
import 'package:onlyone/models/comment_request.dart';
import 'package:onlyone/models/comment_response.dart';
import 'package:onlyone/models/feed_detail_response.dart';
import 'package:onlyone/views/components/image_slider.dart';
import 'package:onlyone/views/components/popup_view.dart';

class ChallengeFeedSubCommentView extends StatefulWidget {
  final int challengeId;
  final int feedId;
  final int commentId;

  const ChallengeFeedSubCommentView(
      {Key? key,
      required this.challengeId,
      required this.feedId,
      required this.commentId})
      : super(key: key);

  @override
  _ChallengeFeedSubCommentView createState() => _ChallengeFeedSubCommentView(
      challengeId: challengeId, feedId: feedId, commentId: commentId);
}

class _ChallengeFeedSubCommentView extends State<ChallengeFeedSubCommentView> {
  final int challengeId;
  final int feedId;
  final int commentId;

  String commentText = "";
  final TextEditingController _textController = new TextEditingController();
  FeedDetailResponse? feedDetail;

  _ChallengeFeedSubCommentView({
    required this.challengeId,
    required this.feedId,
    required this.commentId,
  }) {
    updateFeed();
  }

  updateFeed() async {
    final response = await NetworkManager().getFeed(challengeId, feedId);
    if (response.didSucceed) {
      setState(() {
        feedDetail = response.data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (feedDetail == null) {
      return Scaffold();
    }

    return Scaffold(
      appBar: _appBar(context),
      backgroundColor: ColorTheme.gray300,
      body: new GestureDetector(
        onTap: () {
          // keyboard hide
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: _buildContent(),
      ),
    );
  }

  _buildContent() {
    return Column(
      children: <Widget>[
        Expanded(
            child: ListView(
          scrollDirection: Axis.vertical,
          children: [_buildCommentList()],
        )),
        _inputComment()
      ],
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
          icon: Image.asset("images/ic_32_arrow_left.png", height: 32),
          onPressed: () {
            Navigator.pop(context);
          }),
      backgroundColor: Colors.white,
      elevation: 0, // 그림자
    );
  }

  _buildBody(FeedDetailResponse feedDetail) {
    return Column(children: [
      ImageSlider(feedDetail.picturePaths),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Text(feedDetail.content),
      ),
      Container(
        height: 28,
        child: Row(
          children: [
            Spacer(),
            GestureDetector(
              child: Image.asset(feedDetail.isLiked
                  ? "images/ic_24_favorite_foc.png"
                  : "images/ic_28_favorite_nor.png"),
              onTap: () async {
                EasyLoading.show();
                await NetworkManager().likeFeed(feedId);
                await updateFeed();
                EasyLoading.dismiss();
              },
            ),
            SizedBox(width: 8),
            Text("${feedDetail.likeCount}",
                style: FontTheme.blockquote2_with(ColorTheme.gray700)),
            SizedBox(width: 16),
            Image.asset("images/ic_32_comment.png"),
            SizedBox(width: 8),
            Text("${feedDetail.commentCount}",
                style: FontTheme.blockquote2_with(ColorTheme.gray700)),
            SizedBox(width: 16),
          ],
        ),
      ),
      SizedBox(height: 16),
    ]);
  }

  Widget _inputComment() {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(16, 16, 16, 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // First child is enter comment text input
            Expanded(
              child: Container(
                child: TextFormField(
                  controller: _textController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  autocorrect: false,
                  onChanged: (text) {
                    this.commentText = text;
                  },
                  decoration: new InputDecoration(
                    // labelText: "Some Text",
                    hintText: "댓글을 입력해주세요.",
                    labelStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                    filled: true,
                    fillColor: ColorTheme.gray200,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            // Second child is button
            //
            SizedBox(width: 8),
            Container(
              height: 48,
              child: TextButton(
                onPressed: () async {
                  if (commentText.isEmpty) {
                    return;
                  }
                  final request = CommentRequest(
                      feedId: feedId,
                      parentCommentId: commentId,
                      content: this.commentText,
                      childComment: true);
                  await EasyLoading.show(maskType: EasyLoadingMaskType.black);

                  final response = await NetworkManager().commentFeed(request);

                  if (response.didSucceed) {
                    this._textController.text = "";
                    await updateFeed();
                    await EasyLoading.dismiss();
                  } else {
                    await EasyLoading.dismiss();
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
                child: Container(
                  height: 48,
                  width: 86,
                  alignment: Alignment.center,
                  child: Text("등록", style: FontTheme.h5_with(Colors.white)),
                ),
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
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
            ),
          ],
        ));
  }

  Widget _buildCommentList() {
    final comments = feedDetail?.comments;
    final comment =
        comments?.firstWhere((element) => element.commentId == commentId);
    if (comment == null) {
      return Container();
    }
    return Column(
      children: <Widget>[
        _buildComment(comment),
        buildChildCommentList(comment.childComments),
      ],
    );
  }

  Widget _buildComment(CommentResponse comment) {
    return Container(
      height: 124,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 17),
          Container(
            child: _UserInfo(
              memberName: comment.createMemberName,
              photoUrl: comment.createMemberPhotoUrl,
              memberId: comment.createMemberId,
              createDate: comment.createDate,
            ),
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
          SizedBox(height: 2),
          Container(
            height: 24,
            alignment: Alignment.centerLeft,
            child: Text(
              comment.content,
              style: FontTheme.p_with(ColorTheme.gray900),
            ),
            padding: EdgeInsets.only(left: 48, right: 16),
          ),
          SizedBox(height: 14),
          Container(
            height: 28,
            child: Row(
              children: [
                SizedBox(width: 48),
                GestureDetector(
                  child: Image.asset(comment.isLiked
                      ? "images/ic_24_favorite_foc.png"
                      : "images/ic_28_favorite_nor.png"),
                  onTap: () async {
                    EasyLoading.show();
                    await NetworkManager().likeFeedComment(comment.commentId);
                    await updateFeed();
                    EasyLoading.dismiss();
                  },
                ),
                SizedBox(width: 8),
                Text("${comment.likeCount}",
                    style: FontTheme.blockquote2_with(ColorTheme.gray700)),
                SizedBox(width: 16),
                GestureDetector(
                  child: Image.asset("images/ic_32_comment.png"),
                  onTap: () async {
                    // await NetworkManager().likeFeedComment(comment.commentId);
                    // updateFeed();
                  },
                ),
                SizedBox(width: 8),
                Text("${comment.childComments.length}",
                    style: FontTheme.blockquote2_with(ColorTheme.gray700)),
                Spacer(),
                Image.asset("images/ic_32_more.png"),
                SizedBox(width: 16),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildChildCommentList(List<ChildCommentResponse> childComments) {
    if (childComments.isEmpty) {
      return Container();
    }
    return Container(
      // height: (82 * childComments.length).toDouble(),
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: childComments.length,
          itemBuilder: (context, index) {
            return buildChildComment(childComments[index]);
          }),
    );
  }

  Widget buildChildComment(ChildCommentResponse childComment) {
    return Container(
      // height: 82,
      color: ColorTheme.gray200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(color: ColorTheme.gray300, height: 1),
          SizedBox(height: 17),
          Container(
            child: _UserInfo(
              memberName: childComment.createMemberName,
              photoUrl: childComment.createMemberPhotoUrl,
              memberId: childComment.createMemberId,
              createDate: childComment.createDate,
            ),
            padding: EdgeInsets.only(left: 32, right: 16),
          ),
          SizedBox(height: 2),
          Row(
            children: <Widget>[
              Container(
                height: 24,
                alignment: Alignment.centerLeft,
                child: Text(
                  childComment.content,
                  style: FontTheme.p_with(ColorTheme.gray900),
                ),
                padding: EdgeInsets.only(left: 64, right: 16),
              ),
              Spacer(),
              Image.asset("images/ic_32_more.png", height: 24),
              SizedBox(width: 16),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _UserInfo extends StatelessWidget {
  final String memberName;
  final String photoUrl;
  final int memberId;
  final DateTime createDate;

  const _UserInfo(
      {Key? key,
      required this.memberName,
      required this.memberId,
      required this.createDate,
      required this.photoUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: NetworkImage(photoUrl))),
        ),
        SizedBox(width: 8),
        Text(
          memberName,
          style: FontTheme.blockquote2_with(ColorTheme.gray800),
        ),
        Spacer(),
        Text(
          DateFormat("yy.MM.dd HH:mm").format(createDate),
          style: FontTheme.blockquote2_with(ColorTheme.gray700),
        )
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final FeedDetailResponse feedDetail;

  const _Header({Key? key, required this.feedDetail}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            feedDetail.title,
            style: FontTheme.h3_with(ColorTheme.gray900),
          ),
          SizedBox(height: 8),
          _UserInfo(
            memberName: feedDetail.createMemberName ?? "",
            photoUrl: feedDetail.createMemberPhotoUrl ?? '',
            memberId: feedDetail.createMemberId,
            createDate: feedDetail.createDate,
          )
        ],
      ),
    );
  }
}

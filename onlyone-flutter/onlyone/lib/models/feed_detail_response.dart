import 'package:json_annotation/json_annotation.dart';

import 'comment_response.dart';

part 'feed_detail_response.g.dart';

@JsonSerializable()
class FeedDetailResponse {
  FeedDetailResponse(
    this.feedId,
    this.title,
    this.content,
    this.isSpoiler,
    this.createDate,
    this.createMemberId,
    this.createMemberName,
    this.createMemberPhotoUrl,
    this.isLiked,
    this.likeCount,
    this.commentCount,
    this.picturePaths,
    this.comments,
  );

  int feedId;
  String title;
  String content;
  bool isSpoiler;
  DateTime createDate;
  int createMemberId;
  String? createMemberName;
  String? createMemberPhotoUrl;
  bool isLiked;
  int likeCount;
  int commentCount;
  List<String> picturePaths;
  List<CommentResponse> comments;

  factory FeedDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$FeedDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FeedDetailResponseToJson(this);
}

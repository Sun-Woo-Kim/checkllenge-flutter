import 'package:json_annotation/json_annotation.dart';

part 'feed_response.g.dart';

@JsonSerializable()
class FeedResponse {
  FeedResponse(
    this.challengeId,
    this.feedId,
    this.createdMemberName,
    this.createMemberPhotoUrl,
    this.title,
    this.content,
    this.isSpoiler,
    this.feedImageUrlList,
    this.createDate,
    this.updateDate,
    this.isMyLiked,
    this.likeCount,
    this.commentCount,
  );

  int challengeId;
  int feedId;
  String? createdMemberName;
  String? createMemberPhotoUrl;
  String title;
  String content;
  bool isSpoiler;
  List<String> feedImageUrlList;
  DateTime createDate;
  DateTime updateDate;
  bool? isMyLiked;
  int likeCount;
  int commentCount;

  factory FeedResponse.fromJson(Map<String, dynamic> json) =>
      _$FeedResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FeedResponseToJson(this);
}

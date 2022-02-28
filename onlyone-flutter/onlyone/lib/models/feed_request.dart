import 'package:json_annotation/json_annotation.dart';

part 'feed_request.g.dart';

@JsonSerializable()
class FeedRequest {
  FeedRequest({
    required this.challengeId,
    required this.title,
    required this.content,
    required this.imagePaths,
    required this.isSpoiler,
  });

  int challengeId;
  String title;
  String content;
  List<String> imagePaths;
  bool isSpoiler;

  factory FeedRequest.fromJson(Map<String, dynamic> json) =>
      _$FeedRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FeedRequestToJson(this);
}

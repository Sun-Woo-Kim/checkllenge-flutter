import 'package:json_annotation/json_annotation.dart';

part 'feed_like_request.g.dart';

@JsonSerializable()
class FeedLikeRequest {
  FeedLikeRequest({required this.feedId});

  int feedId;

  factory FeedLikeRequest.fromJson(Map<String, dynamic> json) =>
      _$FeedLikeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FeedLikeRequestToJson(this);
}

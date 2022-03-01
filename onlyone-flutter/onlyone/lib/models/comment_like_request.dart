import 'package:json_annotation/json_annotation.dart';

part 'comment_like_request.g.dart';

@JsonSerializable()
class CommentLikeRequest {
  CommentLikeRequest({required this.commentId});

  int commentId;

  factory CommentLikeRequest.fromJson(Map<String, dynamic> json) =>
      _$CommentLikeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CommentLikeRequestToJson(this);
}

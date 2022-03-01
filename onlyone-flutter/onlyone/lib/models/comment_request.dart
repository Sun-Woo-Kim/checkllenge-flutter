import 'package:json_annotation/json_annotation.dart';

part 'comment_request.g.dart';

@JsonSerializable()
class CommentRequest {
  CommentRequest({
    required this.feedId,
    this.parentCommentId,
    required this.content,
    required this.childComment,
  });

  int feedId;
  int? parentCommentId;
  String content;
  bool childComment;

  factory CommentRequest.fromJson(Map<String, dynamic> json) =>
      _$CommentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CommentRequestToJson(this);
}

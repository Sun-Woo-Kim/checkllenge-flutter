import 'package:json_annotation/json_annotation.dart';

part 'child_comment_response.g.dart';

@JsonSerializable()
class ChildCommentResponse {
  ChildCommentResponse(
    this.commentId,
    this.createMemberId,
    this.createMemberName,
    this.createMemberPhotoUrl,
    this.content,
    this.createDate,
  );

  int commentId;
  int createMemberId;
  String createMemberName;
  String createMemberPhotoUrl;
  String content;
  DateTime createDate;

  factory ChildCommentResponse.fromJson(Map<String, dynamic> json) =>
      _$ChildCommentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChildCommentResponseToJson(this);
}

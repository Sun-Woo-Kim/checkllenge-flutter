import 'package:json_annotation/json_annotation.dart';
import 'package:onlyone/models/child_comment_response.dart';

part 'comment_response.g.dart';

@JsonSerializable()
class CommentResponse {
  CommentResponse(
    this.commentId,
    this.createMemberId,
    this.createMemberName,
    this.createMemberPhotoUrl,
    this.content,
    this.createDate,
    this.childComments,
    this.isLiked,
    this.likeCount,
  );

  int commentId;
  int createMemberId;
  String createMemberName;
  String createMemberPhotoUrl;
  String content;
  DateTime createDate;
  List<ChildCommentResponse> childComments;
  bool isLiked;
  int likeCount;

  factory CommentResponse.fromJson(Map<String, dynamic> json) =>
      _$CommentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CommentResponseToJson(this);
}

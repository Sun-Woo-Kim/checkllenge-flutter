// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_comment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChildCommentResponse _$ChildCommentResponseFromJson(Map<String, dynamic> json) {
  return ChildCommentResponse(
    json['commentId'] as int,
    json['createMemberId'] as int,
    json['createMemberName'] as String,
    json['createMemberPhotoUrl'] as String,
    json['content'] as String,
    DateTime.parse(json['createDate'] as String),
  );
}

Map<String, dynamic> _$ChildCommentResponseToJson(
        ChildCommentResponse instance) =>
    <String, dynamic>{
      'commentId': instance.commentId,
      'createMemberId': instance.createMemberId,
      'createMemberName': instance.createMemberName,
      'createMemberPhotoUrl': instance.createMemberPhotoUrl,
      'content': instance.content,
      'createDate': instance.createDate.toIso8601String(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentResponse _$CommentResponseFromJson(Map<String, dynamic> json) {
  return CommentResponse(
    json['commentId'] as int,
    json['createMemberId'] as int,
    json['createMemberName'] as String,
    json['createMemberPhotoUrl'] as String,
    json['content'] as String,
    DateTime.parse(json['createDate'] as String),
    (json['childComments'] as List<dynamic>)
        .map((e) => ChildCommentResponse.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['isLiked'] as bool,
    json['likeCount'] as int,
  );
}

Map<String, dynamic> _$CommentResponseToJson(CommentResponse instance) =>
    <String, dynamic>{
      'commentId': instance.commentId,
      'createMemberId': instance.createMemberId,
      'createMemberName': instance.createMemberName,
      'createMemberPhotoUrl': instance.createMemberPhotoUrl,
      'content': instance.content,
      'createDate': instance.createDate.toIso8601String(),
      'childComments': instance.childComments,
      'isLiked': instance.isLiked,
      'likeCount': instance.likeCount,
    };

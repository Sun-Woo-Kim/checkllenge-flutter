// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentRequest _$CommentRequestFromJson(Map<String, dynamic> json) {
  return CommentRequest(
    feedId: json['feedId'] as int,
    parentCommentId: json['parentCommentId'] as int?,
    content: json['content'] as String,
    childComment: json['childComment'] as bool,
  );
}

Map<String, dynamic> _$CommentRequestToJson(CommentRequest instance) =>
    <String, dynamic>{
      'feedId': instance.feedId,
      'parentCommentId': instance.parentCommentId,
      'content': instance.content,
      'childComment': instance.childComment,
    };

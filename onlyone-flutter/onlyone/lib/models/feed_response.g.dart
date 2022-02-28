// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedResponse _$FeedResponseFromJson(Map<String, dynamic> json) {
  return FeedResponse(
    json['challengeId'] as int,
    json['feedId'] as int,
    json['createdMemberName'] as String?,
    json['createMemberPhotoUrl'] as String?,
    json['title'] as String,
    json['content'] as String,
    json['isSpoiler'] as bool,
    (json['feedImageUrlList'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    DateTime.parse(json['createDate'] as String),
    DateTime.parse(json['updateDate'] as String),
    json['isMyLiked'] as bool?,
    json['likeCount'] as int,
    json['commentCount'] as int,
  );
}

Map<String, dynamic> _$FeedResponseToJson(FeedResponse instance) =>
    <String, dynamic>{
      'challengeId': instance.challengeId,
      'feedId': instance.feedId,
      'createdMemberName': instance.createdMemberName,
      'createMemberPhotoUrl': instance.createMemberPhotoUrl,
      'title': instance.title,
      'content': instance.content,
      'isSpoiler': instance.isSpoiler,
      'feedImageUrlList': instance.feedImageUrlList,
      'createDate': instance.createDate.toIso8601String(),
      'updateDate': instance.updateDate.toIso8601String(),
      'isMyLiked': instance.isMyLiked,
      'likeCount': instance.likeCount,
      'commentCount': instance.commentCount,
    };

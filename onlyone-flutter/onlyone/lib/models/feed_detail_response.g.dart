// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedDetailResponse _$FeedDetailResponseFromJson(Map<String, dynamic> json) {
  return FeedDetailResponse(
    json['feedId'] as int,
    json['title'] as String,
    json['content'] as String,
    json['isSpoiler'] as bool,
    DateTime.parse(json['createDate'] as String),
    json['createMemberId'] as int,
    json['createMemberName'] as String?,
    json['createMemberPhotoUrl'] as String?,
    json['isLiked'] as bool,
    json['likeCount'] as int,
    json['commentCount'] as int,
    (json['picturePaths'] as List<dynamic>).map((e) => e as String).toList(),
    (json['comments'] as List<dynamic>)
        .map((e) => CommentResponse.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$FeedDetailResponseToJson(FeedDetailResponse instance) =>
    <String, dynamic>{
      'feedId': instance.feedId,
      'title': instance.title,
      'content': instance.content,
      'isSpoiler': instance.isSpoiler,
      'createDate': instance.createDate.toIso8601String(),
      'createMemberId': instance.createMemberId,
      'createMemberName': instance.createMemberName,
      'createMemberPhotoUrl': instance.createMemberPhotoUrl,
      'isLiked': instance.isLiked,
      'likeCount': instance.likeCount,
      'commentCount': instance.commentCount,
      'picturePaths': instance.picturePaths,
      'comments': instance.comments,
    };

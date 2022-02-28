// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedRequest _$FeedRequestFromJson(Map<String, dynamic> json) {
  return FeedRequest(
    challengeId: json['challengeId'] as int,
    title: json['title'] as String,
    content: json['content'] as String,
    imagePaths:
        (json['imagePaths'] as List<dynamic>).map((e) => e as String).toList(),
    isSpoiler: json['isSpoiler'] as bool,
  );
}

Map<String, dynamic> _$FeedRequestToJson(FeedRequest instance) =>
    <String, dynamic>{
      'challengeId': instance.challengeId,
      'title': instance.title,
      'content': instance.content,
      'imagePaths': instance.imagePaths,
      'isSpoiler': instance.isSpoiler,
    };

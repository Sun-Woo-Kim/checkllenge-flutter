// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) {
  return Book(
    json['id'] as int?,
    json['name'] as String,
    json['thumbnailImagePath'] as String,
    json['isbn'] as String,
    json['writer'] as String,
    json['publisher'] as String,
  );
}

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbnailImagePath': instance.thumbnailImagePath,
      'isbn': instance.isbn,
      'writer': instance.writer,
      'publisher': instance.publisher,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookRequest _$BookRequestFromJson(Map<String, dynamic> json) {
  return BookRequest(
    isbn: json['isbn'] as String,
    bookName: json['bookName'] as String,
    writer: json['writer'] as String,
    publisher: json['publisher'] as String,
    thumbnailImagePath: json['thumbnailImagePath'] as String,
  );
}

Map<String, dynamic> _$BookRequestToJson(BookRequest instance) =>
    <String, dynamic>{
      'isbn': instance.isbn,
      'bookName': instance.bookName,
      'writer': instance.writer,
      'publisher': instance.publisher,
      'thumbnailImagePath': instance.thumbnailImagePath,
    };

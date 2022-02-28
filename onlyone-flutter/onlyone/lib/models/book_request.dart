import 'package:json_annotation/json_annotation.dart';

part 'book_request.g.dart';

@JsonSerializable()
class BookRequest {
  BookRequest({
    required this.isbn,
    required this.bookName,
    required this.writer,
    required this.publisher,
    required this.thumbnailImagePath,
  });

  String isbn;
  String bookName;
  String writer;
  String publisher;
  String thumbnailImagePath;

  factory BookRequest.fromJson(Map<String, dynamic> json) =>
      _$BookRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BookRequestToJson(this);
}

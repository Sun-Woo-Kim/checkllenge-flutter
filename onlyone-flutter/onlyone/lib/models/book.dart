import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

@JsonSerializable()
class Book {
  Book(
    this.id,
    this.name,
    this.thumbnailImagePath,
    this.isbn,
    this.writer,
    this.publisher,
  );

  int? id;
  String name;
  String thumbnailImagePath;
  String isbn;
  String writer;
  String publisher;

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);
}

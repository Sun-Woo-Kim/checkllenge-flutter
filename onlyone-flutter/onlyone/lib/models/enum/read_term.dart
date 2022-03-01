import 'package:json_annotation/json_annotation.dart';

enum ReadTerm {
  @JsonValue("WEEK_OF_2")
  WEEK_OF_2,
  @JsonValue("WEEK_OF_4")
  WEEK_OF_4,
  @JsonValue("WEEK_OF_6")
  WEEK_OF_6,
  @JsonValue("WEEK_OF_8")
  WEEK_OF_8,
}

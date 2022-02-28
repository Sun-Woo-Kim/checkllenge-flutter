import 'package:json_annotation/json_annotation.dart';

enum CharacterType {
  @JsonValue("HARD_CERTIFICATION")
  HARD_CERTIFICATION,
  @JsonValue("WRITE_A_REVIEW")
  WRITE_A_REVIEW,
  @JsonValue("DISCUSS_ACTIVELY")
  DISCUSS_ACTIVELY,
}

extension CharacterTypeExtnesion on CharacterType {
  String getString() {
    switch (this) {
      case CharacterType.HARD_CERTIFICATION:
        return "열심히 인증하기";
      case CharacterType.WRITE_A_REVIEW:
        return "감상 남기기";
      case CharacterType.DISCUSS_ACTIVELY:
        return "적극적으로 토론하기";
    }
  }
}

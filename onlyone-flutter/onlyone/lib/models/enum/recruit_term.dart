import 'package:json_annotation/json_annotation.dart';

enum RecruitTerm {
  @JsonValue("AFTER_3_DAYS")
  AFTER_3_DAYS,
  @JsonValue("AFTER_7_DAYS")
  AFTER_7_DAYS,
  @JsonValue("ON_FULL")
  ON_FULL,
}

// extension CharacterTypeExtnesion on CharacterType {
//   String getString() {
//     switch (this) {
//       case CharacterType.HARD_CERTIFICATION:
//         return "열심히 인증하기";
//       case CharacterType.WRITE_A_REVIEW:
//         return "감상 남기기";
//       case CharacterType.DISCUSS_ACTIVELY:
//         return "적극적으로 토론하기";
//     }
//   }
// }

import 'package:json_annotation/json_annotation.dart';

enum CertificationCycle {
  @JsonValue("NONE")
  NONE,
  @JsonValue("ONCE_A_WEEK")
  ONCE_A_WEEK,
  @JsonValue("TWICE_A_WEEK")
  TWICE_A_WEEK,
  @JsonValue("THIRD_A_WEEK")
  THIRD_A_WEEK,
}

extension CertificationCycleExtension on CertificationCycle {
  String getString() {
    switch (this) {
      case CertificationCycle.NONE:
        return "인증 없음";

      case CertificationCycle.ONCE_A_WEEK:
        return "1주일에 한 번";

      case CertificationCycle.TWICE_A_WEEK:
        return "1주일에 두 번";

      case CertificationCycle.THIRD_A_WEEK:
        return "1주일에 세 번";
    }
  }
}

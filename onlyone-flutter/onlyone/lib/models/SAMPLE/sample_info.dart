import 'package:json_annotation/json_annotation.dart';

// 참고:
// https://flutter-ko.dev/docs/development/data-and-backend/json

// 아래 명령어를 프로젝트 루트에서 실행하면 watcher 가 돌면서,
// 아래 `sample_info.g.dart` 가 자동으로 생성 됨

// flutter pub run build_runner watch --delete-conflicting-outputs

// Conflict 발생할 때
// flutter packages pub run build_runner build --delete-conflicting-outputs

/// 이 구문은 `SampleInfo` 클래스가 생성된 파일의 private 멤버들을
/// 접근할 수 있도록 해줍니다. 여기에는 *.g.dart 형식이 들어갑니다.
/// * 에는 소스 파일의 이름이 들어갑니다.
part 'sample_info.g.dart';

/// 코드 생성기에 이 클래스가 JSON 직렬화 로직이 만들어져야 한다고 알려주는 어노테이션입니다.
@JsonSerializable()
class SampleInfo {
  SampleInfo(this.memberToken);

  String memberToken;

  /// map에서 새로운 User 인스턴스를 생성하기 위해 필요한 팩토리 생성자입니다.
  /// 생성된 `_$SampleInfoFromJson()` 생성자에게 map을 전달해줍니다.
  /// 생성자의 이름은 클래스의 이름을 따릅니다. 본 예제의 경우 LoginInfo를 따릅니다.
  factory SampleInfo.fromJson(Map<String, dynamic> json) =>
      _$SampleInfoFromJson(json);

  /// `toJson`은 클래스가 JSON 인코딩의 지원을 선언하는 규칙입니다.
  /// 이의 구현은 생성된 private 헬퍼 메서드 `_$SampleInfoFromJson`을 단순히 호출합니다.
  Map<String, dynamic> toJson() => _$SampleInfoToJson(this);
}

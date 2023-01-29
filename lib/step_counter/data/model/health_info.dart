import 'package:json_annotation/json_annotation.dart' show JsonSerializable;

part 'health_info.g.dart';

@JsonSerializable()
class HealthInfo {
  const HealthInfo({
    required this.steps,
  });

  factory HealthInfo.fromJson(Map<String, dynamic> json) {
    return _$HealthInfoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HealthInfoToJson(this);

  final int steps;
}
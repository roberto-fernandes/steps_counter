// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HealthInfo _$HealthInfoFromJson(Map<String, dynamic> json) => HealthInfo(
      steps: json['steps'] as int,
      calories: json['calories'] as int,
    );

Map<String, dynamic> _$HealthInfoToJson(HealthInfo instance) =>
    <String, dynamic>{
      'steps': instance.steps,
      'calories': instance.calories,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Events _$EventsFromJson(Map<String, dynamic> json) {
  return Events()
    ..events = (json['events'] as List)
        ?.map(
            (e) => e == null ? null : Event.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..status = json['status'] as num
    ..message = json['message'] as String;
}

Map<String, dynamic> _$EventsToJson(Events instance) => <String, dynamic>{
      'events': instance.events,
      'status': instance.status,
      'message': instance.message
    };

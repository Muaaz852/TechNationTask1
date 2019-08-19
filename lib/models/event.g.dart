// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event()
    ..id = json['id'] as num
    ..title = json['title'] as String
    ..date = json['date'] as String
    ..time = json['time'] as String
    ..image = json['image'] as String
    ..address = json['address'] as String
    ..description = json['description'] as String
    ..event_join = json['event_join'] as num;
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'date': instance.date,
      'time': instance.time,
      'image': instance.image,
      'address': instance.address,
      'description': instance.description,
      'event_join': instance.event_join
    };

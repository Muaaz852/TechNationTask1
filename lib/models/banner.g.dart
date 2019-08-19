// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Banner _$BannerFromJson(Map<String, dynamic> json) {
  return Banner()
    ..id = json['id'] as num
    ..title = json['title'] as String
    ..banner = json['banner'] as String;
}

Map<String, dynamic> _$BannerToJson(Banner instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'banner': instance.banner
    };

import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
    Event();

    num id;
    String title;
    String date;
    String time;
    String image;
    String address;
    String description;
    num event_join;
    
    factory Event.fromJson(Map<String,dynamic> json) => _$EventFromJson(json);
    Map<String, dynamic> toJson() => _$EventToJson(this);
}

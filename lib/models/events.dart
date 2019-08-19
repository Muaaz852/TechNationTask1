import 'package:json_annotation/json_annotation.dart';
import "event.dart";
part 'events.g.dart';

@JsonSerializable()
class Events {
    Events();

    List<Event> events;
    num status;
    String message;
    
    factory Events.fromJson(Map<String,dynamic> json) => _$EventsFromJson(json);
    Map<String, dynamic> toJson() => _$EventsToJson(this);
}

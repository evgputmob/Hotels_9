import 'package:json_annotation/json_annotation.dart';

part 'hotel.g.dart';

@JsonSerializable()
class Hotel {
  final String uuid;
  final String name;
  final String poster;

  Hotel({required this.uuid, required this.name, required this.poster});

  factory Hotel.fromJson(Map<String, dynamic> json) => _$HotelFromJson(json);

  Map<String, dynamic> toJson() => _$HotelToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
import 'address.dart';
import 'services.dart';

part 'hotel_details.g.dart';

@JsonSerializable()
class HotelDetails {
  final String uuid;
  final String name;
  final String poster;
  final Address address;
  final double price;
  final double rating;
  final Services services;
  final List<String> photos;

  HotelDetails({
    required this.uuid,
    required this.name,
    required this.poster,
    required this.address,
    required this.price,
    required this.rating,
    required this.services,
    required this.photos,
  });

  factory HotelDetails.fromJson(Map<String, dynamic> json) =>
      _$HotelDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$HotelDetailsToJson(this);
}

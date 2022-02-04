import 'package:json_annotation/json_annotation.dart';
import 'coords.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  final String country;
  final String street;
  final String city;

  @JsonKey(name: 'zip_code')
  final int zipCode;

  final Coords coords;

  Address(
      {required this.country,
      required this.street,
      required this.city,
      required this.zipCode,
      required this.coords});

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

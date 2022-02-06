import 'package:flutter/material.dart';
import 'package:hotels_9/models/hotel_details.dart';

import 'hotel_info_section.dart';

class HotelInfo extends StatelessWidget {
  final HotelDetails hotelDetails;

  const HotelInfo({Key? key, required this.hotelDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HotelInfoSection(
            propertyName: 'Страна',
            propertyValue: hotelDetails.address.country,
          ),
          const SizedBox(height: 6),
          HotelInfoSection(
            propertyName: 'Город',
            propertyValue: hotelDetails.address.city,
          ),
          const SizedBox(height: 6),
          HotelInfoSection(
            propertyName: 'Улица',
            propertyValue: hotelDetails.address.street,
          ),
          const SizedBox(height: 6),
          HotelInfoSection(
            propertyName: 'Рейтинг',
            propertyValue: hotelDetails.rating.toStringAsFixed(1),
          ),
        ],
      ),
    );
  }
}

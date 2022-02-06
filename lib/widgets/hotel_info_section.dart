import 'package:flutter/material.dart';

class HotelInfoSection extends StatelessWidget {
  final String propertyName;
  final String propertyValue;

  const HotelInfoSection({
    Key? key,
    required this.propertyName,
    required this.propertyValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const regularStyle = TextStyle(color: Colors.black, fontSize: 15);
    const boldStyle = TextStyle(fontWeight: FontWeight.bold);

    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: regularStyle,
        children: <TextSpan>[
          TextSpan(text: '$propertyName:  '),
          TextSpan(text: propertyValue, style: boldStyle),
        ],
      ),
    );
  }
}

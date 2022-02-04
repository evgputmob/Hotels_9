import 'package:flutter/material.dart';
import 'package:hotels_9/models/hotel_details.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HotelPage extends StatefulWidget {
  final String? uuid;
  const HotelPage({Key? key, required this.uuid}) : super(key: key);

  @override
  State<HotelPage> createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> {
  late HotelDetails _hotelDetails;
  bool _isLoading = false;
  bool _isError = false;

  void getHotelData() async {
    setState(() {
      _isLoading = true;
      _isError = false;
    });
    try {
      var url = 'https://run.mocky.io/v3/${widget.uuid}';
      final response = await http.get(Uri.parse(url));
      var hotelData = json.decode(response.body);
      _hotelDetails = HotelDetails.fromJson(hotelData);
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getHotelData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isLoading
            ? const Text('')
            : _isError
                ? const Text('')
                : Text(_hotelDetails.name),
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: (CircularProgressIndicator()))
            : (_isError
                ? (const Center(child: Text('Контент временно недоступен')))
                : (Text('Ok'))),
      ),
    );
  }
}

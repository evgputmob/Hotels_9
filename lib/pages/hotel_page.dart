import 'package:flutter/material.dart';
import 'package:hotels_9/models/hotel_details.dart';
import 'package:hotels_9/widgets/hotel_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';

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
  String _errorMessage = '';

  int _currentCarouselSlide = 0;
  final CarouselController _controller = CarouselController();

  void getHotelData() async {
    setState(() {
      _isLoading = true;
      _isError = false;
    });
    try {
      var url = 'https://run.mocky.io/v3/${widget.uuid}';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode >= 400) {
        setState(() {
          _isLoading = false;
          _isError = true;
          _errorMessage = json.decode(response.body)['message'];
        });
        return;
      }
      var hotelData = json.decode(response.body);
      _hotelDetails = HotelDetails.fromJson(hotelData);
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
        _isError = true;
        _errorMessage = 'Ошибка';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getHotelData();
  }

  Widget _showHotelData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 14),
        CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
            height: 200,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentCarouselSlide = index;
              });
            },
          ),
          items: _hotelDetails.photos
              .map((item) => Image.asset('assets/images/$item'))
              .toList(),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _hotelDetails.photos.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 11,
                height: 11,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(
                      _currentCarouselSlide == entry.key ? 0.9 : 0.2),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        HotelInfo(hotelDetails: _hotelDetails),
        const Padding(
          padding: EdgeInsets.fromLTRB(12, 16, 0, 12),
          child: Text('Сервисы', style: TextStyle(fontSize: 24)),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Платные', style: TextStyle(fontSize: 20)),
                    const SizedBox(height: 10),
                    ..._hotelDetails.services.paid
                        .map((item) => Text(item))
                        .toList(),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Бесплатно', style: TextStyle(fontSize: 20)),
                    const SizedBox(height: 10),
                    ..._hotelDetails.services.free
                        .map((item) => Text(item))
                        .toList(),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
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
            : _isError
                ? Center(child: Text(_errorMessage))
                : _showHotelData(),
      ),
    );
  }
}

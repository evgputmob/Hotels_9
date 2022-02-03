import 'package:flutter/material.dart';
import 'models/hotel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum ViewType { list, grid }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotels',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Hotels Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Hotel> _hotels = [];
  bool _isLoading = false;
  bool _isError = false;
  ViewType _viewType = ViewType.list;

  //----------------------------
  Widget _buildHotelsListView() {
    return ListView.builder(
      itemCount: _hotels.length,
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 250,
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 3,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            margin: (index == _hotels.length - 1)
                ? const EdgeInsets.symmetric(horizontal: 14, vertical: 17)
                : const EdgeInsets.fromLTRB(14, 17, 14, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Image(
                      image:
                          AssetImage('assets/images/${_hotels[index].poster}'),
                      fit: BoxFit.cover),
                ),
                SizedBox(
                  height: 64,
                  child: Row(
                    children: [
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _hotels[index].name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        child: const Text('Подробнее'),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 12),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
  //----------------------------

  Widget _buildHotelsGridView() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 17, 14, 0),
      child: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: _hotels.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            clipBehavior: Clip.antiAlias,
            elevation: 3,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            margin: (index % 2 == 0)
                ? const EdgeInsets.fromLTRB(0, 0, 7, 18)
                : const EdgeInsets.fromLTRB(7, 0, 0, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Image(
                      image:
                          AssetImage('assets/images/${_hotels[index].poster}'),
                      fit: BoxFit.cover),
                ),
                const SizedBox(height: 7),
                SizedBox(
                  height: 42,
                  child: Text(
                    _hotels[index].name,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                Material(
                  color: Theme.of(context).primaryColor,
                  child: InkWell(
                    onTap: () {},
                    child: const SizedBox(
                      height: 34,
                      child: Center(
                        child: Text(
                          'Подробнее',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  //----------------------------

  void getData() async {
    setState(() {
      _isLoading = true;
      _isError = false;
    });
    try {
      final response = await http.get(Uri.parse(
          'https://run.mocky.io/v3/ac888dc5-d193-4700-b12c-abb43e289301'));
      var hotelsData = json.decode(response.body);
      _hotels =
          hotelsData.map<Hotel>((hotel) => Hotel.fromJson(hotel)).toList();
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
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              if (_isLoading || _isError) return;
              if (_viewType == ViewType.list) return;
              setState(() {
                _viewType = ViewType.list;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.apps),
            onPressed: () {
              if (_isLoading || _isError) return;
              if (_viewType == ViewType.grid) return;
              setState(() {
                _viewType = ViewType.grid;
              });
            },
          ),
          const SizedBox(width: 5)
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: (CircularProgressIndicator()))
            : (_isError
                ? (const Center(child: Text('Loading error')))
                : ((_viewType == ViewType.list)
                    ? _buildHotelsListView()
                    : _buildHotelsGridView())),
      ),
    );
  }
}

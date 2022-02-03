import 'package:flutter/material.dart';
import 'models/hotel.dart';

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
  final List<Hotel> _hotels = [
    Hotel(uuid: '1', name: 'Hotel 1', poster: 'b&b_la_fontaine_1.jpg'),
    Hotel(uuid: '2', name: 'Hotel 2', poster: 'flora_chiado_apartments_9.jpg'),
    Hotel(uuid: '3', name: 'Hotel 3', poster: 'disney_dreams_3.jpg'),
    Hotel(uuid: '4', name: 'Hotel 4', poster: 'disney_dreams_4.jpg'),
    Hotel(uuid: '5', name: 'Hotel 5', poster: 'disney_dreams_5.jpg'),
    Hotel(uuid: '6', name: 'Hotel 6', poster: 'disney_dreams_6.jpg'),
    Hotel(uuid: '7', name: 'Hotel 7', poster: 'disney_dreams_2.jpg'),
  ];

  ViewType _viewType = ViewType.grid;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              if (_viewType == ViewType.list) return;
              setState(() {
                _viewType = ViewType.list;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.apps),
            onPressed: () {
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
          child: (_viewType == ViewType.list)
              ? _buildHotelsListView()
              : _buildHotelsGridView()),
    );
  }
}

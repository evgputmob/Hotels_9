import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'pages/home_page.dart';
import 'pages/hotel_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      title: 'Hotels',
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }

  final _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(title: 'Hotels Home Page'),
      ),
      GoRoute(
        path: '/hotel/:uuid',
        builder: (context, state) => HotelPage(uuid: state.params['uuid']),
      ),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:webtoon_clone/screens/home_screens.dart';
import 'package:webtoon_clone/services/api_service.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        child: const HomeScreen(),
      ),
    );
  }

  // This widget is the root of your application.
}

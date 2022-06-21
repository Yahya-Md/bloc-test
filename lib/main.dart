import 'package:flutter/material.dart';

import 'counter/widget/counter_widget.dart';
import 'posts/widget/posts_widget.dart';
import 'generate_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      onGenerateRoute: GenerateRoute.onGenerateRoute,
      initialRoute: HomePage.route,
    );
  }
}

class HomePage extends StatelessWidget {
  static const String route = '/home';
  static const String name = 'Home';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width / 3,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CounterWidget.route);
                },
                child: const Text(CounterWidget.name),
              ),
            ),
            SizedBox(
              width: size.width / 3,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(PostsWidget.route);
                },
                child: const Text(PostsWidget.name),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const BackHikeApp());
}

class BackHikeApp extends StatelessWidget {
  const BackHikeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Back Hike',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.park,
              color: Colors.greenAccent,
              size: 45,
            ),
            OutlinedButton(onPressed: () {}, child: const Text("Add Plan")),
          ],
        ),
      ),
    );
  }
}

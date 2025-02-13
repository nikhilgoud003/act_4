import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Valentine\'s Heartbeat',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HeartbeatScreen(),
    );
  }
}

class HeartbeatScreen extends StatelessWidget {
  const HeartbeatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: const Center(
        child: Text(
          'Celebrate Love with Us This Valentines Days',
          style: TextStyle(fontSize: 24, color: Colors.pink),
        ),
      ),
    );
  }
}

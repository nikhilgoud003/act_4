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
      theme: ThemeData(primarySwatch: Colors.red),
      home: const HeartbeatScreen(),
    );
  }
}

class HeartbeatScreen extends StatefulWidget {
  const HeartbeatScreen({super.key});

  @override
  HeartbeatScreenState createState() => HeartbeatScreenState();
}

class HeartbeatScreenState extends State<HeartbeatScreen>
    with TickerProviderStateMixin {
  late AnimationController _heartbeatController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _heartbeatController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _heartbeatController, curve: Curves.easeInOut),
    );
  }

  void _startAnimation() {
    _heartbeatController.repeat(reverse: true);
  }

  void _stopAnimation() {
    _heartbeatController.stop();
  }

  @override
  void dispose() {
    _heartbeatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Icon(
            Icons.favorite,
            size: 150,
            color: Colors.red[700],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startAnimation,
        child: const Icon(Icons.favorite),
      ),
    );
  }
}

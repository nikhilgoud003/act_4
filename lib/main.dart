import 'dart:async';
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
  int _secondsRemaining = 30;
  Timer? _timer;

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
    setState(() {
      _secondsRemaining = 30;
      _heartbeatController.repeat(reverse: true);
      _startTimer();
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _heartbeatController.stop();
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _heartbeatController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Time: $_secondsRemaining seconds',
              style: TextStyle(fontSize: 24, color: Colors.pink[700]),
            ),
            ScaleTransition(
              scale: _scaleAnimation,
              child: Icon(Icons.favorite, size: 150, color: Colors.red[700]),
            ),
            ElevatedButton(
              onPressed: _startAnimation,
              child: const Text('Start Heartbeat'),
            ),
          ],
        ),
      ),
    );
  }
}

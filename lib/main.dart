import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math' as math;

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
  late AnimationController _messageController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _messageOpacity;

  int _secondsRemaining = 20;
  bool _isAnimating = false;
  Timer? _timer;

  final List<String> _messages = [
    "Happy Valentine's Day!",
    "Seeing you my heart beat faster...",
    "Love is in the air!",
    "Be mine!",
    "Forever yours..."
        "You Made my day",
  ];
  int _currentMessageIndex = 0;

  @override
  void initState() {
    super.initState();

    // Heartbeat animation setup
    _heartbeatController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _heartbeatController, curve: Curves.easeInOut),
    );

    // Message fade animation setup
    _messageController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _messageOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _messageController, curve: Curves.easeIn),
    );

    _heartbeatController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _heartbeatController.repeat(reverse: true);
      }
    });
  }

  void _startAnimation() {
    setState(() {
      _isAnimating = true;
      _startTimer();
      _heartbeatController.forward();
      _cycleMessages();
    });
  }

  void _stopAnimation() {
    setState(() {
      _isAnimating = false;
      _timer?.cancel();
      _heartbeatController.stop();
      _messageController.stop();
      _secondsRemaining = 30;
    });
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _stopAnimation();
        }
      });
    });
  }

  void _cycleMessages() {
    _messageController.forward();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!_isAnimating) {
        timer.cancel();
        return;
      }
      setState(() {
        _currentMessageIndex = (_currentMessageIndex + 1) % _messages.length;
        _messageController.reset();
        _messageController.forward();
      });
    });
  }

  @override
  void dispose() {
    _heartbeatController.dispose();
    _messageController.dispose();
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
            // Timer display
            Text(
              'Time: $_secondsRemaining seconds',
              style: TextStyle(
                fontSize: 24,
                color: Colors.pink[700],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Animated heart
            ScaleTransition(
              scale: _scaleAnimation,
              child: Icon(
                Icons.favorite,
                size: 150,
                color: Colors.red[700],
              ),
            ),
            const SizedBox(height: 30),
            // Animated message
            FadeTransition(
              opacity: _messageOpacity,
              child: Text(
                _messages[_currentMessageIndex],
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.pink[700],
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.pink.withOpacity(0.3),
                      offset: const Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Control button
            ElevatedButton(
              onPressed: _isAnimating ? _stopAnimation : _startAnimation,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isAnimating ? Colors.red[300] : Colors.pink,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text(
                _isAnimating ? 'End Heartbeat' : 'Start Heartbeat',
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ConfettiPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.pink.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final random = math.Random(42);

    for (var i = 0; i < 50; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 5 + 2;

      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

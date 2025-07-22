import 'package:flutter/material.dart';
import 'package:book_my_saloon/screens/home_screen.dart';
import 'dart:async';
import 'dart:math' as math;

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scissorAnimation;
  late Animation<Offset> _vivoraSlideAnimation;
  late Animation<Offset> _subtitleSlideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    // Scissor animation (simulating cutting motion)
    _scissorAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.1, 0.5, curve: Curves.easeInOutCubic)),
    );

    // Slide animation for VIVORA (cutting motion effect)
    _vivoraSlideAnimation = Tween<Offset>(begin: const Offset(-2.0, 0.0), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.6, curve: Curves.easeOutBack)),
    );

    // Slide animation for subtitle with bounce
    _subtitleSlideAnimation = Tween<Offset>(begin: const Offset(0.0, 2.0), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.6, 1.0, curve: Curves.bounceOut)),
    );

    _controller.addListener(() {
      setState(() {});
    });
    _controller.forward();

    // Navigate to home screen after 5 seconds
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4A2C2A), Color(0xFFF5E6CC)], // Warm salon tones (brown to beige)
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  // Scissor animation (custom painted effect)
                  CustomPaint(
                    painter: ScissorPainter(progress: _scissorAnimation.value),
                    child: const SizedBox(
                      width: 200,
                      height: 200,
                    ),
                  ),
                  // VIVORA with slide animation
                  SlideTransition(
                    position: _vivoraSlideAnimation,
                    child: Text(
                      'VIVORA',
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            offset: const Offset(2.0, 2.0),
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Subtitle with slide animation
                  Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: SlideTransition(
                      position: _subtitleSlideAnimation,
                      child: Text(
                        'VIVORA Solutions presents Book My Salon',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// Custom painter for scissor-like animation
class ScissorPainter extends CustomPainter {
  final double progress;

  ScissorPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);

    // Simulate scissor blades crossing
    final angle = math.pi * progress; // Progress controls the angle
    final bladeLength = size.width * 0.4;

    // Left blade
    path.moveTo(center.dx - bladeLength * math.cos(angle), center.dy - bladeLength * math.sin(angle));
    path.lineTo(center.dx, center.dy);
    path.lineTo(center.dx - bladeLength * math.cos(angle + math.pi / 6), center.dy - bladeLength * math.sin(angle + math.pi / 6));

    // Right blade
    path.moveTo(center.dx + bladeLength * math.cos(angle), center.dy + bladeLength * math.sin(angle));
    path.lineTo(center.dx, center.dy);
    path.lineTo(center.dx + bladeLength * math.cos(angle + math.pi / 6), center.dy + bladeLength * math.sin(angle + math.pi / 6));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
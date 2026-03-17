import 'dart:math';
import 'package:flutter/material.dart';
import 'package:portfolio_web_app/core/theme/app_colors.dart';

class Confetti extends StatefulWidget {
  final bool isActive;
  final VoidCallback? onComplete;
  final int particleCount;
  final Duration duration;

  const Confetti({
    super.key,
    this.isActive = false,
    this.onComplete,
    this.particleCount = 100,
    this.duration = const Duration(seconds: 3),
  });

  @override
  State<Confetti> createState() => _ConfettiState();
}

class _ConfettiState extends State<Confetti> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Particle> _particles;
  final Random _random = Random();
  bool _hasCompleted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addListener(_updateParticles);

    if (widget.isActive) {
      _initializeParticles();
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(Confetti oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _initializeParticles();
      _controller.forward(from: 0.0);
      _hasCompleted = false;
    }
  }

  void _initializeParticles() {
    _particles = List.generate(widget.particleCount, (index) {
      return Particle(
        x: _random.nextDouble() * 1.2 - 0.1, // Slightly off-screen
        y: _random.nextDouble() * 0.5 - 0.5, // Start above screen
        vx: (_random.nextDouble() - 0.5) * 0.02,
        vy: _random.nextDouble() * 0.03 + 0.01,
        size: _random.nextDouble() * 8 + 4,
        color: _getRandomGoldColor(),
        rotation: _random.nextDouble() * 2 * pi,
        rotationSpeed: (_random.nextDouble() - 0.5) * 0.05,
        shape: _random.nextInt(3), // 0: square, 1: circle, 2: line
      );
    });
  }

  Color _getRandomGoldColor() {
    final goldVariations = [
      AppColors.gold,
      const Color(0xFFE5C87C), // Lighter gold
      const Color(0xFFD4AF37), // Classic gold
      const Color(0xFFC5A028), // Darker gold
      const Color(0xFFF5E6D3).withOpacity(0.8), // Very light gold
    ];
    return goldVariations[_random.nextInt(goldVariations.length)];
  }

  void _updateParticles() {
    if (_particles == null) return;
    
    setState(() {
      for (var p in _particles) {
        p.x += p.vx;
        p.y += p.vy;
        p.rotation += p.rotationSpeed;
        
        // Add slight gravity effect
        p.vy += 0.0005;
        
        // Check if all particles have fallen off screen
        if (!_hasCompleted && p.y > 1.2) {
          _hasCompleted = true;
          for (var checkP in _particles) {
            if (checkP.y < 1.2) {
              _hasCompleted = false;
              break;
            }
          }
          if (_hasCompleted && widget.onComplete != null) {
            widget.onComplete!();
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isActive || _particles == null) {
      return const SizedBox.shrink();
    }

    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: ConfettiPainter(
              particles: _particles,
              progress: _controller.value,
            ),
            size: MediaQuery.of(context).size,
          );
        },
      ),
    );
  }
}

class Particle {
  double x, y, vx, vy, size, rotation, rotationSpeed;
  Color color;
  int shape; // 0: square, 1: circle, 2: line

  Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.size,
    required this.color,
    required this.rotation,
    required this.rotationSpeed,
    required this.shape,
  });
}

class ConfettiPainter extends CustomPainter {
  final List<Particle> particles;
  final double progress;

  ConfettiPainter({
    required this.particles,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (progress >= 1.0) return;

    for (var p in particles) {
      if (p.y > 1.2) continue; // Skip particles that have fallen off screen

      final x = p.x * size.width;
      final y = p.y * size.height;

      final paint = Paint()
        ..color = p.color.withOpacity((1 - progress) * 0.8) // Fade out near the end
        ..style = PaintingStyle.fill;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(p.rotation);

      switch (p.shape) {
        case 0: // Square
          canvas.drawRect(
            Rect.fromCenter(
              center: Offset.zero,
              width: p.size,
              height: p.size,
            ),
            paint,
          );
          break;
        case 1: // Circle
          canvas.drawCircle(Offset.zero, p.size / 2, paint);
          break;
        case 2: // Line/Rectangle
          canvas.drawRect(
            Rect.fromCenter(
              center: Offset.zero,
              width: p.size * 0.3,
              height: p.size * 2,
            ),
            paint,
          );
          break;
      }

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant ConfettiPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.particles != particles;
  }
}
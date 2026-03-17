import 'dart:math';
import 'package:flutter/material.dart';
import 'package:portfolio_web_app/core/theme/app_colors.dart';

class ParticleBackground extends StatefulWidget {
  final Widget child;
  final bool isActive;

  const ParticleBackground({
    super.key,
    required this.child,
    this.isActive = true,
  });

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Particle> _particles;
  final Random _random = Random();
  Offset _mousePosition = Offset.zero;
  bool _mouseInside = false;

  static const int particleCount = 50;
  static const double maxSpeed = 0.5;
  static const double connectionDistance = 120.0;

  @override
  void initState() {
    super.initState();
    _initializeParticles();
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
    )..addListener(_updateParticles);
    
    _controller.repeat();
  }

  void _initializeParticles() {
    _particles = List.generate(particleCount, (index) {
      return Particle(
        position: Offset(
          _random.nextDouble() * 2000 - 500,
          _random.nextDouble() * 2000 - 500,
        ),
        velocity: Offset(
          (_random.nextDouble() - 0.5) * maxSpeed,
          (_random.nextDouble() - 0.5) * maxSpeed,
        ),
        size: _random.nextDouble() * 2 + 1,
        opacity: _random.nextDouble() * 0.3 + 0.1,
      );
    });
  }

  void _updateParticles() {
    setState(() {
      for (var particle in _particles) {
        // Update position based on velocity
        particle.position += particle.velocity;
        
        // Boundary checking with wrap-around
        if (particle.position.dx < -500) particle.position = Offset(1500, particle.position.dy);
        if (particle.position.dx > 1500) particle.position = Offset(-500, particle.position.dy);
        if (particle.position.dy < -500) particle.position = Offset(particle.position.dx, 1500);
        if (particle.position.dy > 1500) particle.position = Offset(particle.position.dx, -500);
        
        // Mouse interaction - particles are attracted to cursor when mouse is inside
        if (_mouseInside && _mousePosition != Offset.zero) {
          final Vector2 toMouse = Vector2(
            _mousePosition.dx - particle.position.dx,
            _mousePosition.dy - particle.position.dy,
          );
          
          final distance = toMouse.magnitude;
          if (distance < 200) {
            // Attraction force (stronger when closer)
            final force = (1 - (distance / 200)) * 0.2;
            
            // Normalize and apply force
            if (distance > 0) {
              toMouse.normalize();
              particle.velocity += Offset(
                toMouse.x * force,
                toMouse.y * force,
              );
            }
          }
        }
        
        // Apply slight random velocity changes (Brownian motion)
        particle.velocity += Offset(
          (_random.nextDouble() - 0.5) * 0.05,
          (_random.nextDouble() - 0.5) * 0.05,
        );
        
        // Limit velocity
        if (particle.velocity.distance > maxSpeed) {
          particle.velocity = particle.velocity * (maxSpeed / particle.velocity.distance);
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
    return MouseRegion(
      onHover: (event) {
        if (widget.isActive) {
          setState(() {
            _mousePosition = event.position;
            _mouseInside = true;
          });
        }
      },
      onExit: (_) {
        setState(() {
          _mouseInside = false;
        });
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
        child: Stack(
          children: [
            // Particle canvas
            Positioned.fill(
              child: CustomPaint(
                painter: ParticlePainter(
                  particles: _particles,
                  mousePosition: _mouseInside ? _mousePosition : null,
                  showConnections: true,
                ),
              ),
            ),
            // Child content
            widget.child,
          ],
        ),
      ),
    );
  }
}

class Particle {
  Offset position;
  Offset velocity;
  double size;
  double opacity;

  Particle({
    required this.position,
    required this.velocity,
    required this.size,
    required this.opacity,
  });
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final Offset? mousePosition;
  final bool showConnections;

  ParticlePainter({
    required this.particles,
    this.mousePosition,
    this.showConnections = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.gold
      ..style = PaintingStyle.fill;

    // Draw particles
    for (var particle in particles) {
      paint.color = AppColors.gold.withOpacity(particle.opacity);
      canvas.drawCircle(
        Offset(
          particle.position.dx.clamp(-500, size.width + 500),
          particle.position.dy.clamp(-500, size.height + 500),
        ),
        particle.size,
        paint,
      );
    }

    // Draw connections between nearby particles
    if (showConnections) {
      final connectionPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.5;

      for (int i = 0; i < particles.length; i++) {
        for (int j = i + 1; j < particles.length; j++) {
          final p1 = particles[i];
          final p2 = particles[j];
          
          final distance = (p1.position - p2.position).distance;
          
          if (distance < 150) {
            final opacity = (1 - distance / 150) * 0.2;
            connectionPaint.color = AppColors.gold.withOpacity(opacity);
            
            canvas.drawLine(
              p1.position,
              p2.position,
              connectionPaint,
            );
          }
        }
      }

      // Draw connections from particles to mouse
      if (mousePosition != null) {
        final mousePaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0;

        for (var particle in particles) {
          final distance = (particle.position - mousePosition!).distance;
          
          if (distance < 150) {
            final opacity = (1 - distance / 150) * 0.3;
            mousePaint.color = AppColors.gold.withOpacity(opacity);
            
            canvas.drawLine(
              particle.position,
              mousePosition!,
              mousePaint,
            );
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant ParticlePainter oldDelegate) {
    return oldDelegate.particles != particles ||
           oldDelegate.mousePosition != mousePosition;
  }
}

// Helper class for vector math
class Vector2 {
  double x, y;
  
  Vector2(this.x, this.y);
  
  double get magnitude => sqrt(x * x + y * y);
  
  void normalize() {
    final mag = magnitude;
    if (mag > 0) {
      x /= mag;
      y /= mag;
    }
  }
}
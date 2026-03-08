import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:portfolio_web_app/core/constants/app_sizes.dart';

class FadeInSection extends StatefulWidget {
  const FadeInSection({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.slideFrom = 30.0,
    this.duration, // Optional custom duration
  });

  final Widget child;
  final Duration delay;
  final double slideFrom;
  final Duration? duration; 
  @override
  State<FadeInSection> createState() => _FadeInSectionState();
}

class _FadeInSectionState extends State<FadeInSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;

  bool _triggered = false;

  @override
  void initState() {
    super.initState();

    // Use provided duration or default to AppSizes.durationSlow
    _ctrl = AnimationController(
      vsync: this,
      duration: widget.duration ?? AppSizes.durationSlow,
    );

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );

    // Normalize slide distance based on screen height for consistency
    _slide = Tween<Offset>(
      begin: Offset(0, widget.slideFrom / 400), 
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (_triggered) return;
    if (info.visibleFraction < 0.15) return;

    _triggered = true;

    if (widget.delay == Duration.zero) {
      _ctrl.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) _ctrl.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: widget.key ?? ValueKey('fade_${widget.child.runtimeType}'),
      onVisibilityChanged: _onVisibilityChanged,
      child: SlideTransition(
        position: _slide,
        child: FadeTransition(
          opacity: _opacity,
          child: widget.child,
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:portfolio_web_app/core/constants/app_sizes.dart';

class FadeInSection extends StatefulWidget {

  const FadeInSection({
    super.key,
    required this.child,
    this.delay     = Duration.zero,
    this.slideFrom = 30.0,
  });

  final Widget   child;
  final Duration delay;
  final double   slideFrom;

  @override
  State<FadeInSection> createState() => _FadeInSectionState();
}

class _FadeInSectionState extends State<FadeInSection>
    with SingleTickerProviderStateMixin {

  late final AnimationController _ctrl;
  late final Animation<double>   _opacity;
  late final Animation<Offset>   _slide;

  bool _triggered = false;

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(
      vsync:    this,
      duration: AppSizes.durationFadeIn,
    );

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );

    // slideFrom px → normalised Offset (Offset(0, 1) = full widget height)
    // We use a small fixed pixel value expressed as a fraction.
    // FractionalTranslation uses fractions of widget size, so we use
    // a SlideTransition with Tween<Offset> where 0.08 ≈ 30px on most screens.
    _slide = Tween<Offset>(
      begin: Offset(0, widget.slideFrom / 400),
      end:   Offset.zero,
    ).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

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
      key:                  key ?? ValueKey(widget.child.runtimeType),
      onVisibilityChanged:  _onVisibilityChanged,
      child: SlideTransition(
        position: _slide,
        child:    FadeTransition(
          opacity: _opacity,
          child:   widget.child,
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:portfolio_web_app/core/constants/app_strings.dart';
import 'package:portfolio_web_app/core/constants/app_sizes.dart';

class ShimmerName extends StatefulWidget {

  const ShimmerName({
    super.key,
    required this.style,
    this.text = AppStrings.developerName,
  });

  final TextStyle style;
  final String    text;

  @override
  State<ShimmerName> createState() => _ShimmerNameState();
}

class _ShimmerNameState extends State<ShimmerName>
    with SingleTickerProviderStateMixin {

  late final AnimationController _controller;
  late final Animation<double>   _animation;

  // Shimmer gradient colours
  // Base gold → bright highlight → base gold — creates the sweep illusion
  static const _baseGold      = AppColors.gold;
  static const _highlightGold = Color(0xFFFFF0A0); // warm bright highlight
  static const _deepGold      = Color(0xFFB8860B);  // dark anchor on edges

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: AppSizes.durationShimmer,
    )..repeat(); // loop forever

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        // Sweep position moves from -1 → 2 so the highlight fully enters
        // and exits the text bounds on every cycle
        final double sweep = _animation.value * 3 - 1;

        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [
                (sweep - 0.45).clamp(0.0, 1.0),
                (sweep - 0.15).clamp(0.0, 1.0),
                sweep.clamp(0.0, 1.0),
                (sweep + 0.15).clamp(0.0, 1.0),
                (sweep + 0.45).clamp(0.0, 1.0),
              ],
              colors: const [
                _deepGold,
                _baseGold,
                _highlightGold,
                _baseGold,
                _deepGold,
              ],
            ).createShader(bounds);
          },
          child: child,
        );
      },
      // Text is built once — ShaderMask repaints the shader, not the text
      child: Text(
        widget.text,
        style: widget.style,
      ),
    );
  }
}
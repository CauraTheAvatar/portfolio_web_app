import 'package:flutter/material.dart';
import 'package:portfolio_web_app/core/constants/app_sizes.dart';
import 'package:portfolio_web_app/core/theme/app_colors.dart'; // Added for completeness

class MagneticCard extends StatefulWidget {
  const MagneticCard({
    super.key,
    required this.child,
    this.strength = 0.06,
  });

  final Widget child;

  // How strongly the card follows the cursor.
  // 0.0 = no movement. 0.06 = subtle (recommended). 0.15 = strong.
  final double strength;

  @override
  State<MagneticCard> createState() => _MagneticCardState();
}

class _MagneticCardState extends State<MagneticCard> {
  Offset _translate = Offset.zero;
  bool _active = false;

  void _onEnter(PointerEvent event) {
    setState(() => _active = true);
  }

  void _onExit(PointerEvent event) {
    setState(() {
      _active = false;
      _translate = Offset.zero;
    });
  }

  void _onHover(PointerEvent event) {
    if (!_active) return;

    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;

    // Centre of the card in local coordinates
    final centre = Offset(box.size.width / 2, box.size.height / 2);

    // Cursor position relative to card
    final local = box.globalToLocal(event.position);
    final delta = local - centre;

    setState(() {
      _translate = delta * widget.strength;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      onHover: _onHover,
      child: AnimatedContainer(
        duration: AppSizes.durationMagnetic, 
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(
          _translate.dx,
          _translate.dy,
          0,
        ),
        child: widget.child,
      ),
    );
  }
}
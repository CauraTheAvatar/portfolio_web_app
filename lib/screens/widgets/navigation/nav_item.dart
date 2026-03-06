import 'package:flutter/material.dart';
import 'package:portfolio_web_app/core/constants/app_strings.dart';

class NavbarItem extends StatefulWidget {

  const NavbarItem({
    super.key,
    required this.title,
    required this.onTap,
    this.isActive = false,
  });

  final String        title;
  final VoidCallback  onTap;
  final bool          isActive;

  @override
  State<NavbarItem> createState() => _NavbarItemState();
}

class _NavbarItemState extends State<NavbarItem> {

  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    final bool highlighted = _isHover || widget.isActive;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHover = true),
      onExit:  (_) => setState(() => _isHover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Label — animates between navItem (black) and navItemActive (gold)
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: highlighted
                    ? AppTextStyle.navItemActive
                    : AppTextStyle.navItem,
                child: Text(widget.title),
              ),

              const SizedBox(height: 4),

              // Gold underline — grows from 0 → 24px on highlight
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                height: 2,
                width: highlighted ? 24 : 0,
                decoration: BoxDecoration(
                  color: AppColors.gold,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

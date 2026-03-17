import 'package:flutter/material.dart';
import 'package:portfolio_web_app/core/constants/app_sizes.dart';
import 'package:portfolio_web_app/core/theme/app_colors.dart';
import 'package:portfolio_web_app/core/responsive/responsive.dart';

class SectionContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool addGradient;
  final double? minHeight;
  final double? verticalPadding;
  final bool useStandardPadding; // ADDED: Flag to use original padding

  const SectionContainer({
    super.key,
    required this.child,
    required this.color,
    this.addGradient = true,
    this.minHeight,
    this.verticalPadding,
    this.useStandardPadding = false, // Default to new compressed style
  });

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);

    // Calculate padding based on flag
    final double horizontalPad = screen.horizontalPadding;
    final double verticalPad = verticalPadding ?? 
        (useStandardPadding 
            ? AppSizes.sectionPaddingVertical  // Original larger padding
            : AppSizes.sectionPaddingVerticalMob); // New compressed padding

    return Container(
      color: color,
      width: double.infinity,
      constraints: minHeight != null 
          ? BoxConstraints(minHeight: minHeight!) 
          : null,
      child: Stack(
        children: [
          // Light gold gradient overlay
          if (addGradient)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.gold.withOpacity(0.08),
                      Colors.transparent,
                      Colors.transparent,
                      AppColors.gold.withOpacity(0.05),
                    ],
                    stops: const [0.0, 0.3, 0.7, 1.0],
                  ),
                ),
              ),
            ),
          
          // Main content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPad,
              vertical: verticalPad,
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
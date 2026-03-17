import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:portfolio_web_app/controllers/home_controller.dart';
import 'package:portfolio_web_app/screens/home/sections/section_container.dart';
// import 'package:portfolio_web_app/core/animations/particle_background.dart'; // COMMENTED OUT

import 'package:portfolio_web_app/core/constants/app_strings.dart';
import 'package:portfolio_web_app/core/constants/app_sizes.dart';
import 'package:portfolio_web_app/core/responsive/responsive.dart';
import 'package:portfolio_web_app/core/animations/shimmer_name.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);

    return SectionContainer(
      color: AppColors.white,
      addGradient: true,
      useStandardPadding: true,
      minHeight: screen.isMobileOrTablet ? 700 : 700, // Increased mobile height
      verticalPadding: screen.isMobileOrTablet ? 40 : 0, // Reduced padding
      child: screen.isMobileOrTablet
          ? const _MobileLayout()
          : const _DesktopLayout(),
    );
  }
}

// Desktop Layout 
class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        // Left — text content
        Expanded(
          flex: 55,
          child: _HeroText(),
        ),
        SizedBox(width: AppSizes.heroColGap),
        // Right — profile image
        Expanded(
          flex: 45,
          child: Center(child: _ProfileImage()),
        ),
      ],
    );
  }
}

// Mobile Layout - FIXED overflow
class _MobileLayout extends StatelessWidget {
  const _MobileLayout();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // Added scrolling for mobile
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20), // Top spacing
          const _ProfileImage(),
          const SizedBox(height: AppSizes.heroMobileImageGap),
          const _HeroText(centerAlign: true),
          const SizedBox(height: 40), // Bottom spacing
        ],
      ),
    );
  }
}

// Hero Text
class _HeroText extends StatelessWidget {
  const _HeroText({this.centerAlign = false});
  final bool centerAlign;

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);
    final controller = Get.find<HomeController>();
    final cross = centerAlign ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = centerAlign ? TextAlign.center : TextAlign.start;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: screen.isMobile ? 16 : 0,
      ),
      child: Column(
        crossAxisAlignment: cross,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Overline 
          Text(
            AppStrings.heroGreeting,
            style: AppTextStyle.overline.copyWith(
              fontSize: screen.isMobile 
                  ? AppSizes.heroOverlineFontSize * 0.9 
                  : AppSizes.heroOverlineFontSize,
              letterSpacing: AppSizes.heroOverlineSpacing,
            ),
          ),
          const SizedBox(height: AppSizes.heroNameGap),
          
          // Developer name 
          ShimmerName(
            style: AppTextStyle.developerName.copyWith(
              fontSize: screen.isMobile 
                  ? AppTextStyle.developerName.fontSize! * 0.7 
                  : AppTextStyle.developerName.fontSize! * screen.fontScale,
            ),
          ),
          const SizedBox(height: AppSizes.heroRoleStripGap),
          
          // Static role strip - FIXED wrapping for mobile
          _RoleStrip(textAlign: textAlign, isMobile: screen.isMobile),
          const SizedBox(height: AppSizes.heroAnimTitleGap),
          
          // Animated subtitle 
          _AnimatedTitles(centerAlign: centerAlign),
          const SizedBox(height: AppSizes.heroRuleGap),
          
          // Gold rule divider
          _GoldRule(centered: centerAlign),
          const SizedBox(height: AppSizes.heroParaGap),
          
          // Intro paragraph - FIXED constraints for mobile
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screen.isMobile 
                  ? double.infinity 
                  : AppSizes.heroParaMaxWidth,
            ),
            child: Text(
              AppStrings.heroIntro,
              textAlign: textAlign,
              style: AppTextStyle.bodyLarge.copyWith(
                fontSize: screen.isMobile ? 14 : 16,
              ),
            ),
          ),
          const SizedBox(height: AppSizes.heroCtaGap),
          
          // CTA buttons
          _CtaButtons(
            centerAlign: centerAlign,
            onPrimary: () => controller.scrollTo(controller.projectsKey),
            onSecondary: () => controller.scrollTo(controller.contactKey),
          ),
        ],
      ),
    );
  }
}

// Role Strip - FIXED with wrapping for mobile
class _RoleStrip extends StatelessWidget {
  const _RoleStrip({required this.textAlign, this.isMobile = false});
  final TextAlign textAlign;
  final bool isMobile;

  static const List<String> _roles = [
    'Software Developer',
    'Data Analyst',
    'ML Enthusiast',
  ];

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      // Mobile: Show roles as separate lines
      return Column(
        children: _roles.map((role) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Text(
            role,
            style: AppTextStyle.bodyLarge.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w500,
              height: 1.4,
              fontSize: 14,
            ),
            textAlign: textAlign,
          ),
        )).toList(),
      );
    }

    // Desktop: Show roles inline with separators
    final spans = <InlineSpan>[];
    for (int i = 0; i < _roles.length; i++) {
      spans.add(TextSpan(
        text: _roles[i],
        style: AppTextStyle.bodyLarge.copyWith(
          color: AppColors.black,
          fontWeight: FontWeight.w500,
          height: 1.4,
        ),
      ));
      if (i < _roles.length - 1) {
        spans.add(TextSpan(
          text: '  |  ',
          style: AppTextStyle.bodyLarge.copyWith(
            color: AppColors.gold,
            fontWeight: FontWeight.w300,
          ),
        ));
      }
    }
    return Text.rich(
      TextSpan(children: spans),
      textAlign: textAlign,
    );
  }
}

// Animated Titles
class _AnimatedTitles extends StatefulWidget {
  const _AnimatedTitles({this.centerAlign = false});
  final bool centerAlign;

  @override
  State<_AnimatedTitles> createState() => _AnimatedTitlesState();
}

class _AnimatedTitlesState extends State<_AnimatedTitles>
    with SingleTickerProviderStateMixin {
  int _current = 0;
  late final Timer _timer;
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppSizes.durationSlow,
    );
    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
    _timer = Timer.periodic(AppSizes.durationTitles, (_) => _cycle());
  }

  Future<void> _cycle() async {
    await _controller.reverse();
    if (!mounted) return;
    setState(() {
      _current = (_current + 1) % AppStrings.developerTitles.length;
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.centerAlign ? Alignment.center : Alignment.centerLeft,
      child: FadeTransition(
        opacity: _opacity,
        child: SlideTransition(
          position: _slide,
          child: Text(
            AppStrings.developerTitles[_current],
            style: AppTextStyle.heroTagline.copyWith(fontSize: AppSizes.heroAnimTitleSize),
          ),
        ),
      ),
    );
  }
}

// Gold Rule
class _GoldRule extends StatelessWidget {
  const _GoldRule({this.centered = false});
  final bool centered;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: centered ? Alignment.center : Alignment.centerLeft,
      child: Container(
        width: AppSizes.goldRuleWidth,
        height: AppSizes.goldRuleHeight,
        decoration: BoxDecoration(
          color: AppColors.gold,
          borderRadius: BorderRadius.circular(AppSizes.radiusXS),
        ),
      ),
    );
  }
}

// CTA Buttons
class _CtaButtons extends StatelessWidget {
  const _CtaButtons({
    required this.onPrimary,
    required this.onSecondary,
    this.centerAlign = false,
  });

  final VoidCallback onPrimary;
  final VoidCallback onSecondary;
  final bool centerAlign;

  @override
  Widget build(BuildContext context) {
    final row = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _HoverButton(
          label: AppStrings.heroCta,
          isPrimary: true,
          onTap: onPrimary,
        ),
        const SizedBox(width: AppSizes.buttonGapBetween),
        _HoverButton(
          label: AppStrings.heroCtaSecond,
          isPrimary: false,
          onTap: onSecondary,
        ),
      ],
    );
    return centerAlign ? Center(child: row) : row;
  }
}

// Hover Button
class _HoverButton extends StatefulWidget {
  const _HoverButton({
    required this.label,
    required this.isPrimary,
    required this.onTap,
  });

  final String label;
  final bool isPrimary;
  final VoidCallback onTap;

  @override
  State<_HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<_HoverButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final bool p = widget.isPrimary;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppSizes.durationDefault,
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.buttonPaddingH, vertical: AppSizes.buttonPaddingV),
          decoration: BoxDecoration(
            color: p
                ? (_hovered ? AppColors.gold : AppColors.black)
                : Colors.transparent,
            border: Border.all(
              color: _hovered ? AppColors.gold : AppColors.black,
              width: AppSizes.borderDefault,
            ),
            borderRadius: BorderRadius.circular(AppSizes.radiusS),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.gold.withOpacity(0.25),
                      blurRadius: AppSizes.buttonShadowBlur,
                      offset: const Offset(0, AppSizes.buttonShadowOffsetY),
                    ),
                  ]
                : [],
          ),
          child: AnimatedDefaultTextStyle(
            duration: AppSizes.durationDefault,
            style: p
                ? AppTextStyle.buttonPrimary
                : AppTextStyle.buttonSecondary.copyWith(
                    color: _hovered ? AppColors.gold : AppColors.black,
                  ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}

// Profile Image
class _ProfileImage extends StatelessWidget {
  const _ProfileImage();

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);
    final size = screen.isMobileOrTablet ? 220.0 : 340.0;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusXXL),
        border: Border.all(color: AppColors.gold, width: AppSizes.borderThick),
        boxShadow: [
          BoxShadow(
            color: AppColors.gold.withOpacity(0.18),
            blurRadius: AppSizes.profileShadowBlur1,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: AppSizes.profileShadowBlur2,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.radiusXL),
        child: CachedNetworkImage(
          imageUrl: AppStrings.fbProfileImage,
          fit: BoxFit.cover,
          fadeInDuration: const Duration(milliseconds: 500),
          fadeInCurve: Curves.easeIn,
          placeholder: (_, __) => _Placeholder(size: size, loading: true),
          errorWidget: (_, __, ___) => _Placeholder(size: size),
        ),
      ),
    );
  }
}

// Placeholder
class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.size, this.loading = false});
  final double size;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      color: AppColors.lightGrey,
      child: loading
          ? const Center(
              child: SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.gold,
                ),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_rounded,
                  size: size * 0.38,
                  color: AppColors.gold.withOpacity(0.5),
                ),
                const SizedBox(height: AppSizes.spaceM),
                Text(
                  'Add profile image URL',
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.grey,
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
    );
  }
}
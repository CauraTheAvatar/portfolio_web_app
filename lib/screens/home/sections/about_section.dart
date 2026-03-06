import 'package:flutter/material.dart';
import 'package:portfolio_web_app/core/constants/app_sizes.dart';
import 'package:portfolio_web_app/core/constants/app_strings.dart';
import 'package:portfolio_web_app/core/responsive/responsive.dart';

class AboutSection extends StatelessWidget {

  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);

    return SectionWrapper(
      color: AppColors.lightGrey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          // Section header
          _SectionHeader(),

          const SizedBox(height: AppSizes.sectionHeaderGapContent),

          // Three info blocks
          screen.isMobileOrTablet
              ? _MobileLayout()
              : _DesktopLayout(),

        ],
      ),
    );
  }
}

// Section Header

class _SectionHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Text(
          'WHO I AM',
          style: AppTextStyle.overline,
        ),

        const SizedBox(height: AppSizes.sectionHeaderGapOverline),

        Text(
          AppStrings.aboutTitle,
          style: AppTextStyle.sectionTitle,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: AppSizes.sectionHeaderGapRule),

        Container(
          width:  AppSizes.goldRuleWidth,
          height: AppSizes.goldRuleHeight,
          decoration: BoxDecoration(
            color: AppColors.gold,
            borderRadius: BorderRadius.circular(AppSizes.radiusXS),
          ),
        ),

        const SizedBox(height: AppSizes.sectionHeaderGapSubtitle),

        Text(
          AppStrings.aboutSubtitle,
          style: AppTextStyle.sectionSubtitle,
          textAlign: TextAlign.center,
        ),

      ],
    );
  }
}

// Desktop Layout — Row of three equal blocks

class _DesktopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          // Block 1 — Education (left-aligned)
          Expanded(
            child: _TextBlock(
              title:     AppStrings.aboutEduTitle,
              body:      AppStrings.aboutEduBody,
              icon:      Icons.school_rounded,
              alignment: TextAlign.left,
            ),
          ),

          const SizedBox(width: AppSizes.cardGridSpacing),

          // Block 2 — Achievements (right-aligned) + startup chips
          Expanded(
            child: _TextBlock(
              title:     AppStrings.aboutAchTitle,
              body:      AppStrings.aboutAchBody,
              icon:      Icons.emoji_events_rounded,
              alignment: TextAlign.right,
              isMiddle:  true,
              extra:     const _StartupCallouts(),
            ),
          ),

          const SizedBox(width: AppSizes.cardGridSpacing),

          // Block 3 — Personal profile (left-aligned)
          Expanded(
            child: _TextBlock(
              title:     AppStrings.aboutPersonalTitle,
              body:      AppStrings.aboutPersonalBody,
              icon:      Icons.self_improvement_rounded,
              alignment: TextAlign.left,
            ),
          ),

        ],
      ),
    );
  }
}

// Mobile Layout — stacked Column

class _MobileLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        _TextBlock(
          title:     AppStrings.aboutEduTitle,
          body:      AppStrings.aboutEduBody,
          icon:      Icons.school_rounded,
          alignment: TextAlign.left,
        ),

        const SizedBox(height: AppSizes.cardGridSpacing),

        _TextBlock(
          title:     AppStrings.aboutAchTitle,
          body:      AppStrings.aboutAchBody,
          icon:      Icons.emoji_events_rounded,
          alignment: TextAlign.left,  // left on mobile for readability
          isMiddle:  true,
          extra:     const _StartupCallouts(),
        ),

        const SizedBox(height: AppSizes.cardGridSpacing),

        _TextBlock(
          title:     AppStrings.aboutPersonalTitle,
          body:      AppStrings.aboutPersonalBody,
          icon:      Icons.self_improvement_rounded,
          alignment: TextAlign.left,
        ),

      ],
    );
  }
}

// Text Block
// Single about info block — white card with gold border.
// isMiddle = true applies right-aligned text and a subtle gold-tinted bg.

class _TextBlock extends StatefulWidget {

  const _TextBlock({
    required this.title,
    required this.body,
    required this.icon,
    required this.alignment,
    this.isMiddle = false,
    this.extra,
  });

  final String    title;
  final String    body;
  final IconData  icon;
  final TextAlign alignment;
  final bool      isMiddle;
  final Widget?   extra;

  @override
  State<_TextBlock> createState() => _TextBlockState();
}

class _TextBlockState extends State<_TextBlock> {

  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final crossAxis = widget.alignment == TextAlign.right
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: AppSizes.durationDefault,
        width: double.infinity,
        padding: const EdgeInsets.all(AppSizes.cardPadding),
        decoration: BoxDecoration(
          color: widget.isMiddle
              ? (_hovered
                  ? AppColors.gold.withOpacity(0.04)
                  : AppColors.white)
              : AppColors.white,
          borderRadius: BorderRadius.circular(AppSizes.radiusL),
          border: Border.all(
            color: _hovered
                ? AppColors.gold
                : AppColors.gold.withOpacity(0.35),
            width: AppSizes.borderDefault,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color:      AppColors.gold.withOpacity(0.15),
                    blurRadius: AppSizes.cardShadowBlurHover,
                    offset:     const Offset(0, 6),
                  ),
                  BoxShadow(
                    color:      Colors.black.withOpacity(0.06),
                    blurRadius: AppSizes.cardShadowBlurDepth,
                    offset:     const Offset(0, 3),
                  ),
                ]
              : [
                  BoxShadow(
                    color:      Colors.black.withOpacity(0.04),
                    blurRadius: AppSizes.cardShadowBlurRest,
                    offset:     const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: crossAxis,
          children: [

            // Icon
            AnimatedContainer(
              duration: AppSizes.durationDefault,
              width:  AppSizes.cardIconContainerSize,
              height: AppSizes.cardIconContainerSize,
              decoration: BoxDecoration(
                color: _hovered
                    ? AppColors.gold.withOpacity(0.12)
                    : AppColors.lightGrey,
                borderRadius: BorderRadius.circular(AppSizes.radiusM),
              ),
              child: Icon(
                widget.icon,
                size:  AppSizes.cardIconSize,
                color: _hovered ? AppColors.gold : AppColors.grey,
              ),
            ),

            const SizedBox(height: AppSizes.cardInternalGapL),

            // Title
            AnimatedDefaultTextStyle(
              duration: AppSizes.durationDefault,
              style: AppTextStyle.cardTitle.copyWith(
                color: _hovered ? AppColors.gold : AppColors.black,
              ),
              child: Text(
                widget.title,
                textAlign: widget.alignment,
              ),
            ),

            const SizedBox(height: AppSizes.spaceS),

            // Gold rule — short, aligned to match text alignment
            Align(
              alignment: widget.alignment == TextAlign.right
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Container(
                width:  32,
                height: AppSizes.goldRuleHeight,
                decoration: BoxDecoration(
                  color: AppColors.gold.withOpacity(
                    _hovered ? 1.0 : 0.5,
                  ),
                  borderRadius: BorderRadius.circular(AppSizes.radiusXS),
                ),
              ),
            ),

            const SizedBox(height: AppSizes.cardInternalGapL),

            // Body text
            Text(
              widget.body,
              textAlign: widget.alignment,
              style: AppTextStyle.bodyMedium,
            ),

            // Extra widget (startup callouts for middle block)
            if (widget.extra != null) ...[
              const SizedBox(height: AppSizes.cardInternalGapL),
              widget.extra!,
            ],

          ],
        ),
      ),
    );
  }
}

// Startup Callouts
// Gold-accented highlight chips for the two startups.
// Rendered at the bottom of Block 2 (Achievements).

class _StartupCallouts extends StatelessWidget {

  const _StartupCallouts();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [

        Text(
          'VENTURES',
          style: AppTextStyle.overline.copyWith(fontSize: 10),
          textAlign: TextAlign.right,
        ),

        const SizedBox(height: AppSizes.spaceS),

        _StartupChip(
          name:     AppStrings.aboutStartup1,
          subtitle: AppStrings.aboutStartup1Sub,
          icon:     Icons.content_cut_rounded,
        ),

        const SizedBox(height: AppSizes.spaceS),

        _StartupChip(
          name:     AppStrings.aboutStartup2,
          subtitle: AppStrings.aboutStartup2Sub,
          icon:     Icons.celebration_rounded,
        ),

      ],
    );
  }
}

// Startup Chip — individual branded callout card

class _StartupChip extends StatefulWidget {

  const _StartupChip({
    required this.name,
    required this.subtitle,
    required this.icon,
  });

  final String    name;
  final String    subtitle;
  final IconData  icon;

  @override
  State<_StartupChip> createState() => _StartupChipState();
}

class _StartupChipState extends State<_StartupChip> {

  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: AppSizes.durationDefault,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.spaceXXL,
          vertical:   AppSizes.spaceM,
        ),
        decoration: BoxDecoration(
          color: _hovered
              ? AppColors.gold.withOpacity(0.10)
              : AppColors.lightGrey,
          borderRadius: BorderRadius.circular(AppSizes.radiusS),
          border: Border.all(
            color: _hovered
                ? AppColors.gold
                : AppColors.gold.withOpacity(0.3),
            width: AppSizes.borderThin,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            Icon(
              widget.icon,
              size:  AppSizes.iconXS + 2,
              color: AppColors.gold,
            ),

            const SizedBox(width: AppSizes.spaceM),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [

                Text(
                  widget.name,
                  style: AppTextStyle.label.copyWith(
                    color: AppColors.black,
                    fontSize: 13,
                  ),
                ),

                Text(
                  widget.subtitle,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.gold,
                    fontSize: 11,
                  ),
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:portfolio_web_app/core/constants/app_sizes.dart';
import 'package:portfolio_web_app/core/constants/app_strings.dart';
import 'package:portfolio_web_app/core/responsive/responsive.dart';

class SkillsSection extends StatelessWidget {

  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          // Section header
          _SectionHeader(),

          const SizedBox(height: AppSizes.sectionHeaderGapContent),

          // Skill cards
          _SkillCardRow(),

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
          'WHAT I KNOW',
          style: AppTextStyle.overline,
        ),

        const SizedBox(height: AppSizes.sectionHeaderGapOverline),

        Text(
          AppStrings.skillsTitle,
          style: AppTextStyle.sectionTitle,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: AppSizes.sectionHeaderGapRule),

        // Gold rule
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
          AppStrings.skillsSubtitle,
          style: AppTextStyle.sectionSubtitle,
          textAlign: TextAlign.center,
        ),

      ],
    );
  }
}

// Skill Card Row
// Manages hover state at the row level so each card knows whether
// any sibling is hovered — enabling the blur-defocus effect.

class _SkillCardRow extends StatefulWidget {

  @override
  State<_SkillCardRow> createState() => _SkillCardRowState();
}

class _SkillCardRowState extends State<_SkillCardRow> {

  // Index of the currently hovered card. -1 = none hovered.
  int _hoveredIndex = -1;

  void _onHover(int index)  => setState(() => _hoveredIndex = index);
  void _onExit()            => setState(() => _hoveredIndex = -1);

  static const _icons = [
    Icons.code_rounded,
    Icons.analytics_rounded,
    Icons.design_services_rounded,
    Icons.brush_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    final screen     = Responsive.of(context);
    final categories = AppStrings.skillCategories;

    // Mobile → vertical stack, desktop/tablet → horizontal row
    if (screen.isMobileOrTablet && !screen.isTabletLarge) {
      return Column(
        children: List.generate(categories.length, (i) {
          final cat    = categories[i];
          final skills = List<String>.from(cat['skills'] as List);
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSizes.cardGridSpacing),
            child: _SkillCard(
              title:        cat['title'] as String,
              icon:         _icons[i],
              skills:       skills,
              isHovered:    _hoveredIndex == i,
              isDefocused:  false, // no blur effect on mobile stack
              onHover:      () => _onHover(i),
              onExit:       _onExit,
            ),
          );
        }),
      );
    }

    // Desktop / tablet large → Row with blur defocus
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(categories.length, (i) {
        final cat        = categories[i];
        final skills     = List<String>.from(cat['skills'] as List);
        final isHovered   = _hoveredIndex == i;
        final isDefocused = _hoveredIndex != -1 && !isHovered;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: i < categories.length - 1 ? AppSizes.cardGridSpacing : 0,
            ),
            child: _SkillCard(
              title:       cat['title'] as String,
              icon:        _icons[i],
              skills:      skills,
              isHovered:   isHovered,
              isDefocused: isDefocused,
              onHover:     () => _onHover(i),
              onExit:      _onExit,
            ),
          ),
        );
      }),
    );
  }
}

// Skill Card
// Individual skill category card.
//
// States:
//   Default    → resting shadow, gold border at 40% opacity
//   Hovered    → scale 1.03, full gold border, gold glow shadow,
//                gold icon bg, title turns gold
//   Defocused  → BackdropFilter blur (sigma 3) + opacity 0.45
//                applied via Stack overlay — content stays readable
//                but clearly recedes behind the focused card

class _SkillCard extends StatefulWidget {

  const _SkillCard({
    super.key,
    required this.title,
    required this.icon,
    required this.skills,
    required this.isHovered,
    required this.isDefocused,
    required this.onHover,
    required this.onExit,
  });

  final String        title;
  final IconData      icon;
  final List<String>  skills;
  final bool          isHovered;
  final bool          isDefocused;
  final VoidCallback  onHover;
  final VoidCallback  onExit;

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard>
    with SingleTickerProviderStateMixin {

  late final AnimationController _controller;
  late final Animation<double>   _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppSizes.durationDefault,
    );
    _scale = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void didUpdateWidget(_SkillCard old) {
    super.didUpdateWidget(old);
    widget.isHovered ? _controller.forward() : _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onEnter: (_) => widget.onHover(),
      onExit:  (_) => widget.onExit(),
      child: ScaleTransition(
        scale: _scale,
        child: Stack(
          children: [

            // Card body
            _CardBody(
              title:     widget.title,
              icon:      widget.icon,
              skills:    widget.skills,
              isHovered: widget.isHovered,
            ),

            // Defocus overlay — blur + dim applied on top of card
            // Only rendered when a sibling is hovered
            if (widget.isDefocused)
              _DefocusOverlay(),

          ],
        ),
      ),
    );
  }
}

// Card Body — the actual card content

class _CardBody extends StatelessWidget {

  const _CardBody({
    required this.title,
    required this.icon,
    required this.skills,
    required this.isHovered,
  });

  final String        title;
  final IconData      icon;
  final List<String>  skills;
  final bool          isHovered;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppSizes.durationDefault,
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusL),
        border: Border.all(
          color: isHovered
              ? AppColors.gold
              : AppColors.gold.withOpacity(0.35),
          width: AppSizes.borderDefault,
        ),
        boxShadow: isHovered
            ? [
                BoxShadow(
                  color:      AppColors.gold.withOpacity(0.22),
                  blurRadius: AppSizes.cardShadowBlurHover,
                  offset:     const Offset(0, 8),
                ),
                BoxShadow(
                  color:      Colors.black.withOpacity(0.07),
                  blurRadius: AppSizes.cardShadowBlurDepth,
                  offset:     const Offset(0, 4),
                ),
              ]
            : [
                BoxShadow(
                  color:      Colors.black.withOpacity(0.05),
                  blurRadius: AppSizes.cardShadowBlurRest,
                  offset:     const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Icon container
          AnimatedContainer(
            duration: AppSizes.durationDefault,
            width:  AppSizes.cardIconContainerSize,
            height: AppSizes.cardIconContainerSize,
            decoration: BoxDecoration(
              color: isHovered
                  ? AppColors.gold.withOpacity(0.12)
                  : AppColors.lightGrey,
              borderRadius: BorderRadius.circular(AppSizes.radiusM),
            ),
            child: Icon(
              icon,
              size:  AppSizes.cardIconSize,
              color: isHovered ? AppColors.gold : AppColors.grey,
            ),
          ),

          const SizedBox(height: AppSizes.cardInternalGapL),

          // Category title
          AnimatedDefaultTextStyle(
            duration: AppSizes.durationDefault,
            style: AppTextStyle.cardTitle.copyWith(
              color: isHovered ? AppColors.gold : AppColors.black,
            ),
            child: Text(title),
          ),

          const SizedBox(height: AppSizes.cardInternalGapL),

          // Gold divider
          Container(
            width:  32,
            height: AppSizes.goldRuleHeight,
            decoration: BoxDecoration(
              color: AppColors.gold.withOpacity(isHovered ? 1.0 : 0.4),
              borderRadius: BorderRadius.circular(AppSizes.radiusXS),
            ),
          ),

          const SizedBox(height: AppSizes.cardInternalGapL),

          // Skills list
          _SkillsList(skills: skills, isHovered: isHovered),

        ],
      ),
    );
  }
}

// Skills List — bullet list of skill chips inside the card

class _SkillsList extends StatelessWidget {

  const _SkillsList({
    required this.skills,
    required this.isHovered,
  });

  final List<String>  skills;
  final bool          isHovered;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing:    AppSizes.spaceS,
      runSpacing: AppSizes.spaceS,
      children: skills.map((skill) {
        return AnimatedContainer(
          duration: AppSizes.durationDefault,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spaceM,
            vertical:   AppSizes.spaceXXS,
          ),
          decoration: BoxDecoration(
            color: isHovered
                ? AppColors.gold.withOpacity(0.08)
                : AppColors.lightGrey,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isHovered
                  ? AppColors.gold.withOpacity(0.5)
                  : Colors.transparent,
              width: AppSizes.borderThin,
            ),
          ),
          child: Text(
            skill,
            style: AppTextStyle.chip.copyWith(
              color: isHovered ? AppColors.gold : AppColors.grey,
            ),
          ),
        );
      }).toList(),
    );
  }
}

// Defocus Overlay
// A frosted glass layer rendered on top of non-hovered cards.
// ClipRRect matches the card's border radius so the blur stays inside
// the card boundary and doesn't bleed into the surrounding layout.
// The white fill at 50% opacity dims the card without hiding its content.

class _DefocusOverlay extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.radiusL),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: AnimatedContainer(
            duration: AppSizes.durationDefault,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.50),
              borderRadius: BorderRadius.circular(AppSizes.radiusL),
            ),
          ),
        ),
      ),
    );
  }
}
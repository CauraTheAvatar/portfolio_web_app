import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:portfolio_web_app/core/constants/app_strings.dart';
import 'package:portfolio_web_app/core/responsive/responsive.dart';
import 'package:portfolio_web_app/core/navigation/route_names.dart';
import 'package:portfolio_web_app/core/constants/app_sizes.dart';

class ProjectsSection extends StatelessWidget {

  const ProjectsSection({super.key});

  // Category definitions
  static const List<_CategoryData> _categories = [
    _CategoryData(
      title:      AppStrings.catSoftware,
      subtitle:   'Web · Mobile · GitHub',
      icon:       Icons.code_rounded,
      route:      RouteNames.projectSoftware,
    ),
    _CategoryData(
      title:      AppStrings.catWordPress,
      subtitle:   'Websites & CMS builds',
      icon:       Icons.language_rounded,
      route:      RouteNames.projectWordPress,
    ),
    _CategoryData(
      title:      AppStrings.catDataEng,
      subtitle:   'Pipelines & infrastructure',
      icon:       Icons.storage_rounded,
      route:      RouteNames.projectDataEng,
    ),
    _CategoryData(
      title:      AppStrings.catDataViz,
      subtitle:   'Tableau dashboards',
      icon:       Icons.bar_chart_rounded,
      route:      RouteNames.projectDataAnal,
    ),
    _CategoryData(
      title:      AppStrings.catDataAnalytics,
      subtitle:   'Analysis · docs · code',
      icon:       Icons.analytics_rounded,
      route:      RouteNames.projectDataAnal,
    ),
    _CategoryData(
      title:      AppStrings.catUIDesign,
      subtitle:   'Figma · Canva interfaces',
      icon:       Icons.design_services_rounded,
      route:      RouteNames.projectUIDesign,
    ),
    _CategoryData(
      title:      AppStrings.catGraphicDesign,
      subtitle:   'Posters · branding · print',
      icon:       Icons.brush_rounded,
      route:      RouteNames.projectGraphic,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);

    return SectionWrapper(
      color: AppColors.lightGrey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          // Section heading
          _SectionHeader(),

          const SizedBox(height: AppSizes.sectionHeaderGapContent),

          // Responsive card grid
          _CategoryGrid(
            categories: _categories,
            columns: screen.projectCardColumns,
          ),

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

        // Overline
        Text(
          'WHAT I\'VE BUILT',
          style: AppTextStyle.overline,
        ),

        const SizedBox(height: AppSizes.sectionHeaderGapOverline),

        // Title
        Text(
          AppStrings.projectsTitle,
          style: AppTextStyle.sectionTitle,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: AppSizes.sectionHeaderGapRule),

        // Gold rule
        Container(
          width: AppSizes.goldRuleWidth,
          height: AppSizes.goldRuleHeight,
          decoration: BoxDecoration(
            color: AppColors.gold,
            borderRadius: BorderRadius.circular(AppSizes.radiusXS),
          ),
        ),

        const SizedBox(height: AppSizes.sectionHeaderGapSubtitle),

        // Subtitle
        Text(
          AppStrings.projectsSubtitle,
          style: AppTextStyle.sectionSubtitle,
          textAlign: TextAlign.center,
        ),

      ],
    );
  }
}

// Category Grid
class _CategoryGrid extends StatelessWidget {

  const _CategoryGrid({
    required this.categories,
    required this.columns,
  });

  final List<_CategoryData> categories;
  final int                 columns;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final spacing     = AppSizes.cardGridSpacing;
        final totalSpacing = spacing * (columns - 1);
        final cardWidth   = (constraints.maxWidth - totalSpacing) / columns;

        return Wrap(
          spacing:     spacing,
          runSpacing:  spacing,
          children: categories.map((cat) {
            return SizedBox(
              width: cardWidth,
              child: _CategoryCard(data: cat),
            );
          }).toList(),
        );
      },
    );
  }
}

// Category Card
class _CategoryCard extends StatefulWidget {

  const _CategoryCard({required this.data});
  final _CategoryData data;

  @override
  State<_CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<_CategoryCard>
    with SingleTickerProviderStateMixin {

  bool _hovered = false;
  late final AnimationController _controller;
  late final Animation<double>   _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppSizes.durationFast,
    );
    _scale = Tween<double>(begin: 1.0, end: 1.03)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onEnter(_) {
    setState(() => _hovered = true);
    _controller.forward();
  }

  void _onExit(_) {
    setState(() => _hovered = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: _onEnter,
      onExit:  _onExit,
      child: GestureDetector(
        onTap: () => Get.toNamed(widget.data.route),
        child: ScaleTransition(
          scale: _scale,
          child: AnimatedContainer(
            duration: AppSizes.durationDefault,
            padding: const EdgeInsets.all(AppSizes.cardPadding),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppSizes.radiusL),
              border: Border.all(
                color: _hovered
                    ? AppColors.gold
                    : AppColors.gold.withOpacity(0.35),
                width: AppSizes.borderDefault,
              ),
              boxShadow: _hovered
                  ? [
                      // Gold glow
                      BoxShadow(
                        color: AppColors.gold.withOpacity(0.22),
                        blurRadius: AppSizes.cardShadowBlurHover,
                        offset: const Offset(0, 8),
                      ),
                      // Neutral depth
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: AppSizes.cardShadowBlurDepth,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: AppSizes.cardShadowBlurRest,
                        offset: const Offset(0, 2),
                      ),
                    ],
            ),
            child: _CardContent(data: widget.data, hovered: _hovered),
          ),
        ),
      ),
    );
  }
}

// Card Content — icon + title + subtitle + arrow
class _CardContent extends StatelessWidget {

  const _CardContent({
    required this.data,
    required this.hovered,
  });

  final _CategoryData data;
  final bool          hovered;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // Icon container
        AnimatedContainer(
          duration: AppSizes.durationDefault,
          width:  AppSizes.cardIconContainerSize,
          height: AppSizes.cardIconContainerSize,
          decoration: BoxDecoration(
            color: hovered
                ? AppColors.gold.withOpacity(0.12)
                : AppColors.lightGrey,
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
          ),
          child: Icon(
            data.icon,
            size:  AppSizes.cardIconSize,
            color: hovered ? AppColors.gold : AppColors.grey,
          ),
        ),

        const SizedBox(height: AppSizes.cardInternalGapL),

        // Category title
        AnimatedDefaultTextStyle(
          duration: AppSizes.durationDefault,
          style: AppTextStyle.cardTitle.copyWith(
            color: hovered ? AppColors.gold : AppColors.black,
          ),
          child: Text(data.title),
        ),

        const SizedBox(height: AppSizes.cardInternalGapS),

        // Subtitle
        Text(
          data.subtitle,
          style: AppTextStyle.bodySmall,
        ),

        const SizedBox(height: AppSizes.cardInternalGapL),

        // Arrow
        AnimatedSlide(
          offset: hovered ? const Offset(0.15, 0) : Offset.zero,
          duration: AppSizes.durationDefault,
          curve: Curves.easeOut,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'View Projects',
                style: AppTextStyle.overline.copyWith(fontSize: AppSizes.cardArrowLabelSize),
              ),
              const SizedBox(width: AppSizes.cardArrowGap),
              Icon(
                Icons.arrow_forward_rounded,
                size:  AppSizes.cardArrowIconSize,
                color: AppColors.gold,
              ),
            ],
          ),
        ),

      ],
    );
  }
}

// Category Data 
class _CategoryData {

  const _CategoryData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
  });

  final String    title;
  final String    subtitle;
  final IconData  icon;
  final String    route;
}
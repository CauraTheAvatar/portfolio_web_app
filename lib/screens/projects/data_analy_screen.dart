import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:portfolio_web_app/core/constants/app_strings.dart';
import 'package:portfolio_web_app/core/constants/app_sizes.dart';
import 'package:portfolio_web_app/core/responsive/responsive.dart';
import 'package:portfolio_web_app/core/navigation/route_names.dart';
import 'package:portfolio_web_app/screens/projects/secondary_screen_shell.dart';
import 'package:portfolio_web_app/screens/widgets/cards/project_card.dart' as project_card; 

// Data Analytics Screen
class DataAnalyScreen extends StatelessWidget {
  const DataAnalyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);
    return SecondaryScreenShell(
      title: AppStrings.catDataAnalytics,
      overline: 'ANALYTICS',
      child: ProjectGrid(
        columns: screen.subProjectCardColumns,
        cards: [
          SubCategoryCard(
            title: 'Data Analytics Projects',
            description:
                'Full project documentation with downloadable reports for each analysis.',
            icon: Icons.analytics_rounded,
            onTap: () => Get.toNamed(RouteNames.dataAnalFull),
          ),
          SubCategoryCard(
            title: 'Tableau Dashboards',
            description:
                'Interactive data visualisation dashboards published on Tableau Public.',
            icon: Icons.bar_chart_rounded,
            onTap: () => Get.to(() => const DataAnalVizScreen()),
          ),
          SubCategoryCard(
            title: 'Code Repositories',
            description:
                'Python scripts, Jupyter notebooks, and SQL queries stored on GitHub.',
            icon: Icons.code_rounded,
            onTap: () => Get.toNamed(RouteNames.dataAnalCode),
          ),
        ],
      ),
    );
  }
}

// Data Analytics Projects Screen
class DataAnalProjectsScreen extends StatelessWidget {
  const DataAnalProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);
    final projects = AppStrings.analyticsProjects;

    return SecondaryScreenShell(
      title: 'Data Analytics Projects',
      overline: 'ANALYTICS',
      child: projects.isEmpty
          ? const _EmptyState()
          : ProjectGrid(
              columns: screen.subProjectCardColumns,
              cards: projects.map((p) => _AnalyticsProjectCard(
                    title: p['title']!,
                    summary: p['summary']!,
                    docUrl: p['docUrl']!,
                  )).toList(),
            ),
    );
  }
}

// Analytics project card
class _AnalyticsProjectCard extends StatefulWidget {
  const _AnalyticsProjectCard({
    required this.title,
    required this.summary,
    required this.docUrl,
  });
  final String title;
  final String summary;
  final String docUrl;

  @override
  State<_AnalyticsProjectCard> createState() => _AnalyticsProjectCardState();
}

class _AnalyticsProjectCardState extends State<_AnalyticsProjectCard>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: AppSizes.durationDefault);
    _scale = Tween<double>(begin: 1.0, end: 1.03)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _hovered = true);
        _ctrl.forward();
      },
      onExit: (_) {
        setState(() => _hovered = false);
        _ctrl.reverse();
      },
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
                    BoxShadow(
                      color: AppColors.gold.withOpacity(0.20),
                      blurRadius: AppSizes.cardShadowBlurHover,
                      offset: const Offset(0, 8),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.07),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              AnimatedDefaultTextStyle(
                duration: AppSizes.durationDefault,
                style: AppTextStyle.cardTitle.copyWith(
                  color: _hovered ? AppColors.gold : AppColors.black,
                ),
                child: Text(widget.title),
              ),

              const SizedBox(height: AppSizes.cardInternalGapS),

              // Gold rule
              Container(
                width: AppSizes.goldRuleWidth,
                height: AppSizes.borderAccent,
                decoration: BoxDecoration(
                  color: AppColors.gold,
                  borderRadius: BorderRadius.circular(AppSizes.radiusXXL),
                ),
              ),

              const SizedBox(height: AppSizes.cardInternalGapL),

              // Summary
              Text(
                widget.summary,
                style: AppTextStyle.bodyMedium,
              ),

              const SizedBox(height: AppSizes.cardInternalGapL),

              // Download button
              _DownloadButton(docUrl: widget.docUrl),
            ],
          ),
        ),
      ),
    );
  }
}

// Download Documentation button
class _DownloadButton extends StatefulWidget {
  const _DownloadButton({required this.docUrl});
  final String docUrl;

  @override
  State<_DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<_DownloadButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => debugPrint('[Download] ${widget.docUrl}'),
        // Replace with: launchUrl(Uri.parse(widget.docUrl))
        child: AnimatedContainer(
          duration: AppSizes.durationDefault,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spaceXXL,
            vertical: AppSizes.spaceM,
          ),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.gold : AppColors.black,
            borderRadius: BorderRadius.circular(AppSizes.radiusS),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.download_rounded,
                size: AppSizes.iconXS,
                color: AppColors.white,
              ),
              const SizedBox(width: AppSizes.spaceS),
              AnimatedDefaultTextStyle(
                duration: AppSizes.durationDefault,
                style: AppTextStyle.buttonPrimary.copyWith(fontSize: 13),
                child: Text(AppStrings.ctaDownloadDoc),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Tableau Dashboards
class DataAnalVizScreen extends StatelessWidget {
  const DataAnalVizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);
    return SecondaryScreenShell(
      title: 'Tableau Dashboards',
      overline: 'ANALYTICS',
      child: ProjectGrid(
        columns: screen.subProjectCardColumns,
        cards: [
          project_card.ProjectCard(
            title: 'Tableau Public Profile',
            description:
                'View all published dashboards and interactive data visualisations on Tableau Public.',
            links: [ProjectLink.tableau(AppStrings.tableauProfile)],
          ),
        ],
      ),
    );
  }
}

// Code Repositories
class DataAnalCodeScreen extends StatelessWidget {
  const DataAnalCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);
    return SecondaryScreenShell(
      title: 'Code Repositories',
      overline: 'ANALYTICS',
      child: ProjectGrid(
        columns: screen.subProjectCardColumns,
        cards: [
          project_card.ProjectCard(
            title: 'Analytics Code Repository',
            description:
                'Python scripts, Jupyter notebooks, and SQL queries for all data analytics projects.',
            links: [ProjectLink.github(AppStrings.dataGithub)],
          ),
        ],
      ),
    );
  }
}

// Empty state
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.folder_open_rounded,
            size: 64,
            color: AppColors.gold.withOpacity(0.35),
          ),
          const SizedBox(height: AppSizes.spaceXXL),
          Text(
            'Projects coming soon.',
            style: AppTextStyle.bodyLarge.copyWith(color: AppColors.grey),
          ),
        ],
      ),
    );
  }
}
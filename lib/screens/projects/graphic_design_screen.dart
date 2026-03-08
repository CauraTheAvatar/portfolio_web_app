import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:portfolio_web_app/models/project_category_model.dart'; 
import 'package:portfolio_web_app/models/project_model.dart'; 

import 'package:portfolio_web_app/core/constants/app_strings.dart';
import 'package:portfolio_web_app/core/constants/app_sizes.dart';
import 'package:portfolio_web_app/core/responsive/responsive.dart';
import 'package:portfolio_web_app/core/theme/app_colors.dart';
import 'package:portfolio_web_app/core/theme/app_textstyle.dart';

import 'package:portfolio_web_app/screens/projects/secondary_screen_shell.dart';
import 'package:portfolio_web_app/screens/widgets/cards/gallery_card.dart';
import 'package:portfolio_web_app/services/analytics_service.dart';
import 'package:portfolio_web_app/services/project_service.dart';

class GraphicDesignScreen extends StatelessWidget {
  const GraphicDesignScreen({super.key});

  static const List<_GraphicCategory> _categories = [
    _GraphicCategory(
      title: 'Posters',
      description: 'Promotional and social media posters designed for print and digital.',
      icon: Icons.image_outlined,
      categoryType: 'posters',
    ),
    _GraphicCategory(
      title: 'Brand Graphics',
      description: 'Logo design, brand identity, and visual language systems.',
      icon: Icons.auto_awesome_rounded,
      categoryType: 'brand',
    ),
    _GraphicCategory(
      title: 'Event Graphics',
      description: 'Flyers, banners, and event collateral for live and virtual events.',
      icon: Icons.celebration_rounded,
      categoryType: 'events',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);
    
    // Track screen view
    AnalyticsService.to.logScreenView('graphic_design');

    return SecondaryScreenShell(
      title: AppStrings.catGraphicDesign,
      overline: 'VISUAL',
      child: ProjectGrid(
        columns: screen.subProjectCardColumns,
        cards: _categories.map((cat) => _GraphicCategoryCard(
          category: cat,
          onTap: () {
            AnalyticsService.to.logUserAction(
              'graphic_category_click',
              properties: {
                'category': cat.title,
              },
            );
            Get.to(
              () => GraphicGalleryScreen(category: cat),
              transition: Transition.rightToLeftWithFade,
            );
          },
        )).toList(),
      ),
    );
  }
}

// Graphic Gallery Screen
class GraphicGalleryScreen extends StatelessWidget {
  const GraphicGalleryScreen({super.key, required this.category});
  final _GraphicCategory category;

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);
    
    // Track gallery view
    AnalyticsService.to.logScreenView('graphic_gallery_${category.categoryType}');

    // Load projects from service with null safety
    final projects = ProjectService.to.getProjectsByCategory(
      ProjectCategory.graphicDesign,
    ).where((p) => p.type == ProjectType.graphicDesign).toList();

    if (projects.isEmpty) {
      return SecondaryScreenShell(
        title: category.title,
        overline: 'GRAPHIC DESIGN',
        child: const _EmptyGalleryState(),
      );
    }

    return SecondaryScreenShell(
      title: category.title,
      overline: 'GRAPHIC DESIGN',
      child: _GalleryGrid(
        projects: projects,
        columns: screen.galleryColumns,
      ),
    );
  }
}

// Gallery Grid
class _GalleryGrid extends StatelessWidget {
  const _GalleryGrid({
    required this.projects,
    required this.columns,
  });

  final List<ProjectModel> projects;
  final int columns;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final spacing = AppSizes.cardGridSpacing;
        final cardWidth =
            (constraints.maxWidth - spacing * (columns - 1)) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: projects.map((project) {
            // Safely access properties with null checks
            final imageUrl = project.thumbnailUrl ?? 
                (project.imageUrls.isNotEmpty ? project.imageUrls.first : '');
            
            return SizedBox(
              width: cardWidth,
              child: GalleryCard(
                id: project.id,
                title: project.title,
                imageUrl: imageUrl,
                type: GalleryCardType.graphicDesign,
                links: project.links,
                onViewFull: () {
                  AnalyticsService.to.trackProjectInteraction(
                    projectId: project.id,
                    projectTitle: project.title,
                    action: 'view_full',
                  );
                },
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

// Category Card
class _GraphicCategoryCard extends StatefulWidget {
  const _GraphicCategoryCard({
    required this.category,
    required this.onTap,
  });
  final _GraphicCategory category;
  final VoidCallback onTap;

  @override
  State<_GraphicCategoryCard> createState() => _GraphicCategoryCardState();
}

class _GraphicCategoryCardState extends State<_GraphicCategoryCard>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: AppSizes.durationDefault);
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
    // Get count from service with null safety
    final projectCount = ProjectService.to.getProjectsByCategory(
      ProjectCategory.graphicDesign,
    ).where((p) => p.type == ProjectType.graphicDesign).length;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
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
        child: GestureDetector(
          onTap: widget.onTap,
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
                        color: AppColors.gold.withOpacity(0.22),
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
                AnimatedContainer(
                  duration: AppSizes.durationDefault,
                  width: AppSizes.cardIconContainerSize,
                  height: AppSizes.cardIconContainerSize,
                  decoration: BoxDecoration(
                    color: _hovered
                        ? AppColors.gold.withOpacity(0.12)
                        : AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(AppSizes.radiusM),
                  ),
                  child: Icon(
                    widget.category.icon,
                    size: AppSizes.cardIconSize,
                    color: _hovered ? AppColors.gold : AppColors.grey,
                  ),
                ),
                const SizedBox(height: AppSizes.cardInternalGapL),
                AnimatedDefaultTextStyle(
                  duration: AppSizes.durationDefault,
                  style: AppTextStyle.cardTitle.copyWith(
                    color: _hovered ? AppColors.gold : AppColors.black,
                  ),
                  child: Text(widget.category.title),
                ),
                const SizedBox(height: AppSizes.cardInternalGapS),
                Text(
                  widget.category.description,
                  style: AppTextStyle.bodyMedium,
                ),
                const SizedBox(height: AppSizes.cardInternalGapL),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      projectCount == 0
                          ? 'Coming soon'
                          : '$projectCount ${projectCount == 1 ? 'project' : 'projects'}',
                      style: AppTextStyle.bodySmall.copyWith(
                        color: AppColors.gold,
                      ),
                    ),
                    AnimatedSlide(
                      offset: _hovered ? const Offset(0.2, 0) : Offset.zero,
                      duration: AppSizes.durationDefault,
                      curve: Curves.easeOut,
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        size: AppSizes.cardArrowIconSize,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Data Model
class _GraphicCategory {
  const _GraphicCategory({
    required this.title,
    required this.description,
    required this.icon,
    required this.categoryType,
  });
  final String title;
  final String description;
  final IconData icon;
  final String categoryType;
}

// Empty States
class _EmptyGalleryState extends StatelessWidget {
  const _EmptyGalleryState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.photo_library_rounded,
            size: 64,
            color: AppColors.gold.withOpacity(0.35),
          ),
          const SizedBox(height: AppSizes.spaceXXL),
          Text(
            'Images coming soon.',
            style: AppTextStyle.bodyLarge.copyWith(color: AppColors.grey),
          ),
          const SizedBox(height: AppSizes.spaceS),
          Text(
            'Add projects to populate the gallery.',
            style: AppTextStyle.bodySmall,
          ),
        ],
      ),
    );
  }
}
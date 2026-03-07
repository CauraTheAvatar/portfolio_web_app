import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:portfolio_web_app/core/constants/app_strings.dart';
import 'package:portfolio_web_app/core/constants/app_sizes.dart';
import 'package:portfolio_web_app/core/responsive/responsive.dart';
import 'package:portfolio_web_app/screens/projects/secondary_screen_shell.dart';

class GraphicDesignScreen extends StatelessWidget {
  const GraphicDesignScreen({super.key});

  static const List<_GraphicCategory> _categories = [

    _GraphicCategory(
      title:       'Posters',
      description: 'Promotional and social media posters designed for print and digital.',
      icon:        Icons.image_outlined,
      images: [
        // Add poster asset paths here:
        // 'assets/images/graphic/posters/poster_1.jpg',
        // 'assets/images/graphic/posters/poster_2.jpg',
      ],
    ),

    _GraphicCategory(
      title:       'Brand Graphics',
      description: 'Logo design, brand identity, and visual language systems.',
      icon:        Icons.auto_awesome_rounded,
      images: [
        // Add brand graphic asset paths here:
        // 'assets/images/graphic/brand/brand_1.jpg',
        // 'assets/images/graphic/brand/brand_2.jpg',
      ],
    ),

    _GraphicCategory(
      title:       'Event Graphics',
      description: 'Flyers, banners, and event collateral for live and virtual events.',
      icon:        Icons.celebration_rounded,
      images: [
        // Add event graphic asset paths here:
        // 'assets/images/graphic/events/event_1.jpg',
        // 'assets/images/graphic/events/event_2.jpg',
      ],
    ),

  ];

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);
    return SecondaryScreenShell(
      title:    AppStrings.catGraphicDesign,
      overline: 'VISUAL',
      child: ProjectGrid(
        columns: screen.subProjectCardColumns,
        cards: _categories.map((cat) => _GraphicCategoryCard(
          category: cat,
          onTap:    () => Get.to(
            () => GraphicGalleryScreen(category: cat),
            transition: Transition.rightToLeftWithFade,
          ),
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

    return SecondaryScreenShell(
      title:    category.title,
      overline: 'GRAPHIC DESIGN',
      child: category.images.isEmpty
          ? const _EmptyGalleryState()
          : _PhotoGrid(
              images:  category.images,
              columns: screen.galleryColumns,
            ),
    );
  }
}

// Photo Grid
class _PhotoGrid extends StatelessWidget {
  const _PhotoGrid({
    required this.images,
    required this.columns,
  });

  final List<String> images;
  final int          columns;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final spacing   = AppSizes.cardGridSpacing;
        final cardWidth =
            (constraints.maxWidth - spacing * (columns - 1)) / columns;

        return Wrap(
          spacing:    spacing,
          runSpacing: spacing,
          children: images.map((path) => SizedBox(
            width: cardWidth,
            child: _PhotoCard(imagePath: path),
          )).toList(),
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
  final VoidCallback     onTap;

  @override
  State<_GraphicCategoryCard> createState() => _GraphicCategoryCardState();
}

class _GraphicCategoryCardState extends State<_GraphicCategoryCard>
    with SingleTickerProviderStateMixin {

  bool _hovered = false;
  late final AnimationController _ctrl;
  late final Animation<double>   _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: AppSizes.durationDefault);
    _scale = Tween<double>(begin: 1.0, end: 1.03)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final imageCount = widget.category.images.length;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) { setState(() => _hovered = true);  _ctrl.forward(); },
      onExit:  (_) { setState(() => _hovered = false); _ctrl.reverse(); },
      child: ScaleTransition(
        scale: _scale,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: AppSizes.durationDefault,
            padding: const EdgeInsets.all(AppSizes.cardPadding),
            decoration: BoxDecoration(
              color:        AppColors.white,
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
                    color: _hovered
                        ? AppColors.gold.withOpacity(0.12)
                        : AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(AppSizes.radiusM),
                  ),
                  child: Icon(
                    widget.category.icon,
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
                  child: Text(widget.category.title),
                ),

                const SizedBox(height: AppSizes.cardInternalGapS),

                // Description
                Text(
                  widget.category.description,
                  style: AppTextStyle.bodyMedium,
                ),

                const SizedBox(height: AppSizes.cardInternalGapL),

                // Image count + arrow
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      imageCount == 0
                          ? 'Coming soon'
                          : '$imageCount ${imageCount == 1 ? 'image' : 'images'}',
                      style: AppTextStyle.bodySmall.copyWith(
                        color: AppColors.gold,
                      ),
                    ),
                    AnimatedSlide(
                      offset: _hovered
                          ? const Offset(0.2, 0)
                          : Offset.zero,
                      duration: AppSizes.durationDefault,
                      curve:    Curves.easeOut,
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        size:  AppSizes.cardArrowIconSize,
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

// Photo Card
class _PhotoCard extends StatefulWidget {
  const _PhotoCard({required this.imagePath});
  final String imagePath;

  @override
  State<_PhotoCard> createState() => _PhotoCardState();
}

class _PhotoCardState extends State<_PhotoCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: AppSizes.durationDefault,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radiusL),
          border: Border.all(
            color: _hovered
                ? AppColors.gold
                : AppColors.gold.withOpacity(0.30),
            width: AppSizes.borderDefault,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color:      AppColors.gold.withOpacity(0.20),
                    blurRadius: AppSizes.cardShadowBlurHover,
                    offset:     const Offset(0, 6),
                  ),
                ]
              : [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.radiusL - 1),
          child: Image.asset(
            widget.imagePath,
            fit: BoxFit.cover,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded) return child;
              return AnimatedOpacity(
                opacity:  frame == null ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 400),
                curve:    Curves.easeIn,
                child:    child,
              );
            },
            errorBuilder: (_, __, ___) => Container(
              height: 220,
              color:  AppColors.lightGrey,
              child:  Center(
                child: Icon(
                  Icons.image_rounded,
                  size:  36,
                  color: AppColors.gold.withOpacity(0.35),
                ),
              ),
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
    this.images = const [],
  });
  final String       title;
  final String       description;
  final IconData     icon;
  final List<String> images;
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
          Icon(Icons.photo_library_rounded, size: 64,
              color: AppColors.gold.withOpacity(0.35)),
          const SizedBox(height: AppSizes.spaceXXL),
          Text('Images coming soon.',
              style: AppTextStyle.bodyLarge.copyWith(color: AppColors.grey)),
          const SizedBox(height: AppSizes.spaceS),
          Text('Add asset paths to this category to populate the gallery.',
              style: AppTextStyle.bodySmall),
        ],
      ),
    );
  }
}
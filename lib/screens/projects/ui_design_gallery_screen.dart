import 'package:flutter/material.dart';
import 'package:portfolio_web_app/core/constants/app_strings.dart';
import 'package:portfolio_web_app/core/constants/app_sizes.dart';
import 'package:portfolio_web_app/core/responsive/responsive.dart';
import 'package:portfolio_web_app/screens/projects/secondary_screen_shell.dart';
import 'package:portfolio_web_app/screens/widgets/images/cached_gallery_image.dart';

class UIDesignGalleryScreen extends StatelessWidget {
  const UIDesignGalleryScreen({super.key});

  static const List<_UIProject> _projects = [
    // Add UI design projects here:
    // _UIProject(
    //   title:       'Prayer Box App UI',
    //   imageUrl:    'https://firebasestorage.googleapis.com/.../prayer_box_ui.jpg',
    //   figmaUrl:    'https://figma.com/@yourname',
    //   canvaUrl:    null,
    // ),
    // _UIProject(
    //   title:       'Portfolio Website UI',
    //   imageUrl:    'https://firebasestorage.googleapis.com/.../portfolio_ui.jpg',
    //   figmaUrl:    'https://figma.com/@yourname',
    //   canvaUrl:    'https://canva.com/yourname',
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);

    return SecondaryScreenShell(
      title:    AppStrings.catUIDesign,
      overline: 'DESIGN',
      child: _projects.isEmpty
          ? const _EmptyState()
          : _UIGalleryGrid(
              projects: _projects,
              columns:  screen.galleryColumns,
            ),
    );
  }
}

// Gallery Grid 
class _UIGalleryGrid extends StatelessWidget {
  const _UIGalleryGrid({
    required this.projects,
    required this.columns,
  });

  final List<_UIProject> projects;
  final int              columns;

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
          children: projects.map((p) => SizedBox(
            width: cardWidth,
            child: _UIDesignCard(project: p),
          )).toList(),
        );
      },
    );
  }
}

// UI Design Card 
class _UIDesignCard extends StatefulWidget {
  const _UIDesignCard({required this.project});
  final _UIProject project;

  @override
  State<_UIDesignCard> createState() => _UIDesignCardState();
}

class _UIDesignCardState extends State<_UIDesignCard>
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

  // Opens full-screen image viewer on 'View Full' tap
  void _showFullImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.88),
      builder: (_) => _FullImageDialog(imageUrl: imageUrl),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) { setState(() => _hovered = true);  _ctrl.forward(); },
      onExit:  (_) { setState(() => _hovered = false); _ctrl.reverse(); },
      child: ScaleTransition(
        scale: _scale,
        child: AnimatedContainer(
          duration: AppSizes.durationDefault,
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
                      color:      AppColors.gold.withOpacity(0.20),
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

              // Lazy-loaded preview image with hover overlay (Phase 32) 
              CachedGalleryImage(
                imageUrl:        widget.project.imageUrl,
                borderRadiusTop: true,
                overlayActions: [
                  GalleryOverlayAction.viewFull(
                    onTap: () => _showFullImage(
                        context, widget.project.imageUrl),
                  ),
                  if (widget.project.figmaUrl != null)
                    GalleryOverlayAction.figma(
                        url: widget.project.figmaUrl!),
                  if (widget.project.canvaUrl != null)
                    GalleryOverlayAction.canva(
                        url: widget.project.canvaUrl!),
                ],
              ),

              // Card content 
              Padding(
                padding: const EdgeInsets.all(AppSizes.cardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Title
                    AnimatedDefaultTextStyle(
                      duration: AppSizes.durationDefault,
                      style: AppTextStyle.cardTitle.copyWith(
                        color: _hovered ? AppColors.gold : AppColors.black,
                      ),
                      child: Text(widget.project.title),
                    ),

                    const SizedBox(height: AppSizes.spaceS),

                    // Gold rule
                    Container(
                      width:  AppSizes.goldRuleWidth,
                      height: 2.5,
                      decoration: BoxDecoration(
                        color:        AppColors.gold,
                        borderRadius: BorderRadius.circular(AppSizes.radiusXXL),
                      ),
                    ),

                    // Links shown in image hover overlay (Phase 32)

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}



// Data Model 
class _UIProject {
  const _UIProject({
    required this.title,
    required this.imageUrl,
    this.figmaUrl,
    this.canvaUrl,
  });
  final String  title;
  final String  imageUrl;
  final String? figmaUrl;
  final String? canvaUrl;
}

// Empty State 
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.design_services_rounded,
            size:  64,
            color: AppColors.gold.withOpacity(0.35),
          ),
          const SizedBox(height: AppSizes.spaceXXL),
          Text(
            'UI design projects coming soon.',
            style: AppTextStyle.bodyLarge.copyWith(color: AppColors.grey),
          ),
          const SizedBox(height: AppSizes.spaceS),
          Text(
            'Add entries to _projects to populate the gallery.',
            style: AppTextStyle.bodySmall,
          ),
        ],
      ),
    );
  }
}

// Full Image Dialog — opened by "View Full" overlay button 
class _FullImageDialog extends StatelessWidget {
  const _FullImageDialog({required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Center(
              child: Hero(
                tag: imageUrl,
                child: CachedNetworkImage(
                  imageUrl:    imageUrl,
                  fit:         BoxFit.contain,
                  placeholder: (_, __) => const CircularProgressIndicator(
                      color: AppColors.gold),
                  errorWidget: (_, __, ___) => const Icon(
                      Icons.broken_image_rounded,
                      color: AppColors.gold, size: 48),
                ),
              ),
            ),
            Positioned(
              top:   AppSizes.space3XL,
              right: AppSizes.spaceXXL,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  padding: const EdgeInsets.all(AppSizes.spaceS),
                  decoration: BoxDecoration(
                    color:        AppColors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(AppSizes.radiusS),
                    border: Border.all(
                        color: AppColors.white.withOpacity(0.4),
                        width: AppSizes.borderThin),
                  ),
                  child: const Icon(Icons.close_rounded,
                      color: AppColors.white, size: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
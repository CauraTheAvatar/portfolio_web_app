import 'package:flutter/material.dart';
import 'package:portfolio_web_app/screens/widgets/images/cached_gallery_image.dart';
import 'package:portfolio_web_app/core/constants/app_sizes.dart';
import 'package:portfolio_web_app/core/constants/app_strings.dart';

class CachedGalleryImage extends StatefulWidget {

  const CachedGalleryImage({
    super.key,
    required this.imageUrl,
    this.height          = 220,
    this.fit             = BoxFit.cover,
    this.borderRadiusTop = false,
    this.overlayActions  = const [],
  });

  final String                    imageUrl;
  final double                    height;
  final BoxFit                    fit;
  final bool                      borderRadiusTop;
  final List<GalleryOverlayAction> overlayActions;

  @override
  State<CachedGalleryImage> createState() => _CachedGalleryImageState();
}

class _CachedGalleryImageState extends State<CachedGalleryImage>
    with SingleTickerProviderStateMixin {

  bool _hovered = false;
  late final AnimationController _overlayCtrl;
  late final Animation<double>   _scrimOpacity;
  late final Animation<Offset>   _buttonsSlide;

  @override
  void initState() {
    super.initState();
    _overlayCtrl = AnimationController(
        vsync: this, duration: AppSizes.durationOverlay);

    _scrimOpacity = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _overlayCtrl, curve: Curves.easeOut));

    _buttonsSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end:   Offset.zero,
    ).animate(CurvedAnimation(parent: _overlayCtrl, curve: Curves.easeOut));
  }

  @override
  void dispose() { _overlayCtrl.dispose(); super.dispose(); }

  BorderRadius get _radius => widget.borderRadiusTop
      ? const BorderRadius.vertical(top: Radius.circular(AppSizes.radiusL))
      : BorderRadius.circular(AppSizes.radiusL - 1);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _hovered = true);
        _overlayCtrl.forward();
      },
      onExit: (_) {
        setState(() => _hovered = false);
        _overlayCtrl.reverse();
      },
      child: ClipRRect(
        borderRadius: _radius,
        child: SizedBox(
          height: widget.height,
          width:  double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [

              // Base image 
              CachedNetworkImage(
                imageUrl:       widget.imageUrl,
                fit:            widget.fit,
                fadeInDuration: const Duration(milliseconds: 400),
                fadeInCurve:    Curves.easeIn,
                placeholder: (_, __) => const _LoadingPlaceholder(),
                errorWidget:  (_, __, ___) => const _ErrorPlaceholder(),
              ),

              // Hover scrim + action buttons (Phase 32) 
              if (widget.overlayActions.isNotEmpty)
                FadeTransition(
                  opacity: _scrimOpacity,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end:   Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.15),
                          Colors.black.withOpacity(0.72),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSizes.spaceXXL),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SlideTransition(
                            position: _buttonsSlide,
                            child: Wrap(
                              spacing:    AppSizes.spaceS,
                              runSpacing: AppSizes.spaceS,
                              children: widget.overlayActions
                                  .map((a) => _OverlayButton(action: a))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }
}

// Overlay Button 
class _OverlayButton extends StatefulWidget {
  const _OverlayButton({required this.action});
  final GalleryOverlayAction action;
  @override State<_OverlayButton> createState() => _OverlayButtonState();
}

class _OverlayButtonState extends State<_OverlayButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.action.onTap,
        child: AnimatedContainer(
          duration: AppSizes.durationDefault,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spaceXXL,
            vertical:   AppSizes.spaceS,
          ),
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.gold
                : AppColors.white.withOpacity(0.15),
            border: Border.all(
              color: _hovered ? AppColors.gold : AppColors.white.withOpacity(0.7),
              width: AppSizes.borderThin,
            ),
            borderRadius: BorderRadius.circular(AppSizes.radiusS),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.action.icon,
                size:  AppSizes.iconXS,
                color: AppColors.white,
              ),
              const SizedBox(width: AppSizes.spaceXXS),
              Text(
                widget.action.label,
                style: AppTextStyle.buttonSecondary.copyWith(
                  fontSize: 12,
                  color:    AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// GalleryOverlayAction — data model for overlay buttons 
class GalleryOverlayAction {
  const GalleryOverlayAction({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String       label;
  final IconData     icon;
  final VoidCallback onTap;

  factory GalleryOverlayAction.viewFull({required VoidCallback onTap}) =>
      GalleryOverlayAction(
        label: 'View Full',
        icon:  Icons.fullscreen_rounded,
        onTap: onTap,
      );

  factory GalleryOverlayAction.figma({required String url}) =>
      GalleryOverlayAction(
        label: AppStrings.ctaViewFigma,
        icon:  Icons.design_services_rounded,
        onTap: () => debugPrint('[Figma] $url'),
        // Replace with: launchUrl(Uri.parse(url))
      );

  factory GalleryOverlayAction.canva({required String url}) =>
      GalleryOverlayAction(
        label: AppStrings.ctaViewCanva,
        icon:  Icons.brush_rounded,
        onTap: () => debugPrint('[Canva] $url'),
        // Replace with: launchUrl(Uri.parse(url))
      );
}

// Internal Placeholders 
class _LoadingPlaceholder extends StatelessWidget {
  const _LoadingPlaceholder();
  @override
  Widget build(BuildContext context) => Container(
    color: AppColors.lightGrey,
    child: const Center(
      child: SizedBox(
        width: 24, height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: AppColors.gold,
        ),
      ),
    ),
  );
}

class _ErrorPlaceholder extends StatelessWidget {
  const _ErrorPlaceholder();
  @override
  Widget build(BuildContext context) => Container(
    color: AppColors.lightGrey,
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.broken_image_rounded, size: 36,
              color: AppColors.gold.withOpacity(0.35)),
          const SizedBox(height: AppSizes.spaceS),
          Text('Image unavailable',
              style: AppTextStyle.bodySmall.copyWith(color: AppColors.grey)),
        ],
      ),
    ),
  );
}
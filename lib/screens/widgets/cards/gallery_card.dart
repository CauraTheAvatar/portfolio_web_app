import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:portfolio_web_app/core/constants/app_sizes.dart';
import 'package:portfolio_web_app/core/theme/app_colors.dart';
import 'package:portfolio_web_app/core/theme/app_textstyle.dart';

enum GalleryCardType {
  uiDesign,
  graphicDesign,
}

class GalleryCard extends StatefulWidget {
  final String id;
  final String title;
  final String imageUrl;
  final GalleryCardType type;
  final VoidCallback? onTap;
  final VoidCallback? onViewFull;
  final Map<String, String>? links; // e.g., {'figma': 'url', 'canva': 'url'}

  const GalleryCard({
    super.key,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.type,
    this.onTap,
    this.onViewFull,
    this.links,
  });

  @override
  State<GalleryCard> createState() => _GalleryCardState();
}

class _GalleryCardState extends State<GalleryCard> {
  bool _hovered = false;
  bool _isImageLoaded = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap ?? () => _showFullImage(context),
        child: AnimatedContainer(
          duration: AppSizes.durationDefault,
          transform: Matrix4.identity()..scale(_hovered ? 1.02 : 1.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppSizes.radiusL),
              border: Border.all(
                color: _hovered
                    ? AppColors.gold
                    : AppColors.gold.withOpacity(0.3),
                width: AppSizes.borderDefault,
              ),
              boxShadow: _hovered
                  ? [
                      BoxShadow(
                        color: AppColors.gold.withOpacity(0.2),
                        blurRadius: AppSizes.cardShadowBlurHover,
                        offset: const Offset(0, 8),
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
                // Image area
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppSizes.radiusL),
                  ),
                  child: Stack(
                    children: [
                      // Image
                      CachedNetworkImage(
                        imageUrl: widget.imageUrl,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Container(
                          height: 200,
                          color: AppColors.lightGrey,
                          child: const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.gold,
                            ),
                          ),
                        ),
                        errorWidget: (_, __, ___) => Container(
                          height: 200,
                          color: AppColors.lightGrey,
                          child: Icon(
                            Icons.broken_image_rounded,
                            size: 48,
                            color: AppColors.gold.withOpacity(0.5),
                          ),
                        ),
                      ),

                      // Hover overlay with actions
                      if (_hovered)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.6),
                                ],
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Action buttons
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (widget.onViewFull != null)
                                        _buildActionButton(
                                          icon: Icons.fullscreen_rounded,
                                          label: 'View',
                                          onTap: widget.onViewFull!,
                                        ),
                                      if (widget.links != null)
                                        ...widget.links!.entries.map(
                                          (entry) => Padding(
                                            padding: const EdgeInsets.only(left: 8),
                                            child: _buildActionButton(
                                              icon: _getIconForLink(entry.key),
                                              label: entry.key,
                                              onTap: () => _launchUrl(entry.value),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Title
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    widget.title,
                    style: AppTextStyle.cardTitle.copyWith(
                      color: _hovered ? AppColors.gold : AppColors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: AppColors.gold,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: AppColors.white),
              const SizedBox(width: 4),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForLink(String key) {
    switch (key.toLowerCase()) {
      case 'figma':
        return Icons.design_services_rounded;
      case 'canva':
        return Icons.brush_rounded;
      case 'github':
        return Icons.code_rounded;
      case 'live':
        return Icons.open_in_new_rounded;
      default:
        return Icons.link_rounded;
    }
  }

  void _launchUrl(String url) {
    // TODO: Implement with url_launcher
    debugPrint('Launching: $url');
  }

  void _showFullImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Stack(
          children: [
            Center(
              child: InteractiveViewer(
                panEnabled: true,
                minScale: 0.5,
                maxScale: 4.0,
                child: CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  placeholder: (_, __) => const Center(
                    child: CircularProgressIndicator(color: AppColors.gold),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.close_rounded, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
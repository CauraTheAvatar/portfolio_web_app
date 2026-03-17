import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:video_player/video_player.dart'; // ADD THIS DEPENDENCY
import 'package:portfolio_web_app/core/constants/app_sizes.dart';
import 'package:portfolio_web_app/core/theme/app_colors.dart';
import 'package:portfolio_web_app/core/theme/app_textstyle.dart';

enum GalleryCardType {
  uiDesign,
  graphicDesign,
  poster,
  logo,
  banner,
  video, // ADD THIS for video logos
}

class GalleryCard extends StatefulWidget {
  final String id;
  final String title;
  final String imageUrl;
  final GalleryCardType type;
  final VoidCallback? onTap;
  final VoidCallback? onViewFull;
  final Map<String, String>? links;
  final int? imageCount;
  final double? customAspectRatio;
  final bool isVideo; // ADD THIS to identify video assets

  const GalleryCard({
    super.key,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.type,
    this.onTap,
    this.onViewFull,
    this.links,
    this.imageCount,
    this.customAspectRatio,
    this.isVideo = false, // Default to false
  });

  @override
  State<GalleryCard> createState() => _GalleryCardState();
}

class _GalleryCardState extends State<GalleryCard> {
  bool _hovered = false;
  bool _isImageLoaded = false;
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    if (widget.isVideo) {
      _initializeVideo();
    }
  }

  void _initializeVideo() {
    _videoController = VideoPlayerController.asset(widget.imageUrl)
      ..initialize().then((_) {
        setState(() {
          _isVideoInitialized = true;
        });
        _videoController!.setLooping(true);
        _videoController!.setVolume(0); // Mute by default
      });
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _hovered = true);
        if (_isVideoInitialized) {
          _videoController!.play();
        }
      },
      onExit: (_) {
        setState(() => _hovered = false);
        if (_isVideoInitialized) {
          _videoController!.pause();
        }
      },
      child: GestureDetector(
        onTap: widget.onTap ?? () => _showFullMedia(context),
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
                // Media area with aspect ratio
                AspectRatio(
                  aspectRatio: _getAspectRatio(),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(AppSizes.radiusL),
                    ),
                    child: Stack(
                      children: [
                        // Image or Video
                        widget.isVideo && _isVideoInitialized
                            ? VideoPlayer(_videoController!)
                            : _buildImage(),

                        // Video indicator badge
                        if (widget.isVideo)
                          Positioned(
                            top: 12,
                            left: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: AppColors.gold,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.play_circle_rounded,
                                    size: 14,
                                    color: AppColors.gold,
                                  ),
                                  const SizedBox(width: 4),
                                  const Text(
                                    'VIDEO',
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        // Image count badge (for albums)
                        if (widget.imageCount != null && widget.imageCount! > 1)
                          Positioned(
                            top: 12,
                            right: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: AppColors.gold,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.photo_library_rounded,
                                    size: 12,
                                    color: AppColors.gold,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${widget.imageCount}',
                                    style: const TextStyle(
                                      color: AppColors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
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
                                    Colors.black.withOpacity(0.7),
                                  ],
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        if (widget.onViewFull != null)
                                          _buildActionButton(
                                            icon: widget.isVideo
                                                ? Icons.play_circle_rounded
                                                : Icons.fullscreen_rounded,
                                            label: widget.isVideo ? 'Play' : 'View',
                                            onTap: widget.onViewFull!,
                                          ),
                                        if (widget.links != null)
                                          ...widget.links!.entries.map(
                                            (entry) => Padding(
                                              padding: const EdgeInsets.only(left: 8),
                                              child: _buildActionButton(
                                                icon: _getIconForLink(entry.key),
                                                label: _getLabelForLink(entry.key),
                                                onTap: () => _launchUrl(entry.value),
                                              ),
                                            ),
                                          ),
                                        if (widget.imageCount != null && widget.imageCount! > 1)
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8),
                                            child: _buildActionButton(
                                              icon: Icons.photo_album_rounded,
                                              label: 'Album',
                                              onTap: widget.onTap ?? () {},
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
                ),

                // Title
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: AppTextStyle.cardTitle.copyWith(
                          color: _hovered ? AppColors.gold : AppColors.black,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (widget.imageCount != null && widget.imageCount! > 1)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            '${widget.imageCount} images',
                            style: AppTextStyle.bodySmall.copyWith(
                              color: AppColors.gold,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      if (widget.isVideo)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            'Video Logo',
                            style: AppTextStyle.bodySmall.copyWith(
                              color: AppColors.gold,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
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
      ),
    );
  }

  Widget _buildImage() {
    if (widget.imageUrl.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: widget.imageUrl,
        width: double.infinity,
        fit: BoxFit.cover,
        placeholder: (_, __) => Container(
          color: AppColors.lightGrey,
          child: const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.gold,
            ),
          ),
        ),
        errorWidget: (_, __, ___) => _buildErrorPlaceholder(),
      );
    } else {
      return Image.asset(
        widget.imageUrl,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildErrorPlaceholder(),
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) return child;
          return AnimatedOpacity(
            opacity: frame == null ? 0 : 1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
            child: child,
          );
        },
      );
    }
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      color: AppColors.lightGrey,
      child: Center(
        child: Icon(
          widget.isVideo ? Icons.videocam_off_rounded : Icons.broken_image_rounded,
          size: 48,
          color: AppColors.gold.withOpacity(0.5),
        ),
      ),
    );
  }

  double _getAspectRatio() {
    if (widget.customAspectRatio != null) {
      return widget.customAspectRatio!;
    }

    switch (widget.type) {
      case GalleryCardType.uiDesign:
        return 1.0;
      case GalleryCardType.graphicDesign:
        return 1.0;
      case GalleryCardType.poster:
        return 3/4;
      case GalleryCardType.logo:
        return 1.0;
      case GalleryCardType.banner:
        return 16/9;
      case GalleryCardType.video:
        return 16/9; // Usually videos are 16:9
    }
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
              Icon(icon, size: 14, color: AppColors.white),
              const SizedBox(width: 4),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 11,
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
      case 'notion':
        return Icons.description_rounded;
      case 'drive':
        return Icons.folder_rounded;
      default:
        return Icons.link_rounded;
    }
  }

  String _getLabelForLink(String key) {
    switch (key.toLowerCase()) {
      case 'figma':
        return 'Figma';
      case 'canva':
        return 'Canva';
      case 'github':
        return 'GitHub';
      case 'live':
        return 'Live';
      case 'notion':
        return 'Notion';
      case 'drive':
        return 'Drive';
      default:
        return key;
    }
  }

  void _launchUrl(String url) {
    debugPrint('Launching: $url');
  }

  void _showFullMedia(BuildContext context) {
    if (widget.isVideo) {
      _showVideoDialog(context);
    } else {
      _showFullImage(context);
    }
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
                child: widget.imageUrl.startsWith('http')
                    ? CachedNetworkImage(
                        imageUrl: widget.imageUrl,
                        placeholder: (_, __) => const Center(
                          child: CircularProgressIndicator(color: AppColors.gold),
                        ),
                      )
                    : Image.asset(
                        widget.imageUrl,
                        fit: BoxFit.contain,
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

  void _showVideoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Stack(
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.6,
                child: VideoPlayer(_videoController!),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.close_rounded, color: Colors.white),
                onPressed: () {
                  _videoController!.pause();
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
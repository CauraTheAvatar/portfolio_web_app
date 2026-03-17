import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:video_player/video_player.dart';
import 'package:portfolio_web_app/models/project_category_model.dart';
import 'package:portfolio_web_app/models/project_model.dart';

import 'package:portfolio_web_app/core/constants/app_strings.dart';
import 'package:portfolio_web_app/core/constants/app_sizes.dart';
import 'package:portfolio_web_app/core/responsive/responsive.dart';
import 'package:portfolio_web_app/core/theme/app_colors.dart';
import 'package:portfolio_web_app/core/theme/app_textstyle.dart';

import 'package:portfolio_web_app/screens/projects/secondary_screen_shell.dart';
import 'package:portfolio_web_app/services/analytics_service.dart';

class GraphicDesignScreen extends StatelessWidget {
  const GraphicDesignScreen({super.key});

  // SOCIAL MEDIA ALBUM - Fixed path to match your folder structure
  static const List<_GraphicAlbum> _socialMedia = [
    _GraphicAlbum(
      title: 'Abba Selah Social Media',
      description: 'Social media posts and Facebook content for Abba Selah Collectives - 11 designs for various platforms.',
      coverImage: 'assets/images/graphic/posters/social_media/abba_selah_socials_post_1.jpg',
      aspectRatio: GraphicAspectRatio.square,
      imagePaths: [
        'assets/images/graphic/posters/social_media/abba_selah_socials_post_1.jpg',
        'assets/images/graphic/posters/social_media/abba_selah_socials_post_2.jpg',
        'assets/images/graphic/posters/social_media/abba_selah_socials_post_3.jpg',
        'assets/images/graphic/posters/social_media/abba_selah_socials_post_4.jpg',
        'assets/images/graphic/posters/social_media/abba_selah_socials_post_5.jpg',
        'assets/images/graphic/posters/social_media/abba_selah_socials_post_6.jpg',
        'assets/images/graphic/posters/social_media/abba_selah_socials_post_7.jpg',
        'assets/images/graphic/posters/social_media/abba_selah_facebook_post_1.jpg',
        'assets/images/graphic/posters/social_media/abba_selah_facebook_post_2.jpg',
        'assets/images/graphic/posters/social_media/abba_selah_facebook_post_3.jpg',
        'assets/images/graphic/posters/social_media/abba_selah_facebook_post_4.jpg',
      ],
      isVideo: false,
    ),
  ];

  // PRINT MATERIALS ALBUM - Fixed path to match your folder structure
  static const List<_GraphicAlbum> _printMaterials = [
    _GraphicAlbum(
      title: 'Print Materials',
      description: 'Business invoice templates, nutrition menus, and other printable designs.',
      coverImage: 'assets/images/graphic/posters/print_materials/abba_selah_business_invoice_template.jpg',
      aspectRatio: GraphicAspectRatio.portrait,
      imagePaths: [
        'assets/images/graphic/posters/print_materials/abba_selah_business_invoice_template.jpg',
        'assets/images/graphic/posters/print_materials/tameka_nutrition_menu.jpg',
      ],
      isVideo: false,
    ),
  ];

  // BANNERS ALBUM - Path is correct
  static const List<_GraphicAlbum> _banners = [
    _GraphicAlbum(
      title: 'Banner Designs',
      description: 'Promotional banners and business card designs.',
      coverImage: 'assets/images/graphic/banners/abba_selah_banner.jpg',
      aspectRatio: GraphicAspectRatio.landscape,
      imagePaths: [
        'assets/images/graphic/banners/abba_selah_banner.jpg',
        'assets/images/graphic/banners/business_card_design.jpg',
      ],
      isVideo: false,
    ),
  ];

  // LOGOS ALBUM - Path is correct
  static const List<_GraphicAlbum> _logos = [
    _GraphicAlbum(
      title: 'Business Logos',
      description: 'Logo designs for various businesses including Abba Selah, Cao Cao Investment, Caura Hair Care, and AgriSync.',
      coverImage: 'assets/images/graphic/logos/Abba_Selah_Logo.jpg',
      aspectRatio: GraphicAspectRatio.square,
      imagePaths: [
        'assets/images/graphic/logos/Abba_Selah_Logo.jpg',
        'assets/images/graphic/logos/Cao_Cao_Investment_Logo.jpg',
        'assets/images/graphic/logos/Caura_Hair_Care_Logo.jpg',
        'assets/images/graphic/logos/AgriSync_Favicon_Logo.jpg',
        'assets/images/graphic/logos/AgriSync_Primary_Logo.jpg',
        'assets/images/graphic/logos/AgriSync_Secondary_Logo.jpg',
        'assets/images/graphic/logos/AgriSync_Submark_Logo.jpg',
      ],
      isVideo: false,
    ),
    // Video Logo - MP4 format - FIXED filename
    _GraphicAlbum(
      title: 'OuKrag Animated Logo',
      description: 'Motion graphics logo animation for OuKrag in MP4 format.',
      coverImage: 'assets/images/graphic/logos/OuKrag_Logo_Video.jpg', // You'll need a thumbnail image
      aspectRatio: GraphicAspectRatio.landscape,
      imagePaths: [
        'assets/images/graphic/logos/OuKrag_Logo_Video.mp4',
      ],
      isVideo: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);

    AnalyticsService.to.logScreenView('graphic_design');

    return SecondaryScreenShell(
      title: AppStrings.catGraphicDesign,
      overline: 'VISUAL',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SOCIAL MEDIA SECTION
          if (_socialMedia.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: AppSizes.spaceXL),
              child: Text(
                'SOCIAL MEDIA',
                style: AppTextStyle.overline.copyWith(fontSize: 12),
              ),
            ),
            _GraphicAlbumGrid(
              albums: _socialMedia,
              columns: screen.subProjectCardColumns,
            ),
          ],

          const SizedBox(height: AppSizes.space5XL),

          // PRINT MATERIALS SECTION
          if (_printMaterials.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: AppSizes.spaceXL),
              child: Text(
                'PRINT MATERIALS',
                style: AppTextStyle.overline.copyWith(fontSize: 12),
              ),
            ),
            _GraphicAlbumGrid(
              albums: _printMaterials,
              columns: screen.subProjectCardColumns,
            ),
          ],

          const SizedBox(height: AppSizes.space5XL),

          // BANNERS SECTION
          if (_banners.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: AppSizes.spaceXL),
              child: Text(
                'BANNERS',
                style: AppTextStyle.overline.copyWith(fontSize: 12),
              ),
            ),
            _GraphicAlbumGrid(
              albums: _banners,
              columns: screen.subProjectCardColumns,
            ),
          ],

          const SizedBox(height: AppSizes.space5XL),

          // LOGOS SECTION
          if (_logos.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: AppSizes.spaceXL),
              child: Text(
                'LOGOS & BRANDING',
                style: AppTextStyle.overline.copyWith(fontSize: 12),
              ),
            ),
            _GraphicAlbumGrid(
              albums: _logos,
              columns: screen.subProjectCardColumns,
            ),
          ],

          if (_socialMedia.isEmpty && _printMaterials.isEmpty && _banners.isEmpty && _logos.isEmpty)
            const _EmptyGalleryState(),
        ],
      ),
    );
  }
}

// Graphic Album Grid
class _GraphicAlbumGrid extends StatelessWidget {
  final List<_GraphicAlbum> albums;
  final int columns;

  const _GraphicAlbumGrid({
    required this.albums,
    required this.columns,
  });

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
          children: albums.map((album) => SizedBox(
            width: cardWidth,
            child: _GraphicAlbumCard(album: album),
          )).toList(),
        );
      },
    );
  }
}

// Graphic Album Card
class _GraphicAlbumCard extends StatefulWidget {
  final _GraphicAlbum album;

  const _GraphicAlbumCard({required this.album});

  @override
  State<_GraphicAlbumCard> createState() => _GraphicAlbumCardState();
}

class _GraphicAlbumCardState extends State<_GraphicAlbumCard>
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
    return MouseRegion(
      onEnter: (_) {
        setState(() => _hovered = true);
        _ctrl.forward();
        AnalyticsService.to.logUserAction(
          'graphic_album_hover',
          properties: {'album': widget.album.title},
        );
      },
      onExit: (_) {
        setState(() => _hovered = false);
        _ctrl.reverse();
      },
      child: GestureDetector(
        onTap: () {
          AnalyticsService.to.logUserAction(
            'graphic_album_click',
            properties: {'album': widget.album.title},
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => _GraphicAlbumViewScreen(album: widget.album),
            ),
          );
        },
        child: ScaleTransition(
          scale: _scale,
          child: AnimatedContainer(
            duration: AppSizes.durationDefault,
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
                // Cover Image with overlay and aspect ratio
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: _getAspectRatioValue(widget.album.aspectRatio),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(AppSizes.radiusL),
                        ),
                        child: widget.album.isVideo
                            ? _VideoCover(coverImage: widget.album.coverImage)
                            : Image.asset(
                                widget.album.coverImage,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  color: AppColors.lightGrey,
                                  child: Center(
                                    child: Icon(
                                      Icons.broken_image_rounded,
                                      size: 48,
                                      color: AppColors.gold.withOpacity(0.35),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                    
                    // Video badge for video albums
                    if (widget.album.isVideo)
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
                    
                    // Image count badge
                    if (!widget.album.isVideo && widget.album.imagePaths.length > 1)
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
                                '${widget.album.imagePaths.length}',
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
                    
                    // Hover overlay
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
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSizes.spaceL,
                                vertical: AppSizes.spaceS,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.gold,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    widget.album.isVideo
                                        ? Icons.play_circle_rounded
                                        : Icons.photo_library_rounded,
                                    size: 16,
                                    color: AppColors.white,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    widget.album.isVideo
                                        ? 'Play Video'
                                        : '${widget.album.imagePaths.length} images',
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
                        ),
                      ),
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
                        child: Text(widget.album.title),
                      ),
                      const SizedBox(height: AppSizes.spaceS),
                      // Gold rule
                      Container(
                        width: AppSizes.goldRuleWidth,
                        height: 2.5,
                        decoration: BoxDecoration(
                          color: AppColors.gold,
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusXXL),
                        ),
                      ),
                      const SizedBox(height: AppSizes.spaceM),
                      // Description
                      Text(
                        widget.album.description,
                        style: AppTextStyle.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // Video indicator in text
                      if (widget.album.isVideo)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              Icon(
                                Icons.videocam_rounded,
                                size: 14,
                                color: AppColors.gold,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'MP4 Video',
                                style: AppTextStyle.bodySmall.copyWith(
                                  color: AppColors.gold,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
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

  double _getAspectRatioValue(GraphicAspectRatio ratio) {
    switch (ratio) {
      case GraphicAspectRatio.portrait:
        return 3/4;
      case GraphicAspectRatio.landscape:
        return 16/9;
      case GraphicAspectRatio.square:
        return 1;
    }
  }
}

// Video Cover Widget
class _VideoCover extends StatefulWidget {
  final String coverImage;

  const _VideoCover({required this.coverImage});

  @override
  State<_VideoCover> createState() => _VideoCoverState();
}

class _VideoCoverState extends State<_VideoCover> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() {
    _controller = VideoPlayerController.asset(widget.coverImage)
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });
        _controller!.setLooping(true);
        _controller!.setVolume(0);
        _controller!.play();
      });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isInitialized) {
      return VideoPlayer(_controller!);
    } else {
      return Container(
        color: AppColors.lightGrey,
        child: const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.gold,
          ),
        ),
      );
    }
  }
}

// Graphic Album View Screen
class _GraphicAlbumViewScreen extends StatelessWidget {
  final _GraphicAlbum album;

  const _GraphicAlbumViewScreen({required this.album});

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            elevation: 0,
            backgroundColor: AppColors.white,
            surfaceTintColor: Colors.transparent,
            toolbarHeight: AppSizes.navbarHeight,
            leading: _buildBackButton(context),
            leadingWidth: 140,
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'GRAPHIC DESIGN',
                  style: AppTextStyle.overline.copyWith(fontSize: 10),
                ),
                const SizedBox(height: AppSizes.spaceXXS),
                Text(
                  album.title,
                  style: AppTextStyle.cardTitle,
                ),
              ],
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                height: 1,
                color: AppColors.gold.withOpacity(0.25),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(AppSizes.spaceXXL),
            sliver: album.isVideo
                ? _buildVideoSliver()
                : SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: screen.galleryColumns,
                      crossAxisSpacing: AppSizes.cardGridSpacing,
                      mainAxisSpacing: AppSizes.cardGridSpacing,
                      childAspectRatio: _getGridAspectRatio(album.aspectRatio),
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return _GraphicThumbnail(
                          imagePath: album.imagePaths[index],
                          title: '${album.title} - ${_getImageName(album.title, index)}',
                          allImages: album.imagePaths,
                          initialIndex: index,
                          aspectRatio: album.aspectRatio,
                          isVideo: album.isVideo,
                        );
                      },
                      childCount: album.imagePaths.length,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  String _getImageName(String albumTitle, int index) {
    if (albumTitle.contains('Social Media')) {
      const names = [
        'Post 1', 'Post 2', 'Post 3', 'Post 4', 'Post 5', 'Post 6', 'Post 7',
        'Facebook 1', 'Facebook 2', 'Facebook 3', 'Facebook 4'
      ];
      return names[index];
    } else if (albumTitle.contains('Print')) {
      const names = ['Invoice Template', 'Nutrition Menu'];
      return names[index];
    } else if (albumTitle.contains('Banner')) {
      const names = ['Abba Selah Banner', 'Business Card'];
      return names[index];
    } else if (albumTitle.contains('Business Logos')) {
      const names = [
        'Abba Selah', 'Cao Cao Investment', 'Caura Hair Care',
        'AgriSync Favicon', 'AgriSync Primary', 'AgriSync Secondary', 'AgriSync Submark'
      ];
      return names[index];
    } else if (albumTitle.contains('OuKrag')) {
      return 'Animated Logo';
    }
    return 'Image ${index + 1}';
  }

  Widget _buildVideoSliver() {
    return SliverToBoxAdapter(
      child: _VideoPlayerScreen(
        videoPath: album.imagePaths.first,
        title: album.title,
      ),
    );
  }

  double _getGridAspectRatio(GraphicAspectRatio ratio) {
    switch (ratio) {
      case GraphicAspectRatio.portrait:
        return 0.75;
      case GraphicAspectRatio.landscape:
        return 1.78;
      case GraphicAspectRatio.square:
        return 1.0;
    }
  }

  Widget _buildBackButton(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Padding(
          padding: const EdgeInsets.only(left: AppSizes.spaceXXL),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.arrow_back_rounded,
                size: AppSizes.iconM,
                color: AppColors.black,
              ),
              const SizedBox(width: AppSizes.spaceXS),
              Text(
                'Back',
                style: AppTextStyle.navItem.copyWith(
                  fontSize: 13,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Video Player Screen
// Video Player Screen - FIXED with better error handling
class _VideoPlayerScreen extends StatefulWidget {
  final String videoPath;
  final String title;

  const _VideoPlayerScreen({
    required this.videoPath,
    required this.title,
  });

  @override
  State<_VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<_VideoPlayerScreen> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _isPlaying = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() {
    try {
      _controller = VideoPlayerController.asset(widget.videoPath)
        ..initialize().then((_) {
          if (mounted) {
            setState(() {
              _isInitialized = true;
            });
            _controller!.setLooping(true);
            _controller!.play();
          }
        }).catchError((error) {
          if (mounted) {
            setState(() {
              _hasError = true;
            });
            debugPrint('Error initializing video: $error');
          }
        });
    } catch (e) {
      setState(() {
        _hasError = true;
      });
      debugPrint('Exception initializing video: $e');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Container(
        height: 400,
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(AppSizes.radiusL),
          border: Border.all(
            color: AppColors.gold.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.videocam_off_rounded,
                size: 64,
                color: AppColors.gold.withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              Text(
                'Video could not be loaded',
                style: AppTextStyle.bodyLarge.copyWith(
                  color: AppColors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please check file format',
                style: AppTextStyle.bodySmall,
              ),
            ],
          ),
        ),
      );
    }

    if (!_isInitialized) {
      return Container(
        height: 400,
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(AppSizes.radiusL),
          border: Border.all(
            color: AppColors.gold.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.gold,
              ),
              SizedBox(height: 16),
              Text(
                'Loading video...',
                style: TextStyle(
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusL),
        border: Border.all(
          color: AppColors.gold.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppSizes.radiusL),
            ),
            child: AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  VideoPlayer(_controller!),
                  _VideoControls(
                    controller: _controller!,
                    onPlayToggle: () {
                      setState(() {
                        _isPlaying = !_isPlaying;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSizes.cardPadding),
            child: Text(
              widget.title,
              style: AppTextStyle.bodyLarge.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Video Controls
class _VideoControls extends StatelessWidget {
  final VideoPlayerController controller;
  final VoidCallback onPlayToggle;

  const _VideoControls({
    required this.controller,
    required this.onPlayToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(
              controller.value.isPlaying
                  ? Icons.pause_circle_rounded
                  : Icons.play_circle_rounded,
              color: AppColors.gold,
              size: 36,
            ),
            onPressed: () {
              controller.value.isPlaying
                  ? controller.pause()
                  : controller.play();
              onPlayToggle();
            },
          ),
        ],
      ),
    );
  }
}

// Graphic Thumbnail
class _GraphicThumbnail extends StatelessWidget {
  final String imagePath;
  final String title;
  final List<String> allImages;
  final int initialIndex;
  final GraphicAspectRatio aspectRatio;
  final bool isVideo;

  const _GraphicThumbnail({
    required this.imagePath,
    required this.title,
    required this.allImages,
    required this.initialIndex,
    required this.aspectRatio,
    this.isVideo = false,
  });

  void _showLightbox(BuildContext context) {
    if (isVideo) {
      _showVideoPlayer(context);
    } else {
      showDialog(
        context: context,
        barrierColor: Colors.black.withOpacity(0.95),
        builder: (context) => _GraphicLightbox(
          images: allImages,
          initialIndex: initialIndex,
          title: title,
        ),
      );
    }
  }

  void _showVideoPlayer(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.95),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.6,
          child: _VideoPlayerScreen(
            videoPath: imagePath,
            title: title,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showLightbox(context),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          border: Border.all(
            color: AppColors.gold.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          child: AspectRatio(
            aspectRatio: _getThumbnailAspectRatio(aspectRatio),
            child: isVideo
                ? _VideoThumbnail(videoPath: imagePath)
                : Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: AppColors.lightGrey,
                      child: Center(
                        child: Icon(
                          Icons.broken_image_rounded,
                          size: 32,
                          color: AppColors.gold.withOpacity(0.35),
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  double _getThumbnailAspectRatio(GraphicAspectRatio ratio) {
    switch (ratio) {
      case GraphicAspectRatio.portrait:
        return 3/4;
      case GraphicAspectRatio.landscape:
        return 16/9;
      case GraphicAspectRatio.square:
        return 1;
    }
  }
}

// Video Thumbnail
// Video Thumbnail - FIXED with error handling
class _VideoThumbnail extends StatefulWidget {
  final String videoPath;

  const _VideoThumbnail({required this.videoPath});

  @override
  State<_VideoThumbnail> createState() => _VideoThumbnailState();
}

class _VideoThumbnailState extends State<_VideoThumbnail> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() {
    try {
      _controller = VideoPlayerController.asset(widget.videoPath)
        ..initialize().then((_) {
          if (mounted) {
            setState(() {
              _isInitialized = true;
            });
            _controller!.setLooping(true);
            _controller!.setVolume(0);
            _controller!.play();
          }
        }).catchError((error) {
          if (mounted) {
            setState(() {
              _hasError = true;
            });
          }
        });
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Container(
        color: AppColors.lightGrey,
        child: Center(
          child: Icon(
            Icons.videocam_off_rounded,
            size: 32,
            color: AppColors.gold.withOpacity(0.35),
          ),
        ),
      );
    }

    if (_isInitialized) {
      return Stack(
        alignment: Alignment.center,
        children: [
          VideoPlayer(_controller!),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.play_arrow_rounded,
              color: AppColors.gold,
              size: 24,
            ),
          ),
        ],
      );
    } else {
      return Container(
        color: AppColors.lightGrey,
        child: const Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.gold,
            ),
          ),
        ),
      );
    }
  }
}

// Graphic Lightbox (for images only)
class _GraphicLightbox extends StatefulWidget {
  final List<String> images;
  final int initialIndex;
  final String title;

  const _GraphicLightbox({
    required this.images,
    required this.initialIndex,
    required this.title,
  });

  @override
  State<_GraphicLightbox> createState() => _GraphicLightboxState();
}

class _GraphicLightboxState extends State<_GraphicLightbox> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Center(
                child: InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 3.0,
                  child: Hero(
                    tag: '${widget.title}_$index',
                    child: Image.asset(
                      widget.images[index],
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => Center(
                        child: Icon(
                          Icons.broken_image_rounded,
                          size: 64,
                          color: AppColors.gold.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            right: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: AppColors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.close_rounded,
                  color: AppColors.white,
                  size: 28,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.spaceL,
                  vertical: AppSizes.spaceS,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${_currentIndex + 1} / ${widget.images.length}',
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Graphic Aspect Ratio Enum
enum GraphicAspectRatio {
  portrait,  // 4:3 for A4 posters
  landscape, // 16:9 for banners
  square,    // 4:4 for logos
}

// Data Model - Graphic Album - UPDATED WITH isVideo FIELD
class _GraphicAlbum {
  final String title;
  final String description;
  final String coverImage;
  final GraphicAspectRatio aspectRatio;
  final List<String> imagePaths;
  final bool isVideo;  // Flag to identify video albums

  const _GraphicAlbum({
    required this.title,
    required this.description,
    required this.coverImage,
    required this.aspectRatio,
    required this.imagePaths,
    this.isVideo = false,  // Default to false for image albums
  });
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
            'Add image assets to populate the gallery.',
            style: AppTextStyle.bodySmall,
          ),
        ],
      ),
    );
  }
}
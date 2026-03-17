import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:portfolio_web_app/screens/projects/secondary_screen_shell.dart';
import 'package:portfolio_web_app/screens/widgets/images/cached_gallery_image.dart';

import 'package:portfolio_web_app/core/constants/app_strings.dart';
import 'package:portfolio_web_app/core/constants/app_sizes.dart';
import 'package:portfolio_web_app/core/responsive/responsive.dart';
import 'package:portfolio_web_app/core/theme/app_colors.dart';
import 'package:portfolio_web_app/core/theme/app_textstyle.dart';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:portfolio_web_app/screens/projects/secondary_screen_shell.dart';
import 'package:portfolio_web_app/screens/widgets/images/cached_gallery_image.dart';

import 'package:portfolio_web_app/core/constants/app_strings.dart';
import 'package:portfolio_web_app/core/constants/app_sizes.dart';
import 'package:portfolio_web_app/core/responsive/responsive.dart';
import 'package:portfolio_web_app/core/theme/app_colors.dart';
import 'package:portfolio_web_app/core/theme/app_textstyle.dart';

class UIDesignGalleryScreen extends StatelessWidget {
  const UIDesignGalleryScreen({super.key});

  // UI Design Albums - Each album represents a different UI project
  static const List<_UIAlbum> _albums = [
    // Cao Cao Investment UI Album
    _UIAlbum(
      title: 'Cao Cao Investment CC',
      description: 'Complete UI design for Cao Cao Investment corporate website - 8 screens showcasing a clean, professional financial interface.',
      coverImage: 'assets/images/ui/cao_cao_investment/screen_1.jpg',
      imagePaths: [
        'assets/images/ui/cao_cao_investment/screen_1.jpg',
        'assets/images/ui/cao_cao_investment/screen_2.jpg',
        'assets/images/ui/cao_cao_investment/screen_3.jpg',
        'assets/images/ui/cao_cao_investment/screen_4.jpg',
        'assets/images/ui/cao_cao_investment/screen_5.jpg',
        'assets/images/ui/cao_cao_investment/screen_6.jpg',
        'assets/images/ui/cao_cao_investment/screen_7.jpg',
        'assets/images/ui/cao_cao_investment/screen_8.jpg',
      ],
    ),
    
    // Portfolio Website UI Album - FIXED: Changed to .png
    _UIAlbum(
      title: 'Portfolio Website UI',
      description: 'UI design concept for this very portfolio website - featuring hero section, footer, and 4 key screens with gold accents.',
      coverImage: 'assets/images/ui/portfolio_website/hero.png',
      imagePaths: [
        'assets/images/ui/portfolio_website/hero.png',
        'assets/images/ui/portfolio_website/footer.png',
        'assets/images/ui/portfolio_website/screen_1.png',
        'assets/images/ui/portfolio_website/screen_2.png',
        'assets/images/ui/portfolio_website/screen_3.png',
        'assets/images/ui/portfolio_website/screen_4.png',
      ],
    ),
    
    // Prayer Box UI Album - FIXED: Changed to .png
    _UIAlbum(
      title: 'Prayer Box App UI',
      description: 'Complete mobile and desktop UI design for the Prayer Box prayer journaling app - featuring 14 screens with intuitive interface design.',
      coverImage: 'assets/images/ui/prayer_box/primary_ui_design.png',
      imagePaths: [
        'assets/images/ui/prayer_box/answered_desktop.png',
        'assets/images/ui/prayer_box/answered_screen_mobile.png',
        'assets/images/ui/prayer_box/landing_desktop.png',
        'assets/images/ui/prayer_box/landing_mobile.png',
        'assets/images/ui/prayer_box/nav_menu_desktop.png',
        'assets/images/ui/prayer_box/nav_menu_mobile.png',
        'assets/images/ui/prayer_box/prayer_details_desktop.png',
        'assets/images/ui/prayer_box/prayer_request_details_mobile.png',
        'assets/images/ui/prayer_box/primary_ui_design.png',
        'assets/images/ui/prayer_box/primary_ui_design_2.png',
        'assets/images/ui/prayer_box/side_by_side_view.png',
        'assets/images/ui/prayer_box/stats_1_mobile.png',
        'assets/images/ui/prayer_box/stats_2_mobile.png',
        'assets/images/ui/prayer_box/stats_desktop.png',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);

    return SecondaryScreenShell(
      title: AppStrings.catUIDesign,
      overline: 'DESIGN',
      child: _albums.isEmpty
          ? const _EmptyState()
          : _UIAlbumGrid(
              albums: _albums,
              columns: screen.projectCardColumns,
            ),
    );
  }
}

// Album Grid - Shows all UI project albums
class _UIAlbumGrid extends StatelessWidget {
  const _UIAlbumGrid({
    required this.albums,
    required this.columns,
  });

  final List<_UIAlbum> albums;
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
          children: albums.map((album) => SizedBox(
            width: cardWidth,
            child: _UIAlbumCard(album: album),
          )).toList(),
        );
      },
    );
  }
}

// UI Album Card - Card representing a UI project album
class _UIAlbumCard extends StatefulWidget {
  const _UIAlbumCard({required this.album});
  final _UIAlbum album;

  @override
  State<_UIAlbumCard> createState() => _UIAlbumCardState();
}

class _UIAlbumCardState extends State<_UIAlbumCard>
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
      },
      onExit: (_) {
        setState(() => _hovered = false);
        _ctrl.reverse();
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => _UIAlbumViewScreen(album: widget.album),
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
                // Cover Image with overlay
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(AppSizes.radiusL),
                      ),
                      child: Image.asset(
                        widget.album.coverImage,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          height: 180,
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
                                    Icons.photo_library_rounded,
                                    size: 16,
                                    color: AppColors.white,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${widget.album.imagePaths.length} images',
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
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
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
}

// Album View Screen - Shows all images in an album with thumbnail grid
class _UIAlbumViewScreen extends StatelessWidget {
  final _UIAlbum album;

  const _UIAlbumViewScreen({required this.album});

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
                  'UI DESIGN',
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
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: screen.galleryColumns,
                crossAxisSpacing: AppSizes.cardGridSpacing,
                mainAxisSpacing: AppSizes.cardGridSpacing,
                childAspectRatio: 1, // Square thumbnails for UI designs
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _UIThumbnail(
                    imagePath: album.imagePaths[index],
                    title: '${album.title} - ${_getImageName(album.title, index)}',
                    allImages: album.imagePaths,
                    initialIndex: index,
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
    if (albumTitle.contains('Cao Cao')) {
      return 'Screen ${index + 1}';
    } else if (albumTitle.contains('Portfolio')) {
      const names = ['Hero', 'Footer', 'Screen 1', 'Screen 2', 'Screen 3', 'Screen 4'];
      return names[index];
    } else if (albumTitle.contains('Prayer Box')) {
      const names = [
        'Answered (Desktop)', 'Answered (Mobile)', 'Landing (Desktop)', 
        'Landing (Mobile)', 'Nav Menu (Desktop)', 'Nav Menu (Mobile)',
        'Prayer Details (Desktop)', 'Prayer Request (Mobile)', 'Primary Design',
        'Primary Design 2', 'Side by Side View', 'Stats 1 (Mobile)',
        'Stats 2 (Mobile)', 'Stats (Desktop)'
      ];
      return names[index];
    }
    return 'Image ${index + 1}';
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

// UI Thumbnail - Individual image thumbnail in the album grid
class _UIThumbnail extends StatelessWidget {
  final String imagePath;
  final String title;
  final List<String> allImages;
  final int initialIndex;

  const _UIThumbnail({
    required this.imagePath,
    required this.title,
    required this.allImages,
    required this.initialIndex,
  });

  void _showLightbox(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.95),
      builder: (context) => _UILightbox(
        images: allImages,
        initialIndex: initialIndex,
        title: title,
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
          child: Image.asset(
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
    );
  }
}

// UI Lightbox - Full-screen image viewer with swipe navigation
class _UILightbox extends StatefulWidget {
  final List<String> images;
  final int initialIndex;
  final String title;

  const _UILightbox({
    required this.images,
    required this.initialIndex,
    required this.title,
  });

  @override
  State<_UILightbox> createState() => _UILightboxState();
}

class _UILightboxState extends State<_UILightbox> {
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
          // Main image with PageView for swiping
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

          // Close button
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

          // Image counter
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

// Data Model - Now represents an album of images
class _UIAlbum {
  final String title;
  final String description;
  final String coverImage;
  final List<String> imagePaths;

  const _UIAlbum({
    required this.title,
    required this.description,
    required this.coverImage,
    required this.imagePaths,
  });
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
            size: 64,
            color: AppColors.gold.withOpacity(0.35),
          ),
          const SizedBox(height: AppSizes.spaceXXL),
          Text(
            'UI design projects coming soon.',
            style: AppTextStyle.bodyLarge.copyWith(color: AppColors.grey),
          ),
          const SizedBox(height: AppSizes.spaceS),
          Text(
            'Add image assets to the UI albums to populate the gallery.',
            style: AppTextStyle.bodySmall,
          ),
        ],
      ),
    );
  }
}
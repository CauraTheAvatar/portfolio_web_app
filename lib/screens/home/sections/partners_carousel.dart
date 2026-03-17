import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_web_app/core/constants/app_sizes.dart';
import 'package:portfolio_web_app/core/theme/app_colors.dart';
import 'package:portfolio_web_app/core/theme/app_textstyle.dart';

class PartnersCarousel extends StatefulWidget {
  const PartnersCarousel({super.key});

  @override
  State<PartnersCarousel> createState() => _PartnersCarouselState();
}

class _PartnersCarouselState extends State<PartnersCarousel>
    with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final AnimationController _animationController;
  bool _isHovered = false;
  double _scrollPosition = 0.0;

  final List<Map<String, String>> _partners = [
    {
      'name': 'Abba Selah Collectives',
      'logo': 'assets/logos/abba_selah.png', // You'll need to add these logo files
    },
    {
      'name': 'Cao Cao Investment CC',
      'logo': 'assets/logos/cao_cao.png',
    },
    {
      'name': 'Hope Home Base Healthcare',
      'logo': 'assets/logos/hope_home.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50), // Update every 50ms for smooth scroll
    )..addListener(_scrollListener);

    // Start the animation after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScrolling();
    });
  }

  void _scrollListener() {
    if (!_isHovered && _scrollController.hasClients) {
      // Get the max scroll extent (half of total width since we duplicated items)
      final maxScroll = _scrollController.position.maxScrollExtent / 2;
      
      // Increment scroll position
      _scrollPosition += 1.5; // Adjust speed here
      
      // Loop back to start when we reach the middle (where duplicates start)
      if (_scrollPosition >= maxScroll) {
        _scrollPosition = 0;
        _scrollController.jumpTo(0);
      } else {
        _scrollController.animateTo(
          _scrollPosition,
          duration: const Duration(milliseconds: 50),
          curve: Curves.linear,
        );
      }
    }
  }

  void _startScrolling() {
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.space5XL,
        horizontal: AppSizes.spaceXL,
      ),
      child: Column(
        children: [
          // Section header
          Column(
            children: [
              Text(
                'TRUSTED PARTNERS',
                style: AppTextStyle.overline,
              ),
              const SizedBox(height: AppSizes.spaceM),
              Container(
                width: AppSizes.goldRuleWidth,
                height: AppSizes.goldRuleHeight,
                decoration: BoxDecoration(
                  color: AppColors.gold,
                  borderRadius: BorderRadius.circular(AppSizes.radiusXS),
                ),
              ),
              const SizedBox(height: AppSizes.spaceL),
              Text(
                'Companies I\'ve collaborated with',
                style: AppTextStyle.sectionSubtitle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          
          const SizedBox(height: AppSizes.space4XL),

          // Carousel container with gradient fade edges
          MouseRegion(
            onEnter: (_) {
              setState(() {
                _isHovered = true;
              });
            },
            onExit: (_) {
              setState(() {
                _isHovered = false;
              });
            },
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    AppColors.white,
                    AppColors.white.withOpacity(0),
                    AppColors.white.withOpacity(0),
                    AppColors.white,
                  ],
                  stops: const [0.0, 0.1, 0.9, 1.0],
                ),
              ),
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(), // Disable manual scrolling
                itemCount: _partners.length * 3, // Triple the items for seamless loop
                itemBuilder: (context, index) {
                  final partner = _partners[index % _partners.length];
                  return Container(
                    width: 200,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo placeholder - replace with actual Image.asset when you have logos
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.lightGrey,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.gold.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              partner['name']!
                                  .split(' ')
                                  .map((word) => word[0])
                                  .take(2)
                                  .join(''),
                              style: AppTextStyle.navItem.copyWith(
                                fontSize: 24,
                                color: AppColors.gold,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSizes.spaceS),
                        // Company name (optional - remove if you want only logos)
                        Text(
                          partner['name']!,
                          style: AppTextStyle.bodySmall.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
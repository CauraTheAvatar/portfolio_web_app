import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_web_app/core/constants/app_sizes.dart';
import 'package:portfolio_web_app/core/constants/app_strings.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCatCard extends StatefulWidget {

  const ProjectCatCard({
    super.key,
    required this.title,
    required this.description,
    this.imagePath,
    this.links = const [],
    this.route,
    this.onTap,
  });

  // Card content
  final String              title;
  final String              description;
  final String?             imagePath;     // asset path for screenshot
  final List<ProjectLink>   links;         // action buttons (GitHub / Live / etc.)

  // Navigation — if route is set, tapping the card calls Get.toNamed(route).
  // onTap overrides route when both are provided.
  final String?             route;
  final VoidCallback?       onTap;

  @override
  State<ProjectCatCard> createState() => _ProjectCatCardState();
}

class _ProjectCatCardState extends State<ProjectCatCard>
    with SingleTickerProviderStateMixin {

  bool _hovered = false;
  late final AnimationController _controller;
  late final Animation<double>   _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppSizes.durationDefault,
    );
    _scale = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onEnter(_) {
    setState(() => _hovered = true);
    _controller.forward();
  }

  void _onExit(_) {
    setState(() => _hovered = false);
    _controller.reverse();
  }

  void _onTap() {
    if (widget.onTap != null) {
      widget.onTap!();
    } else if (widget.route != null) {
      Get.toNamed(widget.route!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: _onEnter,
      onExit:  _onExit,
      child: ScaleTransition(
        scale: _scale,
        child: GestureDetector(
          onTap: _onTap,
          child: AnimatedContainer(
            duration: AppSizes.durationDefault,
            decoration: BoxDecoration(
              color:        AppColors.white,
              borderRadius: BorderRadius.circular(AppSizes.radiusL),
              border: Border.all(
                color: _hovered
                    ? AppColors.gold
                    : AppColors.gold.withOpacity(0.4),
                width: AppSizes.borderDefault,
              ),
              boxShadow: _hovered
                  ? [
                      // Gold glow
                      BoxShadow(
                        color:      AppColors.gold.withOpacity(0.22),
                        blurRadius: AppSizes.cardShadowBlurHover,
                        offset:     const Offset(0, 8),
                      ),
                      // Neutral depth
                      BoxShadow(
                        color:      Colors.black.withOpacity(0.08),
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

                // Screenshot / preview image
                _CardImage(
                  imagePath: widget.imagePath,
                  hovered:   _hovered,
                ),

                // Text content + links
                Padding(
                  padding: const EdgeInsets.all(AppSizes.cardPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Project title
                      AnimatedDefaultTextStyle(
                        duration: AppSizes.durationDefault,
                        style: AppTextStyle.cardTitle.copyWith(
                          color: _hovered ? AppColors.gold : AppColors.black,
                        ),
                        child: Text(widget.title),
                      ),

                      const SizedBox(height: AppSizes.cardInternalGapS),

                      // Description
                      Text(
                        widget.description,
                        style: AppTextStyle.bodyMedium,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),

                      if (widget.links.isNotEmpty) ...[
                        const SizedBox(height: AppSizes.cardInternalGapL),
                        // Link buttons row
                        _LinkButtons(links: widget.links),
                      ],

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

// Card Image

class _CardImage extends StatelessWidget {

  const _CardImage({
    required this.imagePath,
    required this.hovered,
  });

  final String? imagePath;
  final bool    hovered;

  static const double _imageHeight = 180;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft:  Radius.circular(AppSizes.radiusL),
        topRight: Radius.circular(AppSizes.radiusL),
      ),
      child: AnimatedContainer(
        duration: AppSizes.durationDefault,
        height: _imageHeight,
        width:  double.infinity,
        child: imagePath != null
            ? Image.asset(
                imagePath!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _ImagePlaceholder(hovered: hovered),
              )
            : _ImagePlaceholder(hovered: hovered),
      ),
    );
  }
}

// Image Placeholder — shown when no screenshot asset is provided

class _ImagePlaceholder extends StatelessWidget {

  const _ImagePlaceholder({required this.hovered});
  final bool hovered;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppSizes.durationDefault,
      color: hovered
          ? AppColors.gold.withOpacity(0.08)
          : AppColors.lightGrey,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.image_rounded,
              size:  36,
              color: AppColors.gold.withOpacity(0.4),
            ),
            const SizedBox(height: AppSizes.spaceXS),
            Text(
              'Screenshot',
              style: AppTextStyle.bodySmall.copyWith(
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Link Buttons

class _LinkButtons extends StatelessWidget {

  const _LinkButtons({required this.links});
  final List<ProjectLink> links;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing:    AppSizes.spaceS,
      runSpacing: AppSizes.spaceS,
      children: links.map((link) => _LinkChip(link: link)).toList(),
    );
  }
}

// Link Chip — individual action button inside the card

class _LinkChip extends StatefulWidget {

  const _LinkChip({required this.link});
  final ProjectLink link;

  @override
  State<_LinkChip> createState() => _LinkChipState();
}

class _LinkChipState extends State<_LinkChip> {

  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.link.onTap,
        child: AnimatedContainer(
          duration: AppSizes.durationDefault,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spaceXXL,
            vertical:   AppSizes.spaceXS,
          ),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.gold : Colors.transparent,
            border: Border.all(
              color: _hovered ? AppColors.gold : AppColors.black,
              width: AppSizes.borderThin,
            ),
            borderRadius: BorderRadius.circular(AppSizes.radiusS),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [

              if (widget.link.icon != null) ...[
                Icon(
                  widget.link.icon,
                  size:  AppSizes.iconXS,
                  color: _hovered ? AppColors.white : AppColors.black,
                ),
                const SizedBox(width: AppSizes.spaceXXS),
              ],

              AnimatedDefaultTextStyle(
                duration: AppSizes.durationDefault,
                style: AppTextStyle.buttonSecondary.copyWith(
                  fontSize:   12,
                  color: _hovered ? AppColors.white : AppColors.black,
                  letterSpacing: 0.6,
                ),
                child: Text(widget.link.label),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class ProjectLink {

  const ProjectLink({
    required this.label,
    required this.onTap,
    this.icon,
  });

  final String        label;
  final VoidCallback  onTap;
  final IconData?     icon;

  // Convenience constructors for the most common link types

  factory ProjectLink.github(String url) => ProjectLink(
        label: AppStrings.ctaViewGithub,
        icon:  Icons.code_rounded,
        onTap: () => _launch(url),
      );

  factory ProjectLink.live(String url) => ProjectLink(
        label: AppStrings.ctaViewLive,
        icon:  Icons.open_in_new_rounded,
        onTap: () => _launch(url),
      );

  factory ProjectLink.figma(String url) => ProjectLink(
        label: AppStrings.ctaViewFigma,
        icon:  Icons.design_services_rounded,
        onTap: () => _launch(url),
      );

  factory ProjectLink.tableau(String url) => ProjectLink(
        label: AppStrings.ctaViewTableau,
        icon:  Icons.bar_chart_rounded,
        onTap: () => _launch(url),
      );

  factory ProjectLink.canva(String url) => ProjectLink(
        label: AppStrings.ctaViewCanva,
        icon:  Icons.brush_rounded,
        onTap: () => _launch(url),
      );

  factory ProjectLink.downloadDocs(String url) => ProjectLink(
        label: AppStrings.ctaDownloadDoc,
        icon:  Icons.download_rounded,
        onTap: () => _launch(url),
      );

  static Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('[ProjectLink] Could not launch: $url');
    }
  }
}
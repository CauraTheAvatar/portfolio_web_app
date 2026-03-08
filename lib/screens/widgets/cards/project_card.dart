import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:portfolio_web_app/core/constants/app_sizes.dart';
import 'package:portfolio_web_app/core/constants/app_strings.dart';
import 'package:portfolio_web_app/core/theme/app_colors.dart';
import 'package:portfolio_web_app/core/theme/app_textstyle.dart';
import 'package:portfolio_web_app/screens/projects/secondary_screen_shell.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    this.imageUrl,
    this.links = const [],
  });

  final String title;
  final String description;
  final String? imageUrl;
  final List<ProjectLink> links;  // Use public ProjectLink class

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: AppSizes.durationDefault);
    _scale = Tween<double>(begin: 1.0, end: 1.05)
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
      cursor: SystemMouseCursors.basic,
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
                      color: Colors.black.withOpacity(0.08),
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
              _ScreenshotArea(imageUrl: widget.imageUrl, hovered: _hovered),
              Padding(
                padding: const EdgeInsets.all(AppSizes.cardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedDefaultTextStyle(
                      duration: AppSizes.durationDefault,
                      style: AppTextStyle.cardTitle.copyWith(
                        color: _hovered ? AppColors.gold : AppColors.black,
                      ),
                      child: Text(widget.title),
                    ),
                    const SizedBox(height: AppSizes.cardInternalGapS),
                    Text(
                      widget.description,
                      style: AppTextStyle.bodyMedium,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (widget.links.isNotEmpty) ...[
                      const SizedBox(height: AppSizes.cardInternalGapL),
                      Wrap(
                        spacing: AppSizes.spaceS,
                        runSpacing: AppSizes.spaceS,
                        children: widget.links
                            .map((l) => _LinkChip(link: l))
                            .toList(),
                      ),
                    ],
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

// Screenshot Area
class _ScreenshotArea extends StatelessWidget {
  const _ScreenshotArea({required this.imageUrl, required this.hovered});
  final String? imageUrl;
  final bool hovered;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          const BorderRadius.vertical(top: Radius.circular(AppSizes.radiusL)),
      child: AnimatedContainer(
        duration: AppSizes.durationDefault,
        height: 180,
        width: double.infinity,
        color: hovered
            ? AppColors.gold.withOpacity(0.08)
            : AppColors.lightGrey,
        child: imageUrl != null
            ? CachedNetworkImage(
                imageUrl: imageUrl!,
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 400),
                fadeInCurve: Curves.easeIn,
                placeholder: (_, __) => const Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.gold,
                    ),
                  ),
                ),
                errorWidget: (_, __, ___) => _placeholder(),
              )
            : _placeholder(),
      ),
    );
  }

  Widget _placeholder() => Center(
        child: Icon(
          Icons.image_rounded,
          size: 36,
          color: AppColors.gold.withOpacity(0.35),
        ),
      );
}

// Link Chip
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
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.link.launch,
        child: AnimatedContainer(
          duration: AppSizes.durationDefault,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spaceXXL,
            vertical: AppSizes.spaceXS,
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
                  size: AppSizes.iconXS,
                  color: _hovered ? AppColors.white : AppColors.black,
                ),
                const SizedBox(width: AppSizes.spaceXXS),
              ],
              AnimatedDefaultTextStyle(
                duration: AppSizes.durationDefault,
                style: AppTextStyle.buttonSecondary.copyWith(
                  fontSize: 12,
                  color: _hovered ? AppColors.white : AppColors.black,
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
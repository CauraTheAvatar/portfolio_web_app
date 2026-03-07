import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:portfolio_web_app/core/constants/app_sizes.dart';
import 'package:portfolio_web_app/core/constants/app_strings.dart';
import 'package:portfolio_web_app/core/responsive/responsive.dart';




// SecondaryScreenShell
class SecondaryScreenShell extends StatelessWidget {
  const SecondaryScreenShell({
    super.key,
    required this.title,
    required this.overline,
    required this.child,
    this.backgroundColor,
  });

  final String title;
  final String overline;
  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.lightGrey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned:           true,
            elevation:        0,
            backgroundColor:  AppColors.white,
            surfaceTintColor: Colors.transparent,
            toolbarHeight:    AppSizes.navbarHeight,
            leading:          const _BackButton(),
            leadingWidth:     140,
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(overline,
                    style: AppTextStyle.overline.copyWith(fontSize: 10)),
                const SizedBox(height: AppSizes.spaceXXS),
                Text(title, style: AppTextStyle.cardTitle),
              ],
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                height: 1,
                color:  AppColors.gold.withOpacity(0.25),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: screen.horizontalPadding,
              vertical:   AppSizes.space8XL,
            ),
            sliver: SliverToBoxAdapter(child: child),
          ),
        ],
      ),
    );
  }
}

// Back Button
class _BackButton extends StatefulWidget {
  const _BackButton();
  @override State<_BackButton> createState() => _BackButtonState();
}

class _BackButtonState extends State<_BackButton> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => Get.back(),
        child: Padding(
          padding: const EdgeInsets.only(left: AppSizes.spaceXXL),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.arrow_back_rounded,
                  size:  AppSizes.iconM,
                  color: _hovered ? AppColors.gold : AppColors.black),
              const SizedBox(width: AppSizes.spaceXS),
              AnimatedDefaultTextStyle(
                duration: AppSizes.durationDefault,
                style: AppTextStyle.navItem.copyWith(
                  fontSize: 13,
                  color: _hovered ? AppColors.gold : AppColors.black,
                ),
                child: Text(AppStrings.back),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// ProjectGrid
class ProjectGrid extends StatelessWidget {
  const ProjectGrid({
    super.key,
    required this.cards,
    required this.columns,
  });

  final List<Widget> cards;
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
          children: cards
              .map((c) => SizedBox(width: cardWidth, child: c))
              .toList(),
        );
      },
    );
  }
}

// SubCategoryCard
class SubCategoryCard extends StatefulWidget {
  const SubCategoryCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  final String       title;
  final String       description;
  final IconData     icon;
  final VoidCallback onTap;

  @override
  State<SubCategoryCard> createState() => _SubCategoryCardState();
}

class _SubCategoryCardState extends State<SubCategoryCard>
    with SingleTickerProviderStateMixin {

  bool _hovered = false;
  late final AnimationController _ctrl;
  late final Animation<double>   _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: AppSizes.durationDefault);
    _scale = Tween<double>(begin: 1.0, end: 1.03)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
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
                    ? AppColors.gold : AppColors.gold.withOpacity(0.35),
                width: AppSizes.borderDefault,
              ),
              boxShadow: _hovered ? [
                BoxShadow(color: AppColors.gold.withOpacity(0.22),
                    blurRadius: AppSizes.cardShadowBlurHover,
                    offset: const Offset(0, 8)),
                BoxShadow(color: Colors.black.withOpacity(0.07),
                    blurRadius: AppSizes.cardShadowBlurDepth,
                    offset: const Offset(0, 4)),
              ] : [
                BoxShadow(color: Colors.black.withOpacity(0.05),
                    blurRadius: AppSizes.cardShadowBlurRest,
                    offset: const Offset(0, 2)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  child: Icon(widget.icon,
                      size:  AppSizes.cardIconSize,
                      color: _hovered ? AppColors.gold : AppColors.grey),
                ),
                const SizedBox(height: AppSizes.cardInternalGapL),
                AnimatedDefaultTextStyle(
                  duration: AppSizes.durationDefault,
                  style: AppTextStyle.cardTitle.copyWith(
                      color: _hovered ? AppColors.gold : AppColors.black),
                  child: Text(widget.title),
                ),
                const SizedBox(height: AppSizes.cardInternalGapS),
                Text(widget.description, style: AppTextStyle.bodyMedium),
                const SizedBox(height: AppSizes.cardInternalGapL),
                AnimatedSlide(
                  offset:   _hovered ? const Offset(0.15, 0) : Offset.zero,
                  duration: AppSizes.durationDefault,
                  curve:    Curves.easeOut,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Explore',
                          style: AppTextStyle.overline.copyWith(fontSize: 10)),
                      const SizedBox(width: AppSizes.cardArrowGap),
                      Icon(Icons.arrow_forward_rounded,
                          size:  AppSizes.cardArrowIconSize,
                          color: AppColors.gold),
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

// ProjectCard
class ProjectCard extends StatefulWidget {
  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    this.imageUrl,
    this.links = const [],
  });

  final String            title;
  final String            description;
  final String?           imageUrl;   // Firebase Storage download URL
  final List<_ProjectLink> links;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {

  bool _hovered = false;
  late final AnimationController _ctrl;
  late final Animation<double>   _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: AppSizes.durationDefault);
    _scale = Tween<double>(begin: 1.0, end: 1.05)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.basic,
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
                  ? AppColors.gold : AppColors.gold.withOpacity(0.35),
              width: AppSizes.borderDefault,
            ),
            boxShadow: _hovered ? [
              BoxShadow(color: AppColors.gold.withOpacity(0.22),
                  blurRadius: AppSizes.cardShadowBlurHover,
                  offset: const Offset(0, 8)),
              BoxShadow(color: Colors.black.withOpacity(0.08),
                  blurRadius: AppSizes.cardShadowBlurDepth,
                  offset: const Offset(0, 4)),
            ] : [
              BoxShadow(color: Colors.black.withOpacity(0.05),
                  blurRadius: AppSizes.cardShadowBlurRest,
                  offset: const Offset(0, 2)),
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
                          color: _hovered ? AppColors.gold : AppColors.black),
                      child: Text(widget.title),
                    ),
                    const SizedBox(height: AppSizes.cardInternalGapS),
                    Text(widget.description,
                        style:    AppTextStyle.bodyMedium,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis),
                    if (widget.links.isNotEmpty) ...[
                      const SizedBox(height: AppSizes.cardInternalGapL),
                      Wrap(
                        spacing:    AppSizes.spaceS,
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
  final bool    hovered;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppSizes.radiusL)),
      child: AnimatedContainer(
        duration: AppSizes.durationDefault,
        height: 180,
        width:  double.infinity,
        color: hovered
            ? AppColors.gold.withOpacity(0.08) : AppColors.lightGrey,
        child: imageUrl != null
            ? CachedNetworkImage(
                imageUrl:       imageUrl!,
                fit:            BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 400),
                fadeInCurve:    Curves.easeIn,
                placeholder: (_, __) => const Center(
                  child: SizedBox(
                    width: 24, height: 24,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: AppColors.gold),
                  ),
                ),
                errorWidget: (_, __, ___) => _placeholder(),
              )
            : _placeholder(),
      ),
    );
  }

  Widget _placeholder() => Center(
    child: Icon(Icons.image_rounded, size: 36,
        color: AppColors.gold.withOpacity(0.35)),
  );
}

// Project Link 
class _ProjectLink {
  const _ProjectLink({required this.label, required this.url, this.icon});
  final String    label;
  final String    url;
  final IconData? icon;

  factory _ProjectLink.github(String url) => _ProjectLink(
      label: AppStrings.ctaViewGithub, icon: Icons.code_rounded, url: url);
  factory _ProjectLink.live(String url) => _ProjectLink(
      label: AppStrings.ctaViewLive, icon: Icons.open_in_new_rounded, url: url);
  factory _ProjectLink.figma(String url) => _ProjectLink(
      label: AppStrings.ctaViewFigma, icon: Icons.design_services_rounded, url: url);
  factory _ProjectLink.tableau(String url) => _ProjectLink(
      label: AppStrings.ctaViewTableau, icon: Icons.bar_chart_rounded, url: url);
  factory _ProjectLink.canva(String url) => _ProjectLink(
      label: AppStrings.ctaViewCanva, icon: Icons.brush_rounded, url: url);
  factory _ProjectLink.download(String url) => _ProjectLink(
      label: AppStrings.ctaDownloadDoc, icon: Icons.download_rounded, url: url);

  void launch() => debugPrint('[Link] $url');
  // Replace with: launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
}

// Link Chip 
class _LinkChip extends StatefulWidget {
  const _LinkChip({required this.link});
  final _ProjectLink link;
  @override State<_LinkChip> createState() => _LinkChipState();
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
        onTap: widget.link.launch,
        child: AnimatedContainer(
          duration: AppSizes.durationDefault,
          padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.spaceXXL, vertical: AppSizes.spaceXS),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.gold : Colors.transparent,
            border: Border.all(
                color: _hovered ? AppColors.gold : AppColors.black,
                width: AppSizes.borderThin),
            borderRadius: BorderRadius.circular(AppSizes.radiusS),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.link.icon != null) ...[
                Icon(widget.link.icon,
                    size:  AppSizes.iconXS,
                    color: _hovered ? AppColors.white : AppColors.black),
                const SizedBox(width: AppSizes.spaceXXS),
              ],
              AnimatedDefaultTextStyle(
                duration: AppSizes.durationDefault,
                style: AppTextStyle.buttonSecondary.copyWith(
                    fontSize: 12,
                    color: _hovered ? AppColors.white : AppColors.black),
                child: Text(widget.link.label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
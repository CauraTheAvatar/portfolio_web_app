import 'package:flutter/material.dart';
import 'package:portfolio_web_app/core/responsive/breakpoints.dart';

enum ScreenType { mobileSmall, mobile, mobileLarge, tablet, tabletLarge, desktop, desktopLarge, desktopXL }

class ScreenInfo {
  const ScreenInfo({
    required this.width,
    required this.height,
    required this.screenType,
  });

  final double width;
  final double height;
  final ScreenType screenType;

  // Boolean helpers 
  bool get isMobileSmall  => screenType == ScreenType.mobileSmall;
  bool get isMobile       => screenType == ScreenType.mobile || isMobileSmall;
  bool get isMobileLarge  => screenType == ScreenType.mobileLarge;
  bool get isTablet       => screenType == ScreenType.tablet;
  bool get isTabletLarge  => screenType == ScreenType.tabletLarge;
  bool get isDesktop      => screenType == ScreenType.desktop || isDesktopLarge || isDesktopXL;
  bool get isDesktopLarge => screenType == ScreenType.desktopLarge;
  bool get isDesktopXL    => screenType == ScreenType.desktopXL;

  // True for anything tablet-sized or smaller.
  bool get isMobileOrTablet => width < AppBreakpoints.tabletLarge;

  // True for anything tablet-large and above.
  bool get isTabletOrDesktop => width >= AppBreakpoints.tablet;

  // True when navbar should collapse to a hamburger menu.
  bool get showMobileNav => width < AppBreakpoints.navbarCollapseAt;

  // Layout values 

  // Horizontal section padding responsive to screen size.
  double get horizontalPadding {
    if (width < AppBreakpoints.tablet)      return AppBreakpoints.paddingMobile;
    if (width < AppBreakpoints.desktop)     return AppBreakpoints.paddingTablet;
    return AppBreakpoints.paddingDesktop;
  }

  // Constrained content width — never exceeds [AppBreakpoints.maxContentWidth].
  double get contentWidth =>
      (width - horizontalPadding * 2).clamp(0, AppBreakpoints.maxContentWidth);

  // Section min height responsive to screen size.
  double get sectionMinHeight => isMobileOrTablet
      ? AppBreakpoints.sectionMinHeightMobile
      : AppBreakpoints.sectionMinHeightDesktop;

  // Grid helpers 

  // Number of columns for the project cards grid.
  int get projectCardColumns {
    if (width < AppBreakpoints.tablet)      return AppBreakpoints.projectCardsMobile;
    if (width < AppBreakpoints.desktop)     return AppBreakpoints.projectCardsTablet;
    return AppBreakpoints.projectCardsDesktop;
  }

  // Number of columns for sub-project cards (category screens).
  int get subProjectCardColumns {
    if (width < AppBreakpoints.tablet)      return AppBreakpoints.subProjectCardsMobile;
    if (width < AppBreakpoints.desktop)     return AppBreakpoints.subProjectCardsTablet;
    return AppBreakpoints.subProjectCardsDesktop;
  }

  // Number of columns for the skills chip grid.
  int get skillChipColumns {
    if (width < AppBreakpoints.tablet)      return AppBreakpoints.skillChipsMobile;
    if (width < AppBreakpoints.desktop)     return AppBreakpoints.skillChipsTablet;
    return AppBreakpoints.skillChipsDesktop;
  }

  // Number of columns for image galleries (UI design, graphic design).
  int get galleryColumns {
    if (width < AppBreakpoints.tablet)      return AppBreakpoints.galleryMobile;
    if (width < AppBreakpoints.desktop)     return AppBreakpoints.galleryTablet;
    return AppBreakpoints.galleryDesktop;
  }

  // Typography scale 

  // Multiplier applied to base font sizes for the current screen.
  double get fontScale {
    if (width < AppBreakpoints.tablet)      return AppBreakpoints.fontScaleMobile;
    if (width < AppBreakpoints.desktop)     return AppBreakpoints.fontScaleTablet;
    return AppBreakpoints.fontScaleDesktop;
  }

  @override
  String toString() =>
      'ScreenInfo(width: $width, height: $height, type: $screenType)';
}

//
// Responsive
// Static utility class — resolves ScreenInfo and exposes layout builders.
//

class Responsive {
  Responsive._();

  // ScreenInfo factory 

  // Returns a [ScreenInfo] snapshot for the given [BuildContext].
  static ScreenInfo of(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return ScreenInfo(
      width: size.width,
      height: size.height,
      screenType: _resolve(size.width),
    );
  }

  static ScreenType _resolve(double width) {
    if (width < AppBreakpoints.mobileSmall)  return ScreenType.mobileSmall;
    if (width < AppBreakpoints.mobile)       return ScreenType.mobile;
    if (width < AppBreakpoints.mobileLarge)  return ScreenType.mobileLarge;
    if (width < AppBreakpoints.tablet)       return ScreenType.tablet;
    if (width < AppBreakpoints.tabletLarge)  return ScreenType.tabletLarge;
    if (width < AppBreakpoints.desktop)      return ScreenType.desktop;
    if (width < AppBreakpoints.desktopLarge) return ScreenType.desktopLarge;
    return ScreenType.desktopXL;
  }

  // Value helpers
  static T value<T>({
    required BuildContext context,
    required T mobile,
    required T tablet,
    required T desktop,
  }) {
    final screen = of(context);
    if (screen.isMobileOrTablet && !screen.isTablet) return mobile;
    if (screen.isTablet || screen.isTabletLarge)     return tablet;
    return desktop;
  }

  // Shorthand for horizontal section padding at the current breakpoint.
  static double horizontalPadding(BuildContext context) =>
      of(context).horizontalPadding;

  // Shorthand for the constrained content width at the current breakpoint.
  static double contentWidth(BuildContext context) =>
      of(context).contentWidth;

static Widget builder({
    required BuildContext context,
    required WidgetBuilder mobile,
    WidgetBuilder? tablet,
    required WidgetBuilder desktop,
  }) {
    final screen = of(context);
    if (screen.isDesktop)   return desktop(context);
    if (screen.isTablet || screen.isTabletLarge) {
      return (tablet ?? desktop)(context);
    }
    return mobile(context);
  }
}

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({super.key, required this.builder});

  final Widget Function(BuildContext context, ScreenInfo screen) builder;

  @override
  Widget build(BuildContext context) {
    return builder(context, Responsive.of(context));
  }
}

class SectionWrapper extends StatelessWidget {
  const SectionWrapper({
    super.key,
    required this.child,
    this.color,
    this.minHeight,
    this.verticalPadding = 80,
  });

  final Widget child;
  final Color? color;
  final double? minHeight;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);

    return Container(
      width: double.infinity,
      color: color,
      constraints: BoxConstraints(
        minHeight: minHeight ?? screen.sectionMinHeight,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppBreakpoints.maxContentWidth,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screen.horizontalPadding,
              vertical: verticalPadding,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
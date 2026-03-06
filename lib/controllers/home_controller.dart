import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_web_app/core/constants/app_sizes.dart';

class HomeController extends GetxController {

  // Section Keys
  final heroKey     = GlobalKey();
  final projectsKey = GlobalKey();
  final skillsKey   = GlobalKey();
  final aboutKey    = GlobalKey();
  final contactKey  = GlobalKey();

  // Active Section (reactive) — drives navbar highlight via Obx
  var activeSection = 'hero'.obs;

  // Scroll Controller
  final scrollController = ScrollController();

  // Visibility threshold — section must cover at least 30% of viewport
  // before it is considered "active". Prevents rapid flickering at boundaries.
  static const double _visibilityThreshold = 0.30;

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  // Update Active Section — called by VisibilityDetector in HomeScreen.
  // Only updates when the incoming section crosses the visibility threshold,
  // preventing partial-overlap sections from stealing the active state.
  void updateSection(String section, double visibleFraction) {
    if (visibleFraction >= _visibilityThreshold &&
        activeSection.value != section) {
      activeSection.value = section;
    }
  }

  // Scroll To — animates via ScrollController with navbar offset correction.
  // Use for navbar taps and any programmatic scroll needing precise placement.
  void scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;

    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null) return;

    // Absolute Y position of the section relative to the scroll origin
    final sectionTop =
        box.localToGlobal(Offset.zero).dy + scrollController.offset;

    // Subtract navbar height so the heading isn't hidden beneath it
    const navbarHeight = AppSizes.navbarHeight;
    final targetOffset = (sectionTop - navbarHeight).clamp(
      0.0,
      scrollController.position.maxScrollExtent,
    );

    scrollController.animateTo(
      targetOffset,
      duration: AppSizes.durationScroll,
      curve: Curves.easeInOut,
    );
  }

  // Scroll To Section — delegates to Scrollable.ensureVisible().
  // Use for back-navigation from sub-screens or deep-link anchor resolution.
  void scrollToSection(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;

    Scrollable.ensureVisible(
      ctx,
      duration: AppSizes.durationScroll,
      curve: Curves.easeInOut,
      alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
    );
  }

}
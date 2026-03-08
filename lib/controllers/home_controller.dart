import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_web_app/core/constants/app_sizes.dart';

class HomeController extends GetxController {

  // Section Keys
  final heroKey     = GlobalKey();
  final projectsKey = GlobalKey();
  final skillsKey   = GlobalKey();
  final experienceKey = GlobalKey(); 
  final aboutKey    = GlobalKey();
  final contactKey  = GlobalKey();

  // Active Section (reactive) 
  var activeSection = 'hero'.obs;

  // Scroll Controller
  final scrollController = ScrollController();

  // Visibility threshold 
  static const double _visibilityThreshold = 0.30;

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  // Update Active Section
  void updateSection(String section, double visibleFraction) {
    if (visibleFraction >= _visibilityThreshold &&
        activeSection.value != section) {
      activeSection.value = section;
    }
  }

  // Scroll To 
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

  // Scroll To Section
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
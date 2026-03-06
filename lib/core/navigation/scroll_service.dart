import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_web_app/controllers/home_controller.dart';
import 'package:portfolio_web_app/core/navigation/route_names.dart';

class ScrollService extends GetxService {

  // Convenience accessor 
  static ScrollService get to => Get.find<ScrollService>();

  // Internal reference to HomeController 
  HomeController get _home => Get.find<HomeController>();

  // Section key map 
  // Maps the activeSection string → its corresponding GlobalKey.
  // Kept in sync with HomeController and RouteNames.
  Map<String, GlobalKey> get _keyMap => {
    'hero':     _home.heroKey,
    'projects': _home.projectsKey,
    'skills':   _home.skillsKey,
    'about':    _home.aboutKey,
    'contact':  _home.contactKey,
  };

  // Public API 

  // Scroll to a section by its string key (e.g. 'projects').
  void scrollToSection(String section) {
    final key = _keyMap[section];
    if (key == null) {
      debugPrint('[ScrollService] Unknown section: "$section"');
      return;
    }
    _scrollToKey(key);
  }

  // Scroll to a section using a [RouteNames] route string.
  void scrollToRoute(String route) {
    final section = RouteNames.routeToSection[route];
    if (section == null) {
      debugPrint('[ScrollService] No section mapped for route: "$route"');
      return;
    }
    scrollToSection(section);
  }

  // Scroll to a section using its [GlobalKey] directly.
  void scrollToKey(GlobalKey key) => _scrollToKey(key);

  // Scroll back to the very top of the page.
  void scrollToTop() {
    final controller = _home.scrollController;
    if (!controller.hasClients) return;
    controller.animateTo(
      0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  // Scroll to the bottom of the page (e.g. Contact section CTA).
  void scrollToBottom() {
    final controller = _home.scrollController;
    if (!controller.hasClients) return;
    controller.animateTo(
      controller.position.maxScrollExtent,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  // Returns true if the scroll position is past the hero section 
  bool get isPastHero {
    final controller = _home.scrollController;
    if (!controller.hasClients) return false;
    return controller.offset > 400;
  }

  // Private 
  void _scrollToKey(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) {
      debugPrint('[ScrollService] Context not mounted for key: $key');
      return;
    }

    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null) return;

    const navbarHeight = 70.0;
    final scrollController = _home.scrollController;

    if (!scrollController.hasClients) return;

    final sectionTop =
        box.localToGlobal(Offset.zero).dy + scrollController.offset;

    final target = (sectionTop - navbarHeight).clamp(
      0.0,
      scrollController.position.maxScrollExtent,
    );

    scrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }
}
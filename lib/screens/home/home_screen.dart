import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'package:portfolio_web_app/screens/home/sections/about_section.dart';
import 'package:portfolio_web_app/screens/home/sections/hero_section.dart';
import 'package:portfolio_web_app/screens/home/sections/projects_section.dart';
import 'package:portfolio_web_app/screens/home/sections/skills_section.dart';
import 'package:portfolio_web_app/screens/home/sections/contact_section.dart';
import 'package:portfolio_web_app/screens/home/sections/footer.dart';
import 'package:portfolio_web_app/screens/home/sections/experience_section.dart'; 

import 'package:portfolio_web_app/screens/widgets/navigation/navbar.dart';
import 'package:portfolio_web_app/core/animations/fade_in.dart';
import 'package:portfolio_web_app/core/theme/app_colors.dart'; 
import 'package:portfolio_web_app/controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      appBar: const Navbar(),
      body: Stack(
        children: [
          // Main scroll content 
          SingleChildScrollView(
            controller: controller.scrollController,
            child: Column(
              children: [
                _SectionDetector(
                  sectionName: 'hero',
                  controller: controller,
                  child: RepaintBoundary(
                    child: FadeInSection(
                      child: HeroSection(key: controller.heroKey),
                    ),
                  ),
                ),

                _SectionDetector(
                  sectionName: 'projects',
                  controller: controller,
                  child: RepaintBoundary(
                    child: FadeInSection(
                      delay: const Duration(milliseconds: 60),
                      child: ProjectsSection(key: controller.projectsKey),
                    ),
                  ),
                ),

                _SectionDetector(
                  sectionName: 'skills',
                  controller: controller,
                  child: RepaintBoundary(
                    child: FadeInSection(
                      delay: const Duration(milliseconds: 60),
                      child: SkillsSection(key: controller.skillsKey),
                    ),
                  ),
                ),

                _SectionDetector(
                  sectionName: 'experience',
                  controller: controller,
                  child: RepaintBoundary(
                    child: FadeInSection(
                      delay: const Duration(milliseconds: 60),
                      child: ExperienceSection(key: controller.experienceKey), // You'll need to add this key to HomeController
                    ),
                  ),
                ),

                _SectionDetector(
                  sectionName: 'about',
                  controller: controller,
                  child: RepaintBoundary(
                    child: FadeInSection(
                      delay: const Duration(milliseconds: 60),
                      child: AboutSection(key: controller.aboutKey),
                    ),
                  ),
                ),

                _SectionDetector(
                  sectionName: 'contact',
                  controller: controller,
                  child: RepaintBoundary(
                    child: FadeInSection(
                      delay: const Duration(milliseconds: 60),
                      child: ContactSection(key: controller.contactKey),
                    ),
                  ),
                ),

                // Footer 
                const FooterSection(),
              ],
            ),
          ),

          // Scroll Progress Bar 
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: RepaintBoundary(
              child: _ScrollProgressBar(),
            ),
          ),
        ],
      ),
    );
  }
}

// Scroll Progress Bar 
class _ScrollProgressBar extends StatefulWidget {
  const _ScrollProgressBar();
  
  @override
  State<_ScrollProgressBar> createState() => _ScrollProgressBarState();
}

class _ScrollProgressBarState extends State<_ScrollProgressBar> {
  double _progress = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _attachListener();
  }

  void _attachListener() {
    final controller = Get.find<HomeController>();
    controller.scrollController.addListener(() {
      if (!mounted) return;
      final sc = controller.scrollController;
      if (!sc.hasClients) return;
      final max = sc.position.maxScrollExtent;
      if (max <= 0) return;
      setState(() => _progress = (sc.offset / max).clamp(0.0, 1.0));
    });
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: _progress,
      minHeight: 3,
      backgroundColor: Colors.transparent,
      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.gold), 
    );
  }
}

// Section Detector 
class _SectionDetector extends StatelessWidget {
  const _SectionDetector({
    required this.sectionName,
    required this.controller,
    required this.child,
  });

  final String sectionName;
  final HomeController controller;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('section_$sectionName'),
      onVisibilityChanged: (info) =>
          controller.updateSection(sectionName, info.visibleFraction),
      child: child,
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'package:portfolio_web_app/controllers/home_controller.dart';
import 'package:portfolio_web_app/screens/widgets/navigation/navbar.dart';

import 'package:portfolio_web_app/screens/home/sections/about_section.dart';
import 'package:portfolio_web_app/screens/home/sections/hero_section.dart';
import 'package:portfolio_web_app/screens/home/sections/projects_section.dart';
import 'package:portfolio_web_app/screens/home/sections/skills_section.dart';
import 'package:portfolio_web_app/screens/home/sections/contact_section.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(

      // Navbar — sticky by virtue of being Scaffold.appBar
      appBar: const Navbar(),

      body: SingleChildScrollView(
        controller: controller.scrollController,
        child: Column(
          children: [

            _SectionDetector(
              sectionName: 'hero',
              controller: controller,
              child: HeroSection(key: controller.heroKey),
            ),

            _SectionDetector(
              sectionName: 'projects',
              controller: controller,
              child: ProjectsSection(key: controller.projectsKey),
            ),

            _SectionDetector(
              sectionName: 'skills',
              controller: controller,
              child: SkillsSection(key: controller.skillsKey),
            ),

            _SectionDetector(
              sectionName: 'about',
              controller: controller,
              child: AboutSection(key: controller.aboutKey),
            ),

            _SectionDetector(
              sectionName: 'contact',
              controller: controller,
              child: ContactSection(key: controller.contactKey),
            ),

          ],
        ),
      ),
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

  final String          sectionName;
  final HomeController  controller;
  final Widget          child;

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
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:portfolio_web_app/core/constants/app_strings.dart';
import 'package:portfolio_web_app/core/navigation/route_names.dart';
import 'package:portfolio_web_app/core/responsive/responsive.dart';
import 'package:portfolio_web_app/screens/projects/secondary_screen_shell.dart';

class SoftwareProjectScreen extends StatelessWidget {
  const SoftwareProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);
    return SecondaryScreenShell(
      title:    AppStrings.catSoftware,
      overline: 'DEVELOPMENT',
      child: ProjectGrid(
        columns: screen.subProjectCardColumns,
        cards: [
          SubCategoryCard(
            title:       AppStrings.subWeb,
            description: AppStrings.subWebDesc,
            icon:        Icons.web_rounded,
            onTap:       () => Get.toNamed(RouteNames.softwareWeb),
          ),
          SubCategoryCard(
            title:       AppStrings.subMobile,
            description: AppStrings.subMobileDesc,
            icon:        Icons.phone_android_rounded,
            onTap:       () => Get.toNamed(RouteNames.softwareMobile),
          ),
          SubCategoryCard(
            title:       AppStrings.subGithub,
            description: AppStrings.subGithubDesc,
            icon:        Icons.code_rounded,
            onTap:       () => Get.toNamed(RouteNames.softwareGithub),
          ),
        ],
      ),
    );
  }
}

//  Web Applications // Add more _SoftwareProject entries to _projects as web apps are published.

class WebAppsScreen extends StatelessWidget {
  const WebAppsScreen({super.key});

  static const List<_SoftwareProject> _projects = [
    _SoftwareProject(
      title:       AppStrings.projPrayerBoxTitle,
      description: AppStrings.projPrayerBoxDesc,
      imageUrl:    AppStrings.fbPrayerBoxWeb,
      liveUrl:     AppStrings.projPrayerBoxWeb,
      githubUrl:   AppStrings.projPrayerBoxGithub,
    ),
    // Add more web projects here:
    // _SoftwareProject(
    //   title:       'Project Name',
    //   description: 'Short description.',
    //   imageUrl:    'https://firebasestorage.googleapis.com/v0/b/YOUR_BUCKET/o/projects%2Fscreenshot.jpg?alt=media',
    //   liveUrl:     'https://yourproject.com',
    //   githubUrl:   'https://github.com/yourname/project',
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);
    return SecondaryScreenShell(
      title:    AppStrings.subWeb,
      overline: 'SOFTWARE',
      child: ProjectGrid(
        columns: screen.subProjectCardColumns,
        cards: _projects.map((p) => ProjectCard(
          title:       p.title,
          description: p.description,
          imageUrl:    p.imageUrl,
          links: [
            if (p.liveUrl   != null) _ProjectLink.live(p.liveUrl!),
            if (p.githubUrl != null) _ProjectLink.github(p.githubUrl!),
          ],
        )).toList(),
      ),
    );
  }
}

//  Mobile Applications 
class MobileAppsScreen extends StatelessWidget {
  const MobileAppsScreen({super.key});

  static const List<_SoftwareProject> _projects = [
    _SoftwareProject(
      title:       AppStrings.projPrayerBoxTitle,
      description: AppStrings.projPrayerBoxDesc,
      imageUrl:    AppStrings.fbPrayerBoxMobile,
      liveUrl:     AppStrings.projPrayerBoxWeb,
      githubUrl:   AppStrings.projPrayerBoxGithub,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);
    return SecondaryScreenShell(
      title:    AppStrings.subMobile,
      overline: 'SOFTWARE',
      child: ProjectGrid(
        columns: screen.subProjectCardColumns,
        cards: _projects.map((p) => ProjectCard(
          title:       p.title,
          description: p.description,
          imageUrl:    p.imageUrl,
          links: [
            if (p.liveUrl   != null) _ProjectLink.live(p.liveUrl!),
            if (p.githubUrl != null) _ProjectLink.github(p.githubUrl!),
          ],
        )).toList(),
      ),
    );
  }
}

//  GitHub Projects // Add individual repo cards below as more projects are published.

class GithubProjectsScreen extends StatelessWidget {
  const GithubProjectsScreen({super.key});

  static const List<_SoftwareProject> _projects = [
    _SoftwareProject(
      title:       'GitHub Profile',
      description: 'Browse all public repositories, contributions, and open source work.',
      githubUrl:   AppStrings.githubProfile,
    ),
    // Add individual repos here:
    // _SoftwareProject(
    //   title:     'Repo Name',
    //   description: 'Short description of what this repo does.',
    //   imageUrl: 'https://firebasestorage.googleapis.com/v0/b/YOUR_BUCKET/o/projects%2Frepo_screenshot.jpg?alt=media',
    //   githubUrl: 'https://github.com/yourname/repo-name',
    //   liveUrl:   'https://yourdeployment.com',  // optional
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);
    return SecondaryScreenShell(
      title:    AppStrings.subGithub,
      overline: 'SOFTWARE',
      child: ProjectGrid(
        columns: screen.subProjectCardColumns,
        cards: _projects.map((p) => ProjectCard(
          title:       p.title,
          description: p.description,
          imageUrl:    p.imageUrl,
          links: [
            if (p.githubUrl != null) _ProjectLink.github(p.githubUrl!),
            if (p.liveUrl   != null) _ProjectLink.live(p.liveUrl!),
          ],
        )).toList(),
      ),
    );
  }
}

//  Shared data model 
class _SoftwareProject {
  const _SoftwareProject({
    required this.title,
    required this.description,
    this.imageUrl,
    this.liveUrl,
    this.githubUrl,
  });
  final String  title;
  final String  description;
  final String? imageUrl;  // Firebase Storage download URL
  final String? liveUrl;
  final String? githubUrl;
}
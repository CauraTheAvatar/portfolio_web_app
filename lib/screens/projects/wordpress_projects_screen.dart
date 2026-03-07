import 'package:flutter/material.dart';
import 'package:portfolio_web_app/core/constants/app_strings.dart';
import 'package:portfolio_web_app/core/responsive/responsive.dart';
import 'package:portfolio_web_app/screens/projects/secondary_screen_shell.dart';

class WordPressProjectsScreen extends StatelessWidget {
  const WordPressProjectsScreen({super.key});

  static const List<_WordPressProject> _projects = [
    _WordPressProject(
      title:       AppStrings.projCaoCaoTitle,
      description: AppStrings.projCaoCaoDesc,
      imageUrl:    AppStrings.fbCaoCao,
      liveUrl:     AppStrings.projCaoCaoUrl,
    ),
    // Add more WordPress projects here:
    // _WordPressProject(
    //   title:       'Site Name',
    //   description: 'Short description.',
    //   imageUrl:    'https://firebasestorage.googleapis.com/v0/b/YOUR_BUCKET/o/projects%2Fscreenshot.jpg?alt=media',
    //   liveUrl:     'https://yoursite.com',
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);
    return SecondaryScreenShell(
      title:    AppStrings.catWordPress,
      overline: 'CMS & WEB',
      child: ProjectGrid(
        columns: screen.subProjectCardColumns,
        cards: _projects.map((p) => ProjectCard(
          title:       p.title,
          description: p.description,
          imageUrl:    p.imageUrl,
          links: [
            _ProjectLink.live(p.liveUrl),
          ],
        )).toList(),
      ),
    );
  }
}

class _WordPressProject {
  const _WordPressProject({
    required this.title,
    required this.description,
    required this.liveUrl,
    this.imageUrl,
  });
  final String  title;
  final String  description;
  final String  liveUrl;
  final String? imageUrl;  // Firebase Storage download URL
}
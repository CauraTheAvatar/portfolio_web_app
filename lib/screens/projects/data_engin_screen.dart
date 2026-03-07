import 'package:flutter/material.dart';
import 'package:portfolio_web_app/core/constants/app_strings.dart';
import 'package:portfolio_web_app/core/responsive/responsive.dart';
import 'package:portfolio_web_app/screens/projects/secondary_screen_shell.dart';

class DataEnginScreen extends StatelessWidget {
  const DataEnginScreen({super.key});

  static const List<_DataEngProject> _projects = [
    _DataEngProject(
      title:     AppStrings.projPipelineTitle,
      description: AppStrings.projPipelineDesc,
      githubUrl: AppStrings.projPipelineGithub,
    ),
    // Add more data engineering projects here:
    // _DataEngProject(
    //   title:       'Project Name',
    //   description: 'Short description.',
    //   imageUrl:    'https://firebasestorage.googleapis.com/v0/b/YOUR_BUCKET/o/projects%2Fscreenshot.jpg?alt=media',
    //   githubUrl:   'https://github.com/yourname/project',
    //   liveUrl:     'https://yourdeployment.com',  // optional
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);
    return SecondaryScreenShell(
      title:    AppStrings.catDataEng,
      overline: 'ENGINEERING',
      child: ProjectGrid(
        columns: screen.subProjectCardColumns,
        cards: _projects.map((p) => ProjectCard(
          title:       p.title,
          description: p.description,
          imageUrl:    p.imageUrl,
          links: [
            _ProjectLink.github(p.githubUrl),
            if (p.liveUrl != null) _ProjectLink.live(p.liveUrl!),
          ],
        )).toList(),
      ),
    );
  }
}

class _DataEngProject {
  const _DataEngProject({
    required this.title,
    required this.description,
    required this.githubUrl,
    this.imageUrl,
    this.liveUrl,
  });
  final String  title;
  final String  description;
  final String  githubUrl;
  final String? imageUrl;  // Firebase Storage download URL
  final String? liveUrl;
}
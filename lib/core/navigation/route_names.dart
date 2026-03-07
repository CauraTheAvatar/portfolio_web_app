class RouteNames {
  RouteNames._();

  // Core 
  static const String home = '/';

  // Project category sub-screens 
  static const String projectSoftware  = '/projects/software';
  static const String projectWordPress = '/projects/wordpress';
  static const String projectDataEng   = '/projects/data-engineering';
  static const String projectDataAnal  = '/projects/data-analytics';
  static const String projectUIDesign  = '/projects/ui-design';
  static const String projectGraphic   = '/projects/graphic-design';

  // Software sub-screens 
  static const String softwareWeb     = '/projects/software/web';
  static const String softwareMobile  = '/projects/software/mobile';
  static const String softwareGithub  = '/projects/software/github';

  // Data Analytics sub-screens 
  static const String dataAnalFull    = '/projects/data-analytics/full';
  static const String dataAnalViz     = '/projects/data-analytics/visualization';
  static const String dataAnalCode    = '/projects/data-analytics/code';

  // Graphic Design sub-screens 
  static const String graphicDetail   = '/projects/graphic-design/detail';

  // Sections (deep-link anchors)
  static const String hero     = '/hero';
  static const String projects = '/projects';
  static const String skills   = '/skills';
  static const String about    = '/about';
  static const String contact  = '/contact';

  // Helpers 
  static const List<String> sections = [
    hero,
    projects,
    skills,
    about,
    contact,
  ];

  /// Maps a section route string to its [HomeController] activeSection key.
  static const Map<String, String> routeToSection = {
    hero:     'hero',
    projects: 'projects',
    skills:   'skills',
    about:    'about',
    contact:  'contact',
  };
}
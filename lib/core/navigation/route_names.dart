class RouteNames {
  RouteNames._();

  // Core 
  static const String home = '/';

  // Project category sub-screens 
  static const String projectSoftware  = '/projects/software';
  static const String projectWordPress = '/projects/wordpress';
  static const String projectDataEng   = '/projects/data-engineering';
  static const String projectDataViz   = '/projects/data-visualization';
  static const String projectDataAnal  = '/projects/data-analytics';
  static const String projectUIDesign  = '/projects/ui-design';
  static const String projectGraphic   = '/projects/graphic-design';

  // Sections (deep-link anchors) 
  // These are not separate routes — they are used as named anchors
  // passed to ScrollService to jump to a section from outside HomeScreen.
  static const String hero     = '/hero';
  static const String projects = '/projects';
  static const String skills   = '/skills';
  static const String about    = '/about';
  static const String contact  = '/contact';

  // Helpers 

  // All registered section anchor names in top-to-bottom order.
  static const List<String> sections = [
    hero,
    projects,
    skills,
    about,
    contact,
  ];

  // Maps a section route string to its [HomeController] activeSection key.
  // Used by ScrollService to resolve an incoming deep-link to the correct key.
  static const Map<String, String> routeToSection = {
    hero:     'hero',
    projects: 'projects',
    skills:   'skills',
    about:    'about',
    contact:  'contact',
  };
}
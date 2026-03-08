import 'package:flutter/material.dart';

enum ProjectCategory {
  softwareDevelopment,
  wordpress,
  dataEngineering,
  dataVisualization,
  dataAnalytics,
  uiDesign,
  graphicDesign,
}

extension ProjectCategoryExtension on ProjectCategory {
  String get displayName {
    switch (this) {
      case ProjectCategory.softwareDevelopment:
        return 'Software Development';
      case ProjectCategory.wordpress:
        return 'WordPress Projects';
      case ProjectCategory.dataEngineering:
        return 'Data Engineering';
      case ProjectCategory.dataVisualization:
        return 'Data Visualization (Tableau)';
      case ProjectCategory.dataAnalytics:
        return 'Data Analytics';
      case ProjectCategory.uiDesign:
        return 'UI Design';
      case ProjectCategory.graphicDesign:
        return 'Graphic Design';
    }
  }

  String get routeName {
    switch (this) {
      case ProjectCategory.softwareDevelopment:
        return '/projects/software';
      case ProjectCategory.wordpress:
        return '/projects/wordpress';
      case ProjectCategory.dataEngineering:
        return '/projects/data-engineering';
      case ProjectCategory.dataVisualization:
        return '/projects/data-visualization';
      case ProjectCategory.dataAnalytics:
        return '/projects/data-analytics';
      case ProjectCategory.uiDesign:
        return '/projects/ui-design';
      case ProjectCategory.graphicDesign:
        return '/projects/graphic-design';
    }
  }

  IconData get icon {
    switch (this) {
      case ProjectCategory.softwareDevelopment:
        return Icons.code_rounded;
      case ProjectCategory.wordpress:
        return Icons.language_rounded;
      case ProjectCategory.dataEngineering:
        return Icons.storage_rounded;
      case ProjectCategory.dataVisualization:
        return Icons.bar_chart_rounded;
      case ProjectCategory.dataAnalytics:
        return Icons.analytics_rounded;
      case ProjectCategory.uiDesign:
        return Icons.design_services_rounded;
      case ProjectCategory.graphicDesign:
        return Icons.brush_rounded;
    }
  }

  String get description {
    switch (this) {
      case ProjectCategory.softwareDevelopment:
        return 'Web and mobile applications built with modern frameworks';
      case ProjectCategory.wordpress:
        return 'Custom WordPress themes and plugins';
      case ProjectCategory.dataEngineering:
        return 'Scalable data pipelines and ETL processes';
      case ProjectCategory.dataVisualization:
        return 'Interactive Tableau dashboards';
      case ProjectCategory.dataAnalytics:
        return 'Data analysis with Python and SQL';
      case ProjectCategory.uiDesign:
        return 'User interface designs in Figma and Canva';
      case ProjectCategory.graphicDesign:
        return 'Posters, branding, and digital illustrations';
    }
  }
}
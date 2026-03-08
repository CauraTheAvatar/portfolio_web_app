import 'package:portfolio_web_app/models/project_category_model.dart';

enum ProjectType {
  webApp,
  mobileApp,
  github,
  wordpress,
  dataPipeline,
  tableau,
  analytics,
  uiDesign,
  graphicDesign,
}

class ProjectModel {
  final String id;
  final String title;
  final String description;
  final ProjectCategory category;
  final ProjectType type;
  final List<String> imageUrls;
  final String? thumbnailUrl;
  final Map<String, String> links; // 'github', 'live', 'figma', 'canva', 'documentation'
  final List<String> technologies;
  final DateTime? dateCompleted;
  final bool isFeatured;
  final int? order;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.type,
    this.imageUrls = const [],
    this.thumbnailUrl,
    this.links = const {},
    this.technologies = const [],
    this.dateCompleted,
    this.isFeatured = false,
    this.order,
  });

  // Software Development Projects
  factory ProjectModel.software({
    required String id,
    required String title,
    required String description,
    required ProjectType type,
    String? thumbnailUrl,
    List<String> imageUrls = const [],
    Map<String, String> links = const {},
    List<String> technologies = const [],
    DateTime? dateCompleted,
    bool isFeatured = false,
    int? order,
  }) {
    return ProjectModel(
      id: id,
      title: title,
      description: description,
      category: ProjectCategory.softwareDevelopment,
      type: type,
      thumbnailUrl: thumbnailUrl,
      imageUrls: imageUrls,
      links: links,
      technologies: technologies,
      dateCompleted: dateCompleted,
      isFeatured: isFeatured,
      order: order,
    );
  }

  // WordPress Projects
  factory ProjectModel.wordPress({
    required String id,
    required String title,
    required String description,
    String? thumbnailUrl,
    List<String> imageUrls = const [],
    required String liveUrl,
    List<String> technologies = const [],
    DateTime? dateCompleted,
    bool isFeatured = false,
    int? order,
  }) {
    return ProjectModel(
      id: id,
      title: title,
      description: description,
      category: ProjectCategory.wordpress,
      type: ProjectType.wordpress,
      thumbnailUrl: thumbnailUrl,
      imageUrls: imageUrls,
      links: {'live': liveUrl},
      technologies: technologies,
      dateCompleted: dateCompleted,
      isFeatured: isFeatured,
      order: order,
    );
  }

  // Data Engineering Projects
  factory ProjectModel.dataEngineering({
    required String id,
    required String title,
    required String description,
    String? thumbnailUrl,
    List<String> imageUrls = const [],
    required String githubUrl,
    String? liveUrl,
    List<String> technologies = const [],
    DateTime? dateCompleted,
    bool isFeatured = false,
    int? order,
  }) {
    final links = {'github': githubUrl};
    if (liveUrl != null) links['live'] = liveUrl;
    
    return ProjectModel(
      id: id,
      title: title,
      description: description,
      category: ProjectCategory.dataEngineering,
      type: ProjectType.dataPipeline,
      thumbnailUrl: thumbnailUrl,
      imageUrls: imageUrls,
      links: links,
      technologies: technologies,
      dateCompleted: dateCompleted,
      isFeatured: isFeatured,
      order: order,
    );
  }

  // Data Analytics Projects
  factory ProjectModel.dataAnalytics({
    required String id,
    required String title,
    required String description,
    String? thumbnailUrl,
    List<String> imageUrls = const [],
    required String documentationUrl,
    String? tableauUrl,
    String? githubUrl,
    List<String> technologies = const [],
    DateTime? dateCompleted,
    bool isFeatured = false,
    int? order,
  }) {
    final links = {'documentation': documentationUrl};
    if (tableauUrl != null) links['tableau'] = tableauUrl;
    if (githubUrl != null) links['github'] = githubUrl;
    
    return ProjectModel(
      id: id,
      title: title,
      description: description,
      category: ProjectCategory.dataAnalytics,
      type: ProjectType.analytics,
      thumbnailUrl: thumbnailUrl,
      imageUrls: imageUrls,
      links: links,
      technologies: technologies,
      dateCompleted: dateCompleted,
      isFeatured: isFeatured,
      order: order,
    );
  }

  // UI Design Projects
  factory ProjectModel.uiDesign({
    required String id,
    required String title,
    required String description,
    required List<String> imageUrls,
    String? thumbnailUrl,
    required String figmaUrl,
    String? canvaUrl,
    List<String> technologies = const [],
    DateTime? dateCompleted,
    bool isFeatured = false,
    int? order,
  }) {
    final links = {'figma': figmaUrl};
    if (canvaUrl != null) links['canva'] = canvaUrl;
    
    return ProjectModel(
      id: id,
      title: title,
      description: description,
      category: ProjectCategory.uiDesign,
      type: ProjectType.uiDesign,
      thumbnailUrl: thumbnailUrl,
      imageUrls: imageUrls,
      links: links,
      technologies: technologies,
      dateCompleted: dateCompleted,
      isFeatured: isFeatured,
      order: order,
    );
  }

  // Graphic Design Projects
  factory ProjectModel.graphicDesign({
    required String id,
    required String title,
    required String description,
    required List<String> imageUrls,
    String? thumbnailUrl,
    String? canvaUrl,
    List<String> technologies = const [],
    DateTime? dateCompleted,
    bool isFeatured = false,
    int? order,
  }) {
    final links = <String, String>{};
    if (canvaUrl != null) links['canva'] = canvaUrl;
    
    return ProjectModel(
      id: id,
      title: title,
      description: description,
      category: ProjectCategory.graphicDesign,
      type: ProjectType.graphicDesign,
      thumbnailUrl: thumbnailUrl,
      imageUrls: imageUrls,
      links: links,
      technologies: technologies,
      dateCompleted: dateCompleted,
      isFeatured: isFeatured,
      order: order,
    );
  }

  // Convert to/from JSON for Firebase
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category.index,
        'type': type.index,
        'imageUrls': imageUrls,
        'thumbnailUrl': thumbnailUrl,
        'links': links,
        'technologies': technologies,
        'dateCompleted': dateCompleted?.toIso8601String(),
        'isFeatured': isFeatured,
        'order': order,
      };

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        category: ProjectCategory.values[json['category']],
        type: ProjectType.values[json['type']],
        imageUrls: List<String>.from(json['imageUrls'] ?? []),
        thumbnailUrl: json['thumbnailUrl'],
        links: Map<String, String>.from(json['links'] ?? {}),
        technologies: List<String>.from(json['technologies'] ?? []),
        dateCompleted: json['dateCompleted'] != null
            ? DateTime.parse(json['dateCompleted'])
            : null,
        isFeatured: json['isFeatured'] ?? false,
        order: json['order'],
      );
}
class SkillModel {
  final String name;
  final String category;
  final String? iconName;
  final int proficiency; 
  final List<String>? keywords;

  SkillModel({
    required this.name,
    required this.category,
    this.iconName,
    required this.proficiency,
    this.keywords,
  });

  // For software engineering skills
  factory SkillModel.software({
    required String name,
    required int proficiency,
    String? iconName,
    List<String>? keywords,
  }) {
    return SkillModel(
      name: name,
      category: 'Software Engineering',
      iconName: iconName,
      proficiency: proficiency,
      keywords: keywords,
    );
  }

  // For data science skills
  factory SkillModel.dataScience({
    required String name,
    required int proficiency,
    String? iconName,
    List<String>? keywords,
  }) {
    return SkillModel(
      name: name,
      category: 'Data Science',
      iconName: iconName,
      proficiency: proficiency,
      keywords: keywords,
    );
  }

  // For UI/UX design skills
  factory SkillModel.uiUx({
    required String name,
    required int proficiency,
    String? iconName,
    List<String>? keywords,
  }) {
    return SkillModel(
      name: name,
      category: 'UI/UX Design',
      iconName: iconName,
      proficiency: proficiency,
      keywords: keywords,
    );
  }

  // For graphic design skills
  factory SkillModel.graphicDesign({
    required String name,
    required int proficiency,
    String? iconName,
    List<String>? keywords,
  }) {
    return SkillModel(
      name: name,
      category: 'Graphic Design',
      iconName: iconName,
      proficiency: proficiency,
      keywords: keywords,
    );
  }

  // Convert to/from JSON for storage
  Map<String, dynamic> toJson() => {
        'name': name,
        'category': category,
        'iconName': iconName,
        'proficiency': proficiency,
        'keywords': keywords,
      };

  factory SkillModel.fromJson(Map<String, dynamic> json) => SkillModel(
        name: json['name'],
        category: json['category'],
        iconName: json['iconName'],
        proficiency: json['proficiency'],
        keywords: json['keywords']?.cast<String>(),
      );
}
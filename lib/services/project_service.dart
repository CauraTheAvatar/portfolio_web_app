import 'package:get/get.dart';
import 'package:portfolio_web_app/models/project_model.dart';
import 'package:portfolio_web_app/models/project_category_model.dart';
import 'package:portfolio_web_app/core/constants/app_strings.dart';

class ProjectService extends GetxService {
  static ProjectService get to => Get.find();

  final RxList<ProjectModel> _projects = <ProjectModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  List<ProjectModel> get projects => _projects;

  @override
  void onInit() {
    super.onInit();
    loadProjects();
  }

  Future<void> loadProjects() async {
    try {
      isLoading.value = true;
      error.value = '';

      // TODO: Load from Firebase/Firestore
      // For now, using mock data
      _mockLoadProjects();
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void _mockLoadProjects() {
    // Mock data - replace with actual Firebase loading
    _projects.clear();

    // Software projects
    _projects.addAll([
      ProjectModel.software(
        id: 'prayer-box-web',
        title: 'Prayer Box Web',
        description: 'A web application for prayer journaling and reflection',
        type: ProjectType.webApp,
        thumbnailUrl: AppStrings.fbPrayerBoxWeb,
        links: {
          'live': AppStrings.projPrayerBoxWeb,
          'github': AppStrings.projPrayerBoxGithub,
        },
        technologies: ['Flutter', 'Firebase', 'GetX'],
        isFeatured: true,
      ),
      // Add more projects...
    ]);
  }

  // Get projects by category
  List<ProjectModel> getProjectsByCategory(ProjectCategory category) {
    return _projects.where((p) => p.category == category).toList();
  }

  // Get featured projects
  List<ProjectModel> getFeaturedProjects() {
    return _projects.where((p) => p.isFeatured).toList();
  }

  // Get project by ID
  ProjectModel? getProjectById(String id) {
    try {
      return _projects.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  // Refresh projects from Firebase
  Future<void> refreshProjects() async {
    await loadProjects();
  }

  // For Firebase integration later
  Future<void> syncWithFirebase() async {
    // TODO: Implement Firebase sync
  }
}
import 'package:get/get.dart';

import 'package:portfolio_web_app/core/navigation/route_names.dart';
import 'package:portfolio_web_app/screens/home/home_screen.dart';
import 'package:portfolio_web_app/screens/projects/data_analy_screen.dart';
import 'package:portfolio_web_app/screens/projects/data_engin_screen.dart';
import 'package:portfolio_web_app/screens/projects/graphic_design_screen.dart';
import 'package:portfolio_web_app/screens/projects/software_project_screen.dart';
import 'package:portfolio_web_app/screens/projects/ui_design_gallery_screen.dart';
import 'package:portfolio_web_app/screens/projects/wordpress_projects_screen.dart';

class AppRouter {
  AppRouter._();

  static final List<GetPage> pages = [

    GetPage(
      name: RouteNames.home,
      page: () => const HomeScreen(),
      transition: Transition.fadeIn,
    ),

    // Software 
    GetPage(
      name: RouteNames.projectSoftware,
      page: () => const SoftwareProjectScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: RouteNames.softwareWeb,
      page: () => const WebAppsScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: RouteNames.softwareMobile,
      page: () => const MobileAppsScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: RouteNames.softwareGithub,
      page: () => const GithubProjectsScreen(),
      transition: Transition.rightToLeftWithFade,
    ),

    // WordPress 
    GetPage(
      name: RouteNames.projectWordPress,
      page: () => const WordPressProjectsScreen(),
      transition: Transition.rightToLeftWithFade,
    ),

    // Data Engineering 
    GetPage(
      name: RouteNames.projectDataEng,
      page: () => const DataEnginScreen(),
      transition: Transition.rightToLeftWithFade,
    ),

    // Data Analytics 
    GetPage(
      name: RouteNames.projectDataAnal,
      page: () => const DataAnalyScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: RouteNames.dataAnalFull,
      page: () => const DataAnalProjectsScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: RouteNames.dataAnalCode,
      page: () => const DataAnalCodeScreen(),
      transition: Transition.rightToLeftWithFade,
    ),

    // UI Design 
    GetPage(
      name: RouteNames.projectUIDesign,
      page: () => const UIDesignGalleryScreen(),
      transition: Transition.rightToLeftWithFade,
    ),

    // Graphic Design 
    GetPage(
      name: RouteNames.projectGraphic,
      page: () => const GraphicDesignScreen(),
      transition: Transition.rightToLeftWithFade,
    ),

  ];
}
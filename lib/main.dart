import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:portfolio_web_app/controllers/home_controller.dart';
import 'package:portfolio_web_app/controllers/contact_controller.dart';

import 'package:portfolio_web_app/core/constants/app_strings.dart';
import 'package:portfolio_web_app/core/navigation/scroll_service.dart';
import 'package:portfolio_web_app/core/navigation/app_router.dart';
import 'package:portfolio_web_app/core/theme/app_theme.dart';
import 'package:portfolio_web_app/core/navigation/route_names.dart';
import 'package:portfolio_web_app/core/theme/app_colors.dart'; 
import 'package:portfolio_web_app/core/theme/app_textstyle.dart'; 

import 'package:portfolio_web_app/services/analytics_service.dart';
import 'package:portfolio_web_app/services/project_service.dart';
import 'package:portfolio_web_app/services/formspree_service.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Laura Conceicao Uuyuni Portfolio",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: RouteNames.home,
      getPages: AppRouter.pages,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      
      // Initialize all services and controllers
      builder: (context, child) {
        // Initialize services 
        Get.put(AnalyticsService(), permanent: true);
        Get.put(ProjectService(), permanent: true);
        Get.put(FormspreeService(), permanent: true);
        Get.put(ScrollService(), permanent: true);
        
        // Initialize controllers
        Get.put(HomeController(), permanent: true);
        Get.put(ContactController(), permanent: true);
        
        return child!;
      },
      
      // Add routing callback for analytics
      routingCallback: (routing) {
        // Track screen views for analytics
        if (routing?.current != null) {
          AnalyticsService.to.logScreenView(routing!.current);
        }
      },
      
      // Add unknown route handling
      unknownRoute: GetPage(
        name: '/404',
        page: () => const NotFoundScreen(),
        transition: Transition.fadeIn,
      ),
    );
  }
}

// 404 screen for unknown routes
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 64,
              color: AppColors.gold.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              '404 - Page Not Found',
              style: AppTextStyle.sectionTitle,
            ),
            const SizedBox(height: 8),
            Text(
              'The page you\'re looking for doesn\'t exist.',
              style: AppTextStyle.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Get.offAllNamed(RouteNames.home),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.black,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
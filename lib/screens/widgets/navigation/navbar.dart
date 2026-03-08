import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_web_app/controllers/home_controller.dart';
import 'package:portfolio_web_app/core/constants/app_strings.dart';
import 'package:portfolio_web_app/core/constants/app_sizes.dart';
import 'package:portfolio_web_app/core/theme/app_colors.dart';
import 'package:portfolio_web_app/core/theme/app_textstyle.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  const Navbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(AppSizes.navbarHeight);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;

    return Container(
      height: AppSizes.navbarHeight,
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.8),
        borderRadius: BorderRadius.zero,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: AppSizes.navbarShadowBlur,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: AppSizes.navbarBlurSigma,
            sigmaY: AppSizes.navbarBlurSigma,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.spaceXL),
            child: Row(
              children: [
                // Logo / Developer Name
                _buildLogo(controller),
                
                const Spacer(),
                
                // Navigation Items (Desktop) or Menu Button (Mobile)
                if (isMobile)
                  _buildMobileMenuButton(context, controller)
                else
                  _buildDesktopNavItems(controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(HomeController controller) {
    return GestureDetector(
      onTap: () {
        // Scroll to hero section when logo is tapped
        controller.scrollToSection(controller.heroKey);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: AppSizes.navbarLogoDotSize,
            height: AppSizes.navbarLogoDotSize,
            decoration: const BoxDecoration(
              color: AppColors.gold,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppSizes.navbarLogoDotSpacing),
          Text(
            AppStrings.developerName,
            style: AppTextStyle.navbarLogo,
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopNavItems(HomeController controller) {
    return Obx(() => Row(
      children: [
        NavbarItem(
          title: AppStrings.navHero,
          isActive: controller.activeSection.value == 'hero',
          onTap: () => controller.scrollToSection(controller.heroKey),
        ),
        NavbarItem(
          title: AppStrings.navProjects,
          isActive: controller.activeSection.value == 'projects',
          onTap: () => controller.scrollToSection(controller.projectsKey),
        ),
        NavbarItem(
          title: AppStrings.navSkills,
          isActive: controller.activeSection.value == 'skills',
          onTap: () => controller.scrollToSection(controller.skillsKey),
        ),
        NavbarItem(
          title: 'Experience', // You can add this to AppStrings if desired
          isActive: controller.activeSection.value == 'experience',
          onTap: () => controller.scrollToSection(controller.experienceKey),
        ),
        NavbarItem(
          title: AppStrings.navAbout,
          isActive: controller.activeSection.value == 'about',
          onTap: () => controller.scrollToSection(controller.aboutKey),
        ),
        NavbarItem(
          title: AppStrings.navContact,
          isActive: controller.activeSection.value == 'contact',
          onTap: () => controller.scrollToSection(controller.contactKey),
        ),
      ],
    ));
  }

  Widget _buildMobileMenuButton(BuildContext context, HomeController controller) {
    return IconButton(
      icon: const Icon(Icons.menu, color: AppColors.black),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );
  }
}

// NavbarItem widget 
class NavbarItem extends StatefulWidget {
  const NavbarItem({
    super.key,
    required this.title,
    required this.onTap,
    this.isActive = false,
  });

  final String title;
  final VoidCallback onTap;
  final bool isActive;

  @override
  State<NavbarItem> createState() => _NavbarItemState();
}

class _NavbarItemState extends State<NavbarItem> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    final bool highlighted = _isHover || widget.isActive;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHover = true),
      onExit: (_) => setState(() => _isHover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.navbarItemPaddingH),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Label 
              AnimatedDefaultTextStyle(
                duration: AppSizes.durationDefault,
                style: highlighted
                    ? AppTextStyle.navItemActive
                    : AppTextStyle.navItem,
                child: Text(widget.title),
              ),

              const SizedBox(height: AppSizes.navbarUnderlineGap),

              // Gold underline — grows from 0 → 24px on highlight
              AnimatedContainer(
                duration: AppSizes.durationDefault,
                curve: Curves.easeOut,
                height: AppSizes.navbarUnderlineHeight,
                width: highlighted ? AppSizes.navbarUnderlineWidth : 0,
                decoration: BoxDecoration(
                  color: AppColors.gold,
                  borderRadius: BorderRadius.circular(AppSizes.radiusXS),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
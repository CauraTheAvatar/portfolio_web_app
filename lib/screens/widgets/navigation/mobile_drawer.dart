import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_web_app/controllers/home_controller.dart';
import 'package:portfolio_web_app/core/constants/app_strings.dart';
import 'package:portfolio_web_app/core/constants/app_sizes.dart';
import 'package:portfolio_web_app/core/theme/app_colors.dart'; // ADD THIS IMPORT
import 'package:portfolio_web_app/core/theme/app_textstyle.dart'; // ADD THIS IMPORT

class MobileDrawer extends StatelessWidget {
  const MobileDrawer({super.key, required this.controller});

  final HomeController controller;

  static void show(BuildContext context, HomeController controller) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Close menu',
      barrierColor: Colors.black.withOpacity(0.4),
      transitionDuration: AppSizes.durationMedium,
      pageBuilder: (_, __, ___) => MobileDrawer(controller: controller),
      transitionBuilder: (_, anim, __, child) {
        final slide = Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic));
        return SlideTransition(position: slide, child: child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: AppSizes.drawerWidth,
          height: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.13),
                blurRadius: AppSizes.drawerShadowBlur,
                offset: const Offset(AppSizes.drawerShadowOffsetX, 0),
              ),
            ],
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header — name + close button
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSizes.drawerHeaderPadL,
                    AppSizes.drawerHeaderPadT,
                    AppSizes.drawerHeaderPadR,
                    0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.developerName,
                        style: AppTextStyle.cardTitle.copyWith(
                          fontStyle: FontStyle.italic,
                          color: AppColors.gold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close_rounded,
                          color: AppColors.black,
                          size: 22,
                        ),
                        splashRadius: 18,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),

                // Gold divider
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: AppSizes.drawerDividerSpacingH,
                    vertical: AppSizes.drawerDividerSpacingV,
                  ),
                  height: AppSizes.drawerDividerHeight,
                  color: AppColors.gold.withOpacity(0.3),
                ),

                // Nav links — Obx so active state updates while drawer is open
                Obx(() => _NavLinks(
                      controller: controller,
                      onItemTap: (key) {
                        Navigator.of(context).pop();
                        // FIXED: Convert Duration to milliseconds and divide
                        Future.delayed(
                          Duration(
                            milliseconds:
                                (AppSizes.durationScroll.inMilliseconds / 2)
                                    .round(),
                          ),
                          () => controller.scrollTo(key),
                        );
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Nav Links — list of drawer items
class _NavLinks extends StatelessWidget {
  const _NavLinks({
    required this.controller,
    required this.onItemTap,
  });

  final HomeController controller;
  final void Function(GlobalKey key) onItemTap;

  @override
  Widget build(BuildContext context) {
    final items = [
      (AppStrings.navHero, 'hero', controller.heroKey),
      (AppStrings.navProjects, 'projects', controller.projectsKey),
      (AppStrings.navSkills, 'skills', controller.skillsKey),
      (AppStrings.navAbout, 'about', controller.aboutKey),
      (AppStrings.navContact, 'contact', controller.contactKey),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        final (title, section, key) = item;
        return _DrawerNavItem(
          title: title,
          isActive: controller.activeSection.value == section,
          onTap: () => onItemTap(key),
        );
      }).toList(),
    );
  }
}

// DrawerNavItem — individual link row inside the drawer
class _DrawerNavItem extends StatefulWidget {
  const _DrawerNavItem({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  final String title;
  final bool isActive;
  final VoidCallback onTap;

  @override
  State<_DrawerNavItem> createState() => _DrawerNavItemState();
}

class _DrawerNavItemState extends State<_DrawerNavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final bool highlighted = _hovered || widget.isActive;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppSizes.durationFast,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.drawerItemPaddingH,
            vertical: AppSizes.drawerItemPaddingV,
          ),
          decoration: BoxDecoration(
            color: highlighted
                ? AppColors.gold.withOpacity(0.06)
                : Colors.transparent,
            border: Border(
              left: BorderSide(
                color: highlighted ? AppColors.gold : Colors.transparent,
                width: AppSizes.drawerActiveBorderW,
              ),
            ),
          ),
          child: AnimatedDefaultTextStyle(
            duration: AppSizes.durationFast,
            style: highlighted
                ? AppTextStyle.navItemActive
                : AppTextStyle.navItem,
            child: Text(widget.title),
          ),
        ),
      ),
    );
  }
}
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:portfolio_web_app/core/constants/app_sizes.dart';
import 'package:portfolio_web_app/core/constants/app_strings.dart';
import 'package:portfolio_web_app/core/responsive/responsive.dart';
import 'package:portfolio_web_app/controllers/contact_controller.dart';
import 'package:portfolio_web_app/screens/form/contact_form.dart';
import 'package:portfolio_web_app/screens/home/sections/section_container.dart';
import 'package:portfolio_web_app/core/animations/confetti.dart'; 
import 'package:portfolio_web_app/core/theme/app_colors.dart'; 
import 'package:portfolio_web_app/core/theme/app_textstyle.dart'; 

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);
    final controller = Get.put(ContactController()); // Capture controller reference

    return Stack(
      children: [
        SectionContainer(
          color: AppColors.white,
          addGradient: true,
          useStandardPadding: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const _SectionHeader(),
              const SizedBox(height: AppSizes.sectionHeaderGapContent),
              screen.isMobileOrTablet
                  ? const _MobileLayout()
                  : const _DesktopLayout(), 
            ],
          ),
        ),
        
        // Confetti overlay
        Obx(() => Confetti(
          isActive: controller.showConfetti.value,
          onComplete: () {
            controller.showConfetti.value = false;
          },
          particleCount: 80, // Subtle amount of confetti
          duration: const Duration(seconds: 3),
        )),
      ],
    );
  }
}

// Section Header
class _SectionHeader extends StatelessWidget {
  const _SectionHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('GET IN TOUCH', style: AppTextStyle.overline),
        const SizedBox(height: AppSizes.sectionHeaderGapOverline),
        Text(
          AppStrings.contactTitle,
          style: AppTextStyle.sectionTitle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSizes.sectionHeaderGapRule),
        Container(
          width: AppSizes.goldRuleWidth,
          height: AppSizes.goldRuleHeight,
          decoration: BoxDecoration(
            color: AppColors.gold,
            borderRadius: BorderRadius.circular(AppSizes.radiusXS),
          ),
        ),
        const SizedBox(height: AppSizes.sectionHeaderGapSubtitle),
        Text(
          AppStrings.contactSubtitle,
          style: AppTextStyle.sectionSubtitle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSizes.spaceM),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.heroParaMaxWidth),
          child: Text(
            AppStrings.contactBody,
            style: AppTextStyle.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

// Desktop Layout
class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(flex: 40, child: _ContactInfo()),
        const SizedBox(width: AppSizes.heroColGap),
        Expanded(
          flex: 60,
          child: ContactFormWidget(), 
        ),
      ],
    );
  }
}

// Mobile Layout
class _MobileLayout extends StatelessWidget {
  const _MobileLayout();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _ContactInfo(),
        const SizedBox(height: AppSizes.space5XL),
        ContactFormWidget(), 
      ],
    );
  }
}

// Contact Info
class _ContactInfo extends StatelessWidget {
  const _ContactInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Let\'s connect', style: AppTextStyle.cardTitle),
        const SizedBox(height: AppSizes.spaceM),
        Text(
          'Open to freelance projects, collaborations, and full-time opportunities. '
          'Reach out through the form or connect directly.',
          style: AppTextStyle.bodyMedium,
        ),
        const SizedBox(height: AppSizes.space4XL),
        _SocialLink(
          icon: Icons.email_rounded,
          label: AppStrings.contactEmailLabel,
          value: AppStrings.contactEmail,
        ),
        const SizedBox(height: AppSizes.spaceXXL),
        _SocialLink(
          icon: Icons.code_rounded,
          label: AppStrings.contactGithubLabel,
          value: AppStrings.contactGithub,
        ),
        const SizedBox(height: AppSizes.spaceXXL),
        _SocialLink(
          icon: Icons.link_rounded,
          label: AppStrings.contactLinkedinLabel,
          value: AppStrings.contactLinkedin,
        ),
      ],
    );
  }
}

// Social Link
class _SocialLink extends StatefulWidget {
  const _SocialLink({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  State<_SocialLink> createState() => _SocialLinkState();
}

class _SocialLinkState extends State<_SocialLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () {
          // TODO: Implement actual URL launching
          debugPrint('[Contact] ${widget.value}');
        },
        child: Row(
          children: [
            AnimatedContainer(
              duration: AppSizes.durationDefault,
              padding: const EdgeInsets.all(AppSizes.spaceM),
              decoration: BoxDecoration(
                color: _hovered
                    ? AppColors.gold.withOpacity(0.12)
                    : AppColors.lightGrey,
                borderRadius: BorderRadius.circular(AppSizes.radiusM),
              ),
              child: Icon(
                widget.icon,
                size: AppSizes.iconS,
                color: _hovered ? AppColors.gold : AppColors.grey,
              ),
            ),
            const SizedBox(width: AppSizes.spaceL),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.label,
                  style: AppTextStyle.navItem.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.value,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: _hovered ? AppColors.gold : AppColors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
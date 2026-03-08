import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_web_app/core/constants/app_sizes.dart';
import 'package:portfolio_web_app/core/constants/app_strings.dart';
import 'package:portfolio_web_app/core/responsive/responsive.dart';
import 'package:portfolio_web_app/core/theme/app_colors.dart';
import 'package:portfolio_web_app/core/theme/app_textstyle.dart';
import 'package:portfolio_web_app/services/analytics_service.dart';
import 'package:portfolio_web_app/screens/widgets/cards/skill_card.dart';
import 'package:portfolio_web_app/models/skill_model.dart'; // ADDED - Missing import

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const _SectionHeader(),
          const SizedBox(height: AppSizes.sectionHeaderGapContent),
          const _SkillCardRow(),
        ],
      ),
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
        Text('WHAT I KNOW', style: AppTextStyle.overline),
        const SizedBox(height: AppSizes.sectionHeaderGapOverline),
        Text(
          AppStrings.skillsTitle,
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
          AppStrings.skillsSubtitle,
          style: AppTextStyle.sectionSubtitle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// Skill Card Row
class _SkillCardRow extends StatefulWidget {
  const _SkillCardRow();

  @override
  State<_SkillCardRow> createState() => _SkillCardRowState();
}

class _SkillCardRowState extends State<_SkillCardRow> {
  int _hoveredIndex = -1;

  void _onHover(int index) {
    setState(() => _hoveredIndex = index);
    // Track skill hover for analytics - FIXED: Use named parameter
    AnalyticsService.to.logUserAction(
      'skill_hover',
      properties: {
        'category': AppStrings.skillCategories[index]['title'],
      },
    );
  }

  void _onExit() => setState(() => _hoveredIndex = -1);

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);
    final categories = AppStrings.skillCategories;

    // Convert string-based skills to SkillModel objects
    final skillModels = categories.map((cat) {
      final skills = (cat['skills'] as List).map((skill) => SkillModel(
        name: skill,
        category: cat['title'],
        proficiency: 85, // Default proficiency - you can adjust per skill
        keywords: [],
      )).toList();
      return {
        'title': cat['title'],
        'skills': skills,
      };
    }).toList();

    if (screen.isMobileOrTablet && !screen.isTabletLarge) {
      return Column(
        children: List.generate(skillModels.length, (i) {
          final item = skillModels[i];
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSizes.cardGridSpacing),
            child: SkillCard(
              category: item['title'],
              skills: item['skills'],
              onTap: () {
                // FIXED: Use named parameter
                AnalyticsService.to.logUserAction(
                  'skill_category_click',
                  properties: {
                    'category': item['title'],
                  },
                );
              },
            ),
          );
        }),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(skillModels.length, (i) {
        final item = skillModels[i];
        final isHovered = _hoveredIndex == i;
        final isDefocused = _hoveredIndex != -1 && !isHovered;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: i < skillModels.length - 1 ? AppSizes.cardGridSpacing : 0,
            ),
            child: MouseRegion(
              onEnter: (_) => _onHover(i),
              onExit: (_) => _onExit(),
              child: Stack(
                children: [
                  SkillCard(
                    category: item['title'],
                    skills: item['skills'],
                    onTap: () {
                      // FIXED: Use named parameter
                      AnalyticsService.to.logUserAction(
                        'skill_category_click',
                        properties: {
                          'category': item['title'],
                        },
                      );
                    },
                  ),
                  if (isDefocused)
                    const _DefocusOverlay(),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

// Defocus Overlay
class _DefocusOverlay extends StatelessWidget {
  const _DefocusOverlay();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.radiusL),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: AnimatedContainer(
            duration: AppSizes.durationDefault,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.50),
              borderRadius: BorderRadius.circular(AppSizes.radiusL),
            ),
          ),
        ),
      ),
    );
  }
}

// SectionWrapper - Add this at the bottom if it doesn't exist elsewhere
class SectionWrapper extends StatelessWidget {
  final Widget child;
  final Color color;

  const SectionWrapper({
    super.key,
    required this.child,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);
    return Container(
      color: color,
      padding: EdgeInsets.symmetric(
        horizontal: screen.horizontalPadding,
        vertical: AppSizes.sectionPaddingVertical,
      ),
      child: child,
    );
  }
}
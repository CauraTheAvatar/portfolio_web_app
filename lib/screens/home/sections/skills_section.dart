import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_web_app/core/constants/app_sizes.dart';
import 'package:portfolio_web_app/core/constants/app_strings.dart';
import 'package:portfolio_web_app/core/responsive/responsive.dart';
import 'package:portfolio_web_app/core/theme/app_colors.dart';
import 'package:portfolio_web_app/core/theme/app_textstyle.dart';
import 'package:portfolio_web_app/screens/home/sections/section_container.dart';
import 'package:portfolio_web_app/services/analytics_service.dart';
import 'package:portfolio_web_app/screens/widgets/cards/skill_card.dart';
import 'package:portfolio_web_app/models/skill_model.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      color: AppColors.white,
      addGradient: true,
      useStandardPadding: true,
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
        Text('PROFICIENT TECHSTACKS', style: AppTextStyle.overline),
        const SizedBox(height: AppSizes.sectionHeaderGapOverline),
        Text(
          'Skills', 
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
          'Technologies & Tools We Work With', 
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
  bool _isVisible = false;

  void _onHover(int index) {
    setState(() => _hoveredIndex = index);
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

    // Convert string-based skills to SkillModel objects with varied proficiencies
    final skillModels = categories.map((cat) {
      final skills = (cat['skills'] as List).asMap().entries.map((entry) {
        final index = entry.key;
        final skill = entry.value;
        int proficiency = 95;
        
        if (skill.toString().contains('Flutter') || skill.toString().contains('Dart')) {
          proficiency = 98;
        } else if (skill.toString().contains('Python') || skill.toString().contains('Data')) {
          proficiency = 90;
        } else if (skill.toString().contains('Figma') || skill.toString().contains('Design')) {
          proficiency = 92;
        } else if (skill.toString().contains('TypeScript') || skill.toString().contains('Angular')) {
          proficiency = 85;
        } else if (skill.toString().contains('WordPress')) {
          proficiency = 88;
        }
        
        return SkillModel(
          name: skill,
          category: cat['title'],
          proficiency: proficiency,
          keywords: [],
        );
      }).toList();
      return {
        'title': cat['title'],
        'skills': skills,
      };
    }).toList();

    return VisibilityDetector(
      key: const Key('skills_section_visibility'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !_isVisible) {
          setState(() {
            _isVisible = true;
          });
        }
      },
      child: Column(
        children: [
          if (screen.isMobileOrTablet && !screen.isTabletLarge)
            Column(
              children: List.generate(skillModels.length, (i) {
                final item = skillModels[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSizes.cardGridSpacing),
                  child: SkillCard(
                    category: item['title'],
                    skills: item['skills'],
                    isVisible: _isVisible,
                    onTap: () {
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
            )
          else
            Row(
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
                        fit: StackFit.passthrough, // ADDED: Ensures stack doesn't impose constraints
                        children: [
                          SkillCard(
                            category: item['title'],
                            skills: item['skills'],
                            isVisible: _isVisible,
                            onTap: () {
                              AnalyticsService.to.logUserAction(
                                'skill_category_click',
                                properties: {
                                  'category': item['title'],
                                },
                              );
                            },
                          ),
                          if (isDefocused)
                            const _DefocusOverlay(), // RE-ENABLED with fixed implementation
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
        ],
      ),
    );
  }
}

// FIXED Defocus Overlay - Now properly constrained
class _DefocusOverlay extends StatelessWidget {
  const _DefocusOverlay();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusL),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.radiusL),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            color: Colors.white.withOpacity(0.45),
          ),
        ),
      ),
    );
  }
}
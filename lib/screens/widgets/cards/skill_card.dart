import 'package:flutter/material.dart';
import 'package:portfolio_web_app/core/constants/app_sizes.dart';
import 'package:portfolio_web_app/core/theme/app_colors.dart';
import 'package:portfolio_web_app/core/theme/app_textstyle.dart';
import 'package:portfolio_web_app/models/skill_model.dart';

class SkillCard extends StatefulWidget {
  final String category;
  final List<SkillModel> skills;
  final VoidCallback? onTap;

  const SkillCard({
    super.key,
    required this.category,
    required this.skills,
    this.onTap,
  });

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: AppSizes.durationDefault,
        transform: Matrix4.identity()..scale(_hovered ? 1.02 : 1.0),
        child: Container(
          padding: const EdgeInsets.all(AppSizes.cardPadding),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppSizes.radiusL),
            border: Border.all(
              color: _hovered ? AppColors.gold : AppColors.gold.withOpacity(0.3),
              width: AppSizes.borderDefault,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.gold.withOpacity(0.2),
                      blurRadius: AppSizes.cardShadowBlurHover,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: AppSizes.cardShadowBlurRest,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _hovered
                          ? AppColors.gold.withOpacity(0.1)
                          : AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(AppSizes.radiusM),
                    ),
                    child: Icon(
                      _getIconForCategory(widget.category),
                      color: _hovered ? AppColors.gold : AppColors.grey,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.category,
                      style: AppTextStyle.cardTitle.copyWith(
                        color: _hovered ? AppColors.gold : AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Skills list
              ...widget.skills.map((skill) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildSkillRow(skill),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillRow(SkillModel skill) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              skill.name,
              style: AppTextStyle.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            if (skill.proficiency > 0)
              Text(
                '${skill.proficiency}%',
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.gold,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: LinearProgressIndicator(
            value: skill.proficiency / 100,
            backgroundColor: AppColors.lightGrey,
            valueColor: AlwaysStoppedAnimation<Color>(
              _hovered ? AppColors.gold : AppColors.grey,
            ),
            minHeight: 4,
          ),
        ),
        if (skill.keywords != null && skill.keywords!.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: skill.keywords!.map((keyword) => Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                keyword,
                style: AppTextStyle.bodySmall.copyWith(
                  fontSize: 10,
                ),
              ),
            )).toList(),
          ),
        ],
      ],
    );
  }

  IconData _getIconForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'software engineering':
        return Icons.code_rounded;
      case 'data science':
        return Icons.analytics_rounded;
      case 'ui/ux design':
        return Icons.design_services_rounded;
      case 'graphic design':
        return Icons.brush_rounded;
      default:
        return Icons.star_rounded;
    }
  }
}
import 'package:flutter/material.dart';
import 'package:portfolio_web_app/core/constants/app_sizes.dart';
import 'package:portfolio_web_app/core/theme/app_colors.dart';
import 'package:portfolio_web_app/core/theme/app_textstyle.dart';
import 'package:portfolio_web_app/models/skill_model.dart';

class SkillCard extends StatefulWidget {
  final String category;
  final List<SkillModel> skills;
  final VoidCallback? onTap;
  final bool isVisible; // ADDED

  const SkillCard({
    super.key,
    required this.category,
    required this.skills,
    this.onTap,
    this.isVisible = false, // ADDED with default false
  });

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late AnimationController _controller;
  late List<Animation<double>> _barAnimations;
  late List<Animation<double>> _counterAnimations;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500), // Smooth 1.5 second animation
    );
    
    // Create animations for each skill
    _barAnimations = [];
    _counterAnimations = [];
    
    for (var skill in widget.skills) {
      final barAnimation = Tween<double>(
        begin: 0.0,
        end: skill.proficiency / 100.0,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ));
      
      final counterAnimation = Tween<double>(
        begin: 0.0,
        end: skill.proficiency.toDouble(),
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ));
      
      _barAnimations.add(barAnimation);
      _counterAnimations.add(counterAnimation);
    }
  }

  @override
  void didUpdateWidget(SkillCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Trigger animation when section becomes visible
    if (widget.isVisible && !_hasAnimated) {
      _controller.forward();
      _hasAnimated = true;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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

              // Skills list with animated bars and counters
              ...List.generate(widget.skills.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      final skill = widget.skills[index];
                      final barValue = index < _barAnimations.length 
                          ? _barAnimations[index].value 
                          : 0.0;
                      final counterValue = index < _counterAnimations.length
                          ? _counterAnimations[index].value.toInt()
                          : 0;
                      
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
                              TweenAnimationBuilder<double>(
                                tween: Tween<double>(
                                  begin: 0,
                                  end: _hasAnimated ? skill.proficiency.toDouble() : 0,
                                ),
                                duration: const Duration(milliseconds: 1500),
                                curve: Curves.easeOutCubic,
                                builder: (context, value, child) {
                                  return Text(
                                    '${value.toInt()}%',
                                    style: AppTextStyle.bodySmall.copyWith(
                                      color: AppColors.gold,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: LinearProgressIndicator(
                              value: barValue,
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
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'software engineering':
        return Icons.code_rounded;
      case 'data science & analytics':
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
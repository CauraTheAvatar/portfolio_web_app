import 'package:flutter/material.dart';
import 'package:portfolio_web_app/core/constants/app_sizes.dart';
import 'package:portfolio_web_app/core/constants/app_strings.dart';
import 'package:portfolio_web_app/core/responsive/responsive.dart';
import 'package:portfolio_web_app/core/theme/app_colors.dart';
import 'package:portfolio_web_app/core/theme/app_textstyle.dart';
import 'package:portfolio_web_app/services/analytics_service.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const _SectionHeader(),
          const SizedBox(height: AppSizes.sectionHeaderGapContent),
          const _ExperienceTimeline(),
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
        Text(
          'WORK JOURNEY',
          style: AppTextStyle.overline,
        ),
        const SizedBox(height: AppSizes.sectionHeaderGapOverline),
        Text(
          'Experience',
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
          'My professional journey and the roles that shaped my career.',
          style: AppTextStyle.sectionSubtitle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// Experience Timeline
class _ExperienceTimeline extends StatelessWidget {
  const _ExperienceTimeline();

  static const List<ExperienceItem> _experiences = [
    ExperienceItem(
      company: 'Tech Innovators Inc.',
      position: 'Senior Flutter Developer',
      period: '2024 - Present',
      description: 'Lead mobile app development for multiple client projects. '
          'Architecting scalable solutions using Flutter and Firebase. '
          'Mentoring junior developers and conducting code reviews.',
      technologies: ['Flutter', 'Firebase', 'GetX', 'REST APIs'],
      isCurrent: true,
    ),
    ExperienceItem(
      company: 'Digital Solutions Ltd.',
      position: 'Full Stack Developer',
      period: '2022 - 2024',
      description: 'Developed and maintained web and mobile applications. '
          'Collaborated with design team to implement responsive UIs. '
          'Optimized app performance and reduced load times by 40%.',
      technologies: ['Flutter', 'Node.js', 'PostgreSQL', 'AWS'],
      isCurrent: false,
    ),
    ExperienceItem(
      company: 'Data Analytics Startup',
      position: 'Data Analyst / Developer',
      period: '2021 - 2022',
      description: 'Built data visualization dashboards using Tableau. '
          'Developed ETL pipelines for data processing. '
          'Created Python scripts for automated reporting.',
      technologies: ['Python', 'Tableau', 'SQL', 'Pandas'],
      isCurrent: false,
    ),
    ExperienceItem(
      company: 'Freelance',
      position: 'UI/UX Designer & Developer',
      period: '2020 - 2021',
      description: 'Designed and developed websites for small businesses. '
          'Created brand identities and marketing materials. '
          'Managed client relationships from concept to delivery.',
      technologies: ['Figma', 'WordPress', 'HTML/CSS', 'Canva'],
      isCurrent: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        if (screen.isMobile) {
          return _MobileTimeline(experiences: _experiences);
        }
        return _DesktopTimeline(experiences: _experiences);
      },
    );
  }
}

// Mobile Timeline (vertical list)
class _MobileTimeline extends StatelessWidget {
  const _MobileTimeline({required this.experiences});

  final List<ExperienceItem> experiences;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: experiences.asMap().entries.map((entry) {
        final index = entry.key;
        final exp = entry.value;
        return Column(
          children: [
            _ExperienceCard(
              experience: exp,
              index: index,
              isLast: index == experiences.length - 1,
            ),
            if (index < experiences.length - 1)
              Container(
                width: 2,
                height: 40,
                color: AppColors.gold.withOpacity(0.3),
              ),
          ],
        );
      }).toList(),
    );
  }
}

// Desktop Timeline (alternating left/right)
class _DesktopTimeline extends StatelessWidget {
  const _DesktopTimeline({required this.experiences});

  final List<ExperienceItem> experiences;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: experiences.asMap().entries.map((entry) {
        final index = entry.key;
        final exp = entry.value;
        final isEven = index % 2 == 0;

        return Padding(
          padding: const EdgeInsets.only(bottom: AppSizes.space5XL),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isEven) ...[
                Expanded(
                  child: _ExperienceCard(
                    experience: exp,
                    index: index,
                    isDesktop: true,
                  ),
                ),
                const SizedBox(width: AppSizes.space4XL),
                _TimelineDot(index: index),
                const SizedBox(width: AppSizes.space4XL),
                const Expanded(child: SizedBox()), // Empty space for balance
              ] else ...[
                const Expanded(child: SizedBox()), // Empty space for balance
                const SizedBox(width: AppSizes.space4XL),
                _TimelineDot(index: index),
                const SizedBox(width: AppSizes.space4XL),
                Expanded(
                  child: _ExperienceCard(
                    experience: exp,
                    index: index,
                    isDesktop: true,
                  ),
                ),
              ],
            ],
          ),
        );
      }).toList(),
    );
  }
}

// Timeline Dot
class _TimelineDot extends StatelessWidget {
  const _TimelineDot({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: AppColors.gold,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.white,
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.gold.withOpacity(0.3),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
        ),
        if (index < 3) // Don't add line after last item
          Container(
            width: 2,
            height: 100,
            color: AppColors.gold.withOpacity(0.3),
          ),
      ],
    );
  }
}

// Experience Card
class _ExperienceCard extends StatefulWidget {
  const _ExperienceCard({
    required this.experience,
    required this.index,
    this.isLast = false,
    this.isDesktop = false,
  });

  final ExperienceItem experience;
  final int index;
  final bool isLast;
  final bool isDesktop;

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: AppSizes.durationDefault,
    );
    _scale = Tween<double>(begin: 1.0, end: 1.02)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _hovered = true);
        _ctrl.forward();
        AnalyticsService.to.logUserAction(
          'experience_hover',
          properties: {
            'company': widget.experience.company,
            'position': widget.experience.position,
          },
        );
      },
      onExit: (_) {
        setState(() => _hovered = false);
        _ctrl.reverse();
      },
      child: ScaleTransition(
        scale: _scale,
        child: AnimatedContainer(
          duration: AppSizes.durationDefault,
          padding: const EdgeInsets.all(AppSizes.cardPadding),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppSizes.radiusL),
            border: Border.all(
              color: _hovered
                  ? AppColors.gold
                  : AppColors.gold.withOpacity(0.3),
              width: AppSizes.borderDefault,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.gold.withOpacity(0.15),
                      blurRadius: AppSizes.cardShadowBlurHover,
                      offset: const Offset(0, 8),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: AppSizes.cardShadowBlurDepth,
                      offset: const Offset(0, 4),
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
              // Company and Period
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.experience.company,
                      style: AppTextStyle.cardTitle.copyWith(
                        color: _hovered ? AppColors.gold : AppColors.black,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.spaceM,
                      vertical: AppSizes.spaceXS,
                    ),
                    decoration: BoxDecoration(
                      color: _hovered
                          ? AppColors.gold.withOpacity(0.1)
                          : AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.experience.period,
                      style: AppTextStyle.bodySmall.copyWith(
                        color: _hovered ? AppColors.gold : AppColors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSizes.spaceXS),

              // Position
              Text(
                widget.experience.position,
                style: AppTextStyle.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                  color: _hovered ? AppColors.gold : AppColors.grey,
                ),
              ),

              const SizedBox(height: AppSizes.spaceM),

              // Gold Divider
              Container(
                width: 40,
                height: 2,
                decoration: BoxDecoration(
                  color: AppColors.gold.withOpacity(_hovered ? 1 : 0.5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              const SizedBox(height: AppSizes.spaceM),

              // Description
              Text(
                widget.experience.description,
                style: AppTextStyle.bodyMedium,
              ),

              const SizedBox(height: AppSizes.spaceL),

              // Technologies
              Wrap(
                spacing: AppSizes.spaceS,
                runSpacing: AppSizes.spaceS,
                children: widget.experience.technologies.map((tech) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.spaceM,
                      vertical: AppSizes.spaceXS,
                    ),
                    decoration: BoxDecoration(
                      color: _hovered
                          ? AppColors.gold.withOpacity(0.1)
                          : AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      tech,
                      style: AppTextStyle.chip.copyWith(
                        color: _hovered ? AppColors.gold : AppColors.grey,
                      ),
                    ),
                  );
                }).toList(),
              ),

              if (widget.experience.isCurrent) ...[
                const SizedBox(height: AppSizes.spaceM),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.spaceM,
                    vertical: AppSizes.spaceXS,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.gold.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.gold,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: AppSizes.spaceXS),
                      Text(
                        'Current Position',
                        style: AppTextStyle.bodySmall.copyWith(
                          color: AppColors.gold,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// Experience Item Data Model
class ExperienceItem {
  final String company;
  final String position;
  final String period;
  final String description;
  final List<String> technologies;
  final bool isCurrent;

  const ExperienceItem({
    required this.company,
    required this.position,
    required this.period,
    required this.description,
    required this.technologies,
    this.isCurrent = false,
  });
}

// Section Wrapper
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
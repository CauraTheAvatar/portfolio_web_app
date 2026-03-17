import 'package:flutter/material.dart';
import 'package:portfolio_web_app/core/constants/app_sizes.dart';
import 'package:portfolio_web_app/core/constants/app_strings.dart';
import 'package:portfolio_web_app/core/responsive/responsive.dart';
import 'package:portfolio_web_app/core/theme/app_colors.dart';
import 'package:portfolio_web_app/core/theme/app_textstyle.dart';
import 'package:portfolio_web_app/services/analytics_service.dart';
import 'package:portfolio_web_app/screens/home/sections/section_container.dart';

class CollaborationsSection extends StatelessWidget {
  const CollaborationsSection({super.key});

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
          const _CollaborationsTimeline(),
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
          'COLLABORATIONS',
          style: AppTextStyle.overline,
        ),
        const SizedBox(height: AppSizes.sectionHeaderGapOverline),
        Text(
          'Collaborations',
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
          'Companies and organizations we\'ve collaborated with to build technological solutions.',
          style: AppTextStyle.sectionSubtitle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// Collaborations Timeline
class _CollaborationsTimeline extends StatelessWidget {
  const _CollaborationsTimeline();

  static const List<CollaborationItem> _collaborations = [
    CollaborationItem(
      company: 'Hope Home Base Healthcare',
      logoPath: 'logos/hope_home.png',
      projectName: 'Healthcare Information & Outreach Website',
      period: '2026 - Present',
      description: 'Building a comprehensive website to educate the public on healthcare services and provide information for caring for chronically ill patients. The site serves as the first point of contact for potential clients, featuring educational resources and a contact form. Hope Home Base is an NGO dedicated to caring for chronically ill and bedridden patients who have no one else to care for them.',
      technologies: ['Flutter Web', 'Firebase', 'Contact Form Integration'],
      isCurrent: true,
    ),
    CollaborationItem(
      company: 'Abba Selah Collectives',
      logoPath: 'assets/images/graphic/logos/Abba_Selah_Logo.jpg',
      projectName: 'Automated Quotation Generation System',
      period: '2026',
      description: 'Developed an automated custom quotation generation engine using JavaScript and Google Apps Script. The system links Google Form responses to a custom Google Doc template, automatically computes item sums by category, generates PDF quotations within 30 seconds, and emails them to clients. Quotes are logged and both business owners receive copies to stay informed.',
      technologies: ['JavaScript', 'Google Apps Script', 'Google Forms', 'Google Docs API'],
      isCurrent: false,
    ),
    CollaborationItem(
      company: 'Cao Cao Investment CC',
      logoPath: 'assets/images/graphic/logos/Cao_Cao_Investment_Logo.jpg',
      projectName: 'Minimalist Corporate Website',
      period: '2025',
      description: 'Collaborated with their small tech team to build a WordPress website for this SME. Created a minimalistic design as per client preference. The website serves as the first point of contact for potential clients, providing essential information about their investment services.',
      technologies: ['WordPress', 'PHP', 'Custom Theme', 'Elementor'],
      isCurrent: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        if (screen.isMobile) {
          return _MobileTimeline(collaborations: _collaborations);
        }
        return _DesktopTimeline(collaborations: _collaborations);
      },
    );
  }
}

// Mobile Timeline (vertical list)
class _MobileTimeline extends StatelessWidget {
  const _MobileTimeline({required this.collaborations});

  final List<CollaborationItem> collaborations;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: collaborations.asMap().entries.map((entry) {
        final index = entry.key;
        final collab = entry.value;
        return Column(
          children: [
            _CollaborationCard(
              collaboration: collab,
              index: index,
              isLast: index == collaborations.length - 1,
            ),
            if (index < collaborations.length - 1)
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
  const _DesktopTimeline({required this.collaborations});

  final List<CollaborationItem> collaborations;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: collaborations.asMap().entries.map((entry) {
        final index = entry.key;
        final collab = entry.value;
        final isEven = index % 2 == 0;

        return Padding(
          padding: const EdgeInsets.only(bottom: AppSizes.space5XL),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isEven) ...[
                Expanded(
                  child: _CollaborationCard(
                    collaboration: collab,
                    index: index,
                    isDesktop: true,
                  ),
                ),
                const SizedBox(width: AppSizes.space4XL),
                _TimelineDot(index: index),
                const SizedBox(width: AppSizes.space4XL),
                const Expanded(child: SizedBox()),
              ] else ...[
                const Expanded(child: SizedBox()),
                const SizedBox(width: AppSizes.space4XL),
                _TimelineDot(index: index),
                const SizedBox(width: AppSizes.space4XL),
                Expanded(
                  child: _CollaborationCard(
                    collaboration: collab,
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
        if (index < 2)
          Container(
            width: 2,
            height: 100,
            color: AppColors.gold.withOpacity(0.3),
          ),
      ],
    );
  }
}

// Collaboration Card - FIXED with responsive mobile layout
class _CollaborationCard extends StatefulWidget {
  const _CollaborationCard({
    required this.collaboration,
    required this.index,
    this.isLast = false,
    this.isDesktop = false,
  });

  final CollaborationItem collaboration;
  final int index;
  final bool isLast;
  final bool isDesktop;

  @override
  State<_CollaborationCard> createState() => _CollaborationCardState();
}

class _CollaborationCardState extends State<_CollaborationCard>
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
    final screen = Responsive.of(context);
    
    return MouseRegion(
      onEnter: (_) {
        setState(() => _hovered = true);
        _ctrl.forward();
        AnalyticsService.to.logUserAction(
          'collaboration_hover',
          properties: {
            'company': widget.collaboration.company,
            'project': widget.collaboration.projectName,
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
          child: screen.isMobile
              ? _buildMobileLayout()
              : _buildDesktopLayout(),
        ),
      ),
    );
  }

  // Desktop layout - Original layout
  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left side - Content (70% width)
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Company and Period
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.collaboration.company,
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
                      widget.collaboration.period,
                      style: AppTextStyle.bodySmall.copyWith(
                        color: _hovered ? AppColors.gold : AppColors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSizes.spaceXS),

              // Project Name
              Text(
                widget.collaboration.projectName,
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
                widget.collaboration.description,
                style: AppTextStyle.bodyMedium,
              ),

              const SizedBox(height: AppSizes.spaceL),

              // Technologies
              Wrap(
                spacing: AppSizes.spaceS,
                runSpacing: AppSizes.spaceS,
                children: widget.collaboration.technologies.map((tech) {
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

              if (widget.collaboration.isCurrent) ...[
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
                        'Active Collaboration',
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

        const SizedBox(width: AppSizes.spaceL),

        // Right side - Logo (30% width)
        Expanded(
          flex: 3,
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              color: _hovered
                  ? AppColors.gold.withOpacity(0.05)
                  : AppColors.lightGrey,
              borderRadius: BorderRadius.circular(AppSizes.radiusM),
              border: Border.all(
                color: _hovered
                    ? AppColors.gold.withOpacity(0.3)
                    : Colors.transparent,
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.radiusM),
              child: _buildLogo(),
            ),
          ),
        ),
      ],
    );
  }

  // Mobile layout - Stacked vertically for better readability
  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Company and Period
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.collaboration.company,
                style: AppTextStyle.cardTitle.copyWith(
                  color: _hovered ? AppColors.gold : AppColors.black,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: _hovered
                    ? AppColors.gold.withOpacity(0.1)
                    : AppColors.lightGrey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                widget.collaboration.period,
                style: AppTextStyle.bodySmall.copyWith(
                  color: _hovered ? AppColors.gold : AppColors.grey,
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 12),
        
        // Logo on mobile (top)
        Container(
          height: 100,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.gold.withOpacity(0.05)
                : AppColors.lightGrey,
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
            border: Border.all(
              color: _hovered
                  ? AppColors.gold.withOpacity(0.3)
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
            child: _buildLogo(),
          ),
        ),
        
        const SizedBox(height: 8),
        
        // Project Name
        Text(
          widget.collaboration.projectName,
          style: AppTextStyle.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
            color: _hovered ? AppColors.gold : AppColors.grey,
            fontSize: 14,
          ),
        ),
        
        const SizedBox(height: 8),
        
        // Gold Divider
        Container(
          width: 40,
          height: 2,
          decoration: BoxDecoration(
            color: AppColors.gold.withOpacity(_hovered ? 1 : 0.5),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        
        const SizedBox(height: 12),
        
        // Description
        Text(
          widget.collaboration.description,
          style: AppTextStyle.bodyMedium.copyWith(
            fontSize: 13,
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Technologies
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.collaboration.technologies.map((tech) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
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
                  fontSize: 11,
                ),
              ),
            );
          }).toList(),
        ),
        
        if (widget.collaboration.isCurrent) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: AppColors.gold.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.gold,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Active Collaboration',
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.gold,
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildLogo() {
    return Center(
      child: widget.collaboration.logoPath.isNotEmpty
          ? Image.asset(
              widget.collaboration.logoPath,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => _buildInitialsPlaceholder(),
            )
          : _buildInitialsPlaceholder(),
    );
  }

  Widget _buildInitialsPlaceholder() {
    final initials = widget.collaboration.company
        .split(' ')
        .where((word) => word.isNotEmpty)
        .map((word) => word[0])
        .take(2)
        .join('')
        .toUpperCase();

    return Container(
      color: _hovered
          ? AppColors.gold.withOpacity(0.1)
          : AppColors.lightGrey,
      child: Center(
        child: Text(
          initials,
          style: AppTextStyle.cardTitle.copyWith(
            fontSize: 32,
            color: _hovered ? AppColors.gold : AppColors.grey,
          ),
        ),
      ),
    );
  }
}

// Collaboration Item Data Model
class CollaborationItem {
  final String company;
  final String logoPath;
  final String projectName;
  final String period;
  final String description;
  final List<String> technologies;
  final bool isCurrent;

  const CollaborationItem({
    required this.company,
    required this.logoPath,
    required this.projectName,
    required this.period,
    required this.description,
    required this.technologies,
    this.isCurrent = false,
  });
}
import 'package:flutter/material.dart';
import 'package:portfolio_web_app/core/constants/app_sizes.dart';
import 'package:portfolio_web_app/core/constants/app_strings.dart';
import 'package:portfolio_web_app/core/responsive/responsive.dart';

class FooterSection extends StatelessWidget {

  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);

    return Container(
      width:      double.infinity,
      color:      AppColors.black,
      padding: EdgeInsets.symmetric(
        horizontal: screen.horizontalPadding,
        vertical:   AppSizes.space6XL,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          // Gold rule 
          Container(
            width:  AppSizes.goldRuleWidth * 1.5,
            height: AppSizes.borderDefault,
            decoration: BoxDecoration(
              color:        AppColors.gold,
              borderRadius: BorderRadius.circular(AppSizes.radiusXXL),
            ),
          ),

          const SizedBox(height: AppSizes.space4XL),

          // Tagline 
          Text(
            AppStrings.footerTagline,
            textAlign: TextAlign.center,
            style: AppTextStyle.bodyMedium.copyWith(
              color:       AppColors.white.withOpacity(0.75),
              fontStyle:   FontStyle.italic,
              letterSpacing: 0.2,
            ),
          ),

          const SizedBox(height: AppSizes.spaceXXL),

          // Site navigation hint 
          Text(
            AppStrings.footerNav,
            textAlign: TextAlign.center,
            style: AppTextStyle.overline.copyWith(
              color:       AppColors.gold.withOpacity(0.60),
              fontSize:    10,
              letterSpacing: 1.8,
            ),
          ),

          const SizedBox(height: AppSizes.space4XL),

          // Thin divider 
          Container(
            width:  double.infinity,
            height: AppSizes.borderThin,
            color:  AppColors.white.withOpacity(0.08),
          ),

          const SizedBox(height: AppSizes.spaceXXL),

          // Copyright 
          Text(
            AppStrings.footerCopyright,
            textAlign: TextAlign.center,
            style: AppTextStyle.bodySmall.copyWith(
              color:       AppColors.white.withOpacity(0.40),
              letterSpacing: 0.3,
            ),
          ),

        ],
      ),
    );
  }
}
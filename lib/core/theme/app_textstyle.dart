import 'package:flutter/material.dart';
import 'package:portfolio_web_app/core/theme/app_colors.dart';

// Font families:
//   PlayfairDisplay → name / display / section titles
//   Montserrat      → body / UI / labels / buttons

class AppTextStyle {
  AppTextStyle._();

  // Display — Playfair Display 

  // Hero: developer name. Gold + italic + large.
  static const TextStyle developerName = TextStyle(
    fontFamily: 'PlayfairDisplay',
    fontSize: 58,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
    color: AppColors.gold,
    letterSpacing: 1.2,
    height: 1.1,
  );

  // Hero: role / tagline beneath the name.
  static const TextStyle heroTagline = TextStyle(
    fontFamily: 'PlayfairDisplay',
    fontSize: 26,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
    color: AppColors.black,
    letterSpacing: 0.4,
    height: 1.35,
  );

  // Section headings (Projects, Skills, About, Contact).
  static const TextStyle sectionTitle = TextStyle(
    fontFamily: 'PlayfairDisplay',
    fontSize: 38,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
    letterSpacing: 0.5,
    height: 1.2,
  );

  // Card / item title inside project cards, skill groups, etc.
  static const TextStyle cardTitle = TextStyle(
    fontFamily: 'PlayfairDisplay',
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
    letterSpacing: 0.2,
    height: 1.25,
  );

  // Body — Montserrat 

  // Section subtitle / intro line beneath a section title.
  static const TextStyle sectionSubtitle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
    letterSpacing: 0.3,
    height: 1.6,
  );

  // Standard readable body copy (about bio, project descriptions).
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
    letterSpacing: 0.2,
    height: 1.75,
  );

  // Secondary body copy — card descriptions, captions.
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
    letterSpacing: 0.15,
    height: 1.65,
  );

  // Fine print — dates, metadata, footnotes.
  static const TextStyle bodySmall = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
    letterSpacing: 0.1,
    height: 1.5,
  );

  // UI Elements — Montserrat 

  // Navbar link — default state.
  static const TextStyle navItem = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
    letterSpacing: 0.3,
  );

  // Navbar link — active / hover state (applied programmatically).
  static const TextStyle navItemActive = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.gold,
    letterSpacing: 0.3,
  );

  // Primary CTA button label (white on black button).
  static const TextStyle buttonPrimary = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    letterSpacing: 1.1,
  );

  // Secondary / ghost button label (black text, outlined button).
  static const TextStyle buttonSecondary = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
    letterSpacing: 1.1,
  );

  // ALL-CAPS overline above a section title or card group.
  static const TextStyle overline = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.gold,
    letterSpacing: 2.5,
    height: 1.4,
  );

  // Skill chip / tag label inside a chip widget.
  static const TextStyle chip = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.gold,
    letterSpacing: 0.5,
  );

  // Form field input text.
  static const TextStyle inputText = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
    letterSpacing: 0.2,
    height: 1.5,
  );

  // Form field hint / placeholder text.
  static const TextStyle inputHint = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
    letterSpacing: 0.2,
    height: 1.5,
  );

  // Inline hyperlink or mailto text.
  static const TextStyle link = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.gold,
    letterSpacing: 0.2,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.gold,
  );

  // Helpers 

  // Returns [developerName] with a custom font size — for responsive scaling.
  static TextStyle developerNameScaled(double fontSize) =>
      developerName.copyWith(fontSize: fontSize);

  // Returns [sectionTitle] with a custom font size — for responsive scaling.
  static TextStyle sectionTitleScaled(double fontSize) =>
      sectionTitle.copyWith(fontSize: fontSize);

  // Returns any style with an overridden colour — avoids scattered copyWith calls.
  static TextStyle withColor(TextStyle base, Color color) =>
      base.copyWith(color: color);
}
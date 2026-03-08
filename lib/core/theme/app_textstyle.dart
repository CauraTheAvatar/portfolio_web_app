import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_web_app/core/theme/app_colors.dart';

// Font families via Google Fonts:
//   Playfair Display → name / display / section titles
//   Montserrat      → body / UI / labels / buttons

class AppTextStyle {
  AppTextStyle._();

  // Playfair Display (serif) — for names, titles, display text
  static TextStyle get _playfair => GoogleFonts.playfairDisplay();
  
  // Montserrat (sans-serif) — for body text, navigation, UI elements
  static TextStyle get _montserrat => GoogleFonts.montserrat();

  // DISPLAY — PLAYFAIR DISPLAY

  // Hero: developer name. Gold + italic + large.
  static TextStyle get developerName => _playfair.copyWith(
    fontSize: 58,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
    color: AppColors.gold,
    letterSpacing: 1.2,
    height: 1.1,
  );

  // Hero: role / tagline beneath the name.
  static TextStyle get heroTagline => _playfair.copyWith(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
    color: AppColors.black,
    letterSpacing: 0.4,
    height: 1.35,
  );

  // Section headings (Projects, Skills, About, Contact).
  static TextStyle get sectionTitle => _playfair.copyWith(
    fontSize: 38,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
    letterSpacing: 0.5,
    height: 1.2,
  );

  // Card / item title inside project cards, skill groups, etc.
  static TextStyle get cardTitle => _playfair.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
    letterSpacing: 0.2,
    height: 1.25,
  );

  // BODY — MONTSERRAT

  // Section subtitle / intro line beneath a section title.
  static TextStyle get sectionSubtitle => _montserrat.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
    letterSpacing: 0.3,
    height: 1.6,
  );

  // Standard readable body copy (about bio, project descriptions).
  static TextStyle get bodyLarge => _montserrat.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
    letterSpacing: 0.2,
    height: 1.75,
  );

  // Secondary body copy — card descriptions, captions.
  static TextStyle get bodyMedium => _montserrat.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
    letterSpacing: 0.15,
    height: 1.65,
  );

  // Fine print — dates, metadata, footnotes.
  static TextStyle get bodySmall => _montserrat.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
    letterSpacing: 0.1,
    height: 1.5,
  );

  // UI ELEMENTS — MONTSERRAT

  // Navbar logo / brand name
  static TextStyle get navbarLogo => _playfair.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
    letterSpacing: -0.5,
  );

  // Navbar link — default state.
  static TextStyle get navItem => _montserrat.copyWith(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
    letterSpacing: 0.3,
  );

  // Navbar link — active / hover state
  static TextStyle get navItemActive => _montserrat.copyWith(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.gold,
    letterSpacing: 0.3,
  );

  // Primary CTA button label (white on black button).
  static TextStyle get buttonPrimary => _montserrat.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    letterSpacing: 1.1,
  );

  // Secondary / ghost button label (black text, outlined button).
  static TextStyle get buttonSecondary => _montserrat.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
    letterSpacing: 1.1,
  );

  // ALL-CAPS overline above a section title or card group.
  static TextStyle get overline => _montserrat.copyWith(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.gold,
    letterSpacing: 2.5,
    height: 1.4,
  );

  // Skill chip / tag label inside a chip widget.
  static TextStyle get chip => _montserrat.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.gold,
    letterSpacing: 0.5,
  );

  // Form field input text.
  static TextStyle get inputText => _montserrat.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
    letterSpacing: 0.2,
    height: 1.5,
  );

  // Form field hint / placeholder text.
  static TextStyle get inputHint => _montserrat.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
    letterSpacing: 0.2,
    height: 1.5,
  );

  // Inline hyperlink or mailto text.
  static TextStyle get link => _montserrat.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.gold,
    letterSpacing: 0.2,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.gold,
  );

  // HELPERS

  // Returns [developerName] with a custom font size 
  static TextStyle developerNameScaled(double fontSize) =>
      developerName.copyWith(fontSize: fontSize);

  // Returns [sectionTitle] with a custom font size 
  static TextStyle sectionTitleScaled(double fontSize) =>
      sectionTitle.copyWith(fontSize: fontSize);

  // Returns any style with an overridden colour 
  static TextStyle withColor(TextStyle base, Color color) =>
      base.copyWith(color: color);
}
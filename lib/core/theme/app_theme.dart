import 'package:flutter/material.dart';
import 'package:portfolio_web_app/core/theme/app_colors.dart';
import 'package:portfolio_web_app/core/theme/app_textstyle.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,

        // Colour scheme
        colorScheme: const ColorScheme.light(
          primary: AppColors.gold,
          onPrimary: AppColors.white,
          secondary: AppColors.black,
          onSecondary: AppColors.white,
          surface: AppColors.white,
          onSurface: AppColors.black,
          error: Color(0xFFB00020),
          onError: AppColors.white,
        ),

        scaffoldBackgroundColor: AppColors.white,
        canvasColor: AppColors.white,

        // Typography 
        fontFamily: 'Montserrat',
        textTheme: const TextTheme(
          // Display — Playfair Display
          displayLarge:  AppTextStyle.developerName,
          displayMedium: AppTextStyle.heroTagline,
          displaySmall:  AppTextStyle.sectionTitle,

          // Headlines — Playfair Display
          headlineLarge:  AppTextStyle.sectionTitle,
          headlineMedium: AppTextStyle.cardTitle,
          headlineSmall:  AppTextStyle.cardTitle,

          // Body — Montserrat
          bodyLarge:   AppTextStyle.bodyLarge,
          bodyMedium:  AppTextStyle.bodyMedium,
          bodySmall:   AppTextStyle.bodySmall,

          // Labels — Montserrat
          labelLarge:  AppTextStyle.buttonPrimary,
          labelMedium: AppTextStyle.chip,
          labelSmall:  AppTextStyle.overline,

          // Title slots (used by AppBar, Card headers, etc.)
          titleLarge:  AppTextStyle.cardTitle,
          titleMedium: AppTextStyle.navItem,
          titleSmall:  AppTextStyle.bodyMedium,
        ),

        // AppBar 
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.black,
          elevation: 0,
          scrolledUnderElevation: 2,
          shadowColor: AppColors.lightGrey,
          titleTextStyle: AppTextStyle.cardTitle,
          centerTitle: false,
          surfaceTintColor: Colors.transparent,
        ),

        // Elevated Button (primary — black bg, white text) 
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.black,
            foregroundColor: AppColors.white,
            textStyle: AppTextStyle.buttonPrimary,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ).copyWith(
            // Hover: lift + gold tint
            elevation: WidgetStateProperty.resolveWith(
              (states) => states.contains(WidgetState.hovered) ? 4 : 0,
            ),
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.hovered)) return AppColors.gold;
              return AppColors.black;
            }),
          ),
        ),

        // Outlined Button (secondary — white bg, black border) 
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.black,
            textStyle: AppTextStyle.buttonSecondary,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            side: const BorderSide(color: AppColors.black, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ).copyWith(
            side: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.hovered)) {
                return const BorderSide(color: AppColors.gold, width: 1.5);
              }
              return const BorderSide(color: AppColors.black, width: 1.5);
            }),
            foregroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.hovered)) return AppColors.gold;
              return AppColors.black;
            }),
          ),
        ),

        // Text Button 
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.gold,
            textStyle: AppTextStyle.link,
          ),
        ),

        // Card 
        cardTheme: CardTheme(
          color: AppColors.white,
          elevation: 4,
          shadowColor: AppColors.black.withOpacity(0.08),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: AppColors.gold, width: 1),
          ),
          margin: EdgeInsets.zero,
        ),

        // Input / TextField 
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.lightGrey,
          hintStyle: AppTextStyle.inputHint,
          labelStyle: AppTextStyle.inputText,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.lightGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.gold, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                const BorderSide(color: Color(0xFFB00020), width: 1.5),
          ),
        ),

        // Chip (skill tags) 
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.lightGrey,
          labelStyle: AppTextStyle.chip,
          side: const BorderSide(color: AppColors.gold, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        ),

        // Divider 
        dividerTheme: const DividerThemeData(
          color: AppColors.lightGrey,
          thickness: 1,
          space: 1,
        ),

        // Scrollbar 
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: WidgetStateProperty.all(AppColors.gold.withOpacity(0.5)),
          radius: const Radius.circular(4),
          thickness: WidgetStateProperty.all(4),
        ),

        // Tooltip 
        tooltipTheme: TooltipThemeData(
          decoration: BoxDecoration(
            color: AppColors.black,
            borderRadius: BorderRadius.circular(6),
          ),
          textStyle: AppTextStyle.bodySmall.copyWith(color: AppColors.white),
        ),
      );
}
class AppBreakpoints {
  AppBreakpoints._();

  // Width thresholds (px) 
  static const double mobileSmall  = 360;   // small phones (SE, Galaxy A)
  static const double mobile       = 480;   // standard phones
  static const double mobileLarge  = 600;   // large phones / small tablets
  static const double tablet       = 768;   // tablets portrait
  static const double tabletLarge  = 1024;  // tablets landscape / small laptops
  static const double desktop      = 1280;  // standard desktop
  static const double desktopLarge = 1440;  // wide desktop
  static const double desktopXL    = 1920;  // ultrawide / 4K

  // Max content widths 
  // Caps the readable content width so lines don't stretch too wide on 4K.
  static const double maxContentWidth        = 1200; // main page sections
  static const double maxCardGridWidth       = 1100; // project / skill card grids
  static const double maxTextWidth           = 720;  // prose blocks (About, Contact)
  static const double maxFormWidth           = 560;  // Contact form

  // Navbar 
  static const double navbarHeight           = 70;
  static const double navbarCollapseAt       = tablet; // hamburger below this

  // Section padding (horizontal) 
  static const double paddingMobile          = 20;
  static const double paddingTablet          = 40;
  static const double paddingDesktop         = 80;

  // Section min-heights (vh equivalent in logical px) 
  static const double sectionMinHeightMobile  = 500;
  static const double sectionMinHeightDesktop = 640;

  // Card grid column counts 
  // Used by Responsive.gridColumns() helper.
  static const int projectCardsMobile  = 1;
  static const int projectCardsTablet  = 2;
  static const int projectCardsDesktop = 3;

  static const int skillChipsMobile    = 2;
  static const int skillChipsTablet    = 3;
  static const int skillChipsDesktop   = 4;

  static const int galleryMobile       = 1;
  static const int galleryTablet       = 2;
  static const int galleryDesktop      = 3;

  // Project sub-screen card columns 
  static const int subProjectCardsMobile  = 1;
  static const int subProjectCardsTablet  = 2;
  static const int subProjectCardsDesktop = 3;

  // Typography scale multipliers 
  // Applied to AppTextStyle base sizes for smaller screens.
  static const double fontScaleMobile  = 0.82;
  static const double fontScaleTablet  = 0.92;
  static const double fontScaleDesktop = 1.00;
}
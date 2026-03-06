class AppSizes {
  AppSizes._();

  // Spacing — 4pt base grid 
  static const double spaceXXS  =  4;
  static const double spaceXS   =  6;
  static const double spaceS    =  8;
  static const double spaceM    = 12;
  static const double spaceL    = 16;
  static const double spaceXL   = 18;
  static const double spaceXXL  = 24;
  static const double space3XL  = 28;
  static const double space4XL  = 36;
  static const double space5XL  = 40;
  static const double space6XL  = 56;
  static const double space7XL  = 60;
  static const double space8XL  = 80;

  // Border Radius 
  static const double radiusXS   =  2;   // underline pills, divider caps
  static const double radiusS    =  6;   // buttons
  static const double radiusM    = 10;   // icon containers, chips
  static const double radiusL    = 12;   // cards
  static const double radiusXL   = 18;   // image inner clip (inset from border)
  static const double radiusXXL  = 20;   // image outer container

  // Border Width 
  static const double borderThin    = 1.0;   // navbar bottom border, dividers
  static const double borderDefault = 1.5;   // card borders, button borders
  static const double borderThick   = 2.5;   // profile image border
  static const double borderAccent  = 3.0;   // drawer active item left border

  // Icon Sizes 
  static const double iconXS   = 14;  // arrow / inline icon
  static const double iconS    = 22;  // close button
  static const double iconM    = 24;  // hamburger / menu button
  static const double iconL    = 26;  // card category icon, navbar hamburger
  static const double iconXL   = 32;  // placeholder accents (scaled by container)

  // Navbar 
  static const double navbarHeight          = 70;
  static const double navbarLogoFontSize    = 20;
  static const double navbarLogoDotSize     =  8;
  static const double navbarLogoDotSpacing  =  9;   // margin-right before name
  static const double navbarItemPaddingH    = 15;   // horizontal padding per link
  static const double navbarUnderlineWidth  = 24;   // active underline max width
  static const double navbarUnderlineHeight =  2;
  static const double navbarUnderlineGap    =  4;   // gap between label and line
  static const double navbarBlurSigma       = 18;   // glass blur sigma X & Y
  static const double navbarShadowBlur      = 20;

  // Mobile Drawer 
  static const double drawerWidth           = 280;
  static const double drawerShadowBlur      =  24;
  static const double drawerShadowOffsetX   =  -4;
  static const double drawerDividerHeight   =   1;
  static const double drawerDividerSpacingH =  24;  // horizontal margin
  static const double drawerDividerSpacingV =  14;  // vertical margin
  static const double drawerHeaderPadL      =  24;
  static const double drawerHeaderPadT      =  20;
  static const double drawerHeaderPadR      =  12;
  static const double drawerItemPaddingH    =  24;
  static const double drawerItemPaddingV    =  15;
  static const double drawerActiveBorderW   =   3;

  // Card 
  static const double cardPadding          = 28;
  static const double cardIconContainerSize = 52;
  static const double cardIconSize         = 26;
  static const double cardGridSpacing      = 24;
  static const double cardInternalGapL     = 18;   // after icon, after title row
  static const double cardInternalGapS     =  6;   // between title and subtitle
  static const double cardArrowIconSize    = 14;
  static const double cardArrowLabelSize   = 10;   // overline fontSize override
  static const double cardArrowGap         =  6;
  static const double cardShadowBlurHover  = 24;
  static const double cardShadowBlurDepth  = 16;
  static const double cardShadowBlurRest   = 10;

  // Section 
  static const double sectionPaddingVertical    = 80;
  static const double sectionPaddingVerticalMob = 60;
  static const double sectionMinHeightDesktop   = 640;
  static const double sectionMinHeightMobile    = 500;
  static const double sectionHeaderGapOverline  = 12;   // overline → title
  static const double sectionHeaderGapRule      = 14;   // title → rule
  static const double sectionHeaderGapSubtitle  = 14;   // rule → subtitle
  static const double sectionHeaderGapContent   = 56;   // subtitle → grid/content

  // Divider / Gold Rule 
  static const double goldRuleWidth   = 52;
  static const double goldRuleHeight  =  3;

  // Profile Image 
  static const double profileImageDesktop = 340;
  static const double profileImageMobile  = 220;
  static const double profileShadowBlur1  =  30;  // gold glow
  static const double profileShadowBlur2  =  20;  // neutral depth

  // Button ─
  static const double buttonPaddingH       = 28;
  static const double buttonPaddingV       = 14;
  static const double buttonShadowBlur     = 12;
  static const double buttonShadowOffsetY  =  4;
  static const double buttonGapBetween     = 16;  // space between primary/secondary

  // Hero text column internals 
  static const double heroColGap           = 60;   // gap between text and image cols
  static const double heroMobileImageGap   = 40;   // gap after image in mobile stack
  static const double heroOverlineFontSize = 13;
  static const double heroOverlineSpacing  =  3;   // letterSpacing
  static const double heroNameGap          = 10;   // overline → name
  static const double heroRoleStripGap     = 12;   // name → role strip
  static const double heroAnimTitleGap     = 10;   // role strip → animated title
  static const double heroRuleGap          = 24;   // animated title → gold rule
  static const double heroParaGap          = 24;   // gold rule → paragraph
  static const double heroCtaGap           = 36;   // paragraph → CTA buttons
  static const double heroParaMaxWidth     = 480;  // max width of intro paragraph
  static const double heroAnimTitleSize    = 18;   // animated subtitle fontSize

  // Shadow blur catalogue (shared across components) 
  static const double shadowBlurXS   =  8;
  static const double shadowBlurS    = 10;
  static const double shadowBlurM    = 12;
  static const double shadowBlurL    = 16;
  static const double shadowBlurXL   = 20;
  static const double shadowBlurXXL  = 24;
  static const double shadowBlurHero = 30;

  // Animation durations 
  static const Duration durationFast    = Duration(milliseconds: 180);
  static const Duration durationDefault = Duration(milliseconds: 200);
  static const Duration durationMedium  = Duration(milliseconds: 280);
  static const Duration durationSlow    = Duration(milliseconds: 400);
  static const Duration durationScroll  = Duration(milliseconds: 600);
  static const Duration durationShimmer = Duration(seconds: 3);
  static const Duration durationTitles  = Duration(milliseconds: 2800);
}
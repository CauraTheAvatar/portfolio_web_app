/// EDIT THIS WHEN YOU CAN RUN THE APP

import 'package:portfolio_web_app/core/theme/app_colors.dart';
import 'package:portfolio_web_app/core/theme/app_textstyle.dart';

export 'package:portfolio_web_app/core/theme/app_colors.dart' show AppColors;
export 'package:portfolio_web_app/core/theme/app_textstyle.dart'
    show AppTextStyle;

class AppStrings {
  AppStrings._();

  // Identity 
  static const String developerName    = "C'AURA TECHNOLOGY";
  static const String developerTitle   = "Full-Stack Flutter Developer";

  // Professional titles 
  static const List<String> developerTitles = [
    "Software Developer",
    "Data Analyst",
    "Flutter Engineer",
    "UI/UX Designer",
    "IT Solutions Specialist",
  ];

  // Hero intro paragraph
  static const String heroIntro =
      "With a passion for clean code and thoughtful design, we bridge the gap between "
      "software engineering precision and creative vision — turning ideas into polished digital experiences. "
      "We provide top quality technical solutions for your corporate needs.";
  static const String developerTagline =
      "Providing reliable, high-performance technical solutions\nfor web, mobile & desktop.";

  // Navbar 
  static const String navHero     = "Introduction";
  static const String navProjects = "Projects";
  static const String navSkills   = "Skills";
  static const String navExperience = "Collaborations"; // Updated
  static const String navAbout    = "About";
  static const String navContact  = "Contact";

  // Hero Section 
  static const String heroGreeting  = "We are";
  static const String heroCta       = "View Our Work";
  static const String heroCtaSecond = "Get In Touch";

  // Projects Section 
  static const String projectsTitle    = "Projects";
  static const String projectsSubtitle = "A selection of things we've built. Click on any card to explore more.";
  static const String projectsBack     = "Back to Projects";
  static const String back             = "Back";

  // Software sub-categories 
  static const String subWeb           = "Web Applications";
  static const String subWebDesc       = "Full-stack and frontend web apps built for the browser.";
  static const String subMobile        = "Mobile Applications";
  static const String subMobileDesc    = "Cross-platform mobile apps built with Flutter.";
  static const String subGithub        = "GitHub Projects";
  static const String subGithubDesc    = "Open source and in-house repositories.";

  // Firebase Storage base 
  // Replace YOUR_BUCKET with your Firebase project's storage bucket name.
  // All image URLs follow this pattern:
  //   https://firebasestorage.googleapis.com/v0/b/YOUR_BUCKET/o/PATH?alt=media
  //
  // After uploading images to Firebase Storage, paste the download URLs here.
  // No other file needs to change — all screens reference these constants.

  static const String _fb = 'https://firebasestorage.googleapis.com/v0/b/YOUR_BUCKET/o';

  // Profile image (hero section)
  static const String fbProfileImage     = "assets/images/C'aura Technology Logo Gold Fixed.png";

  // Software — Prayer Box
  static const String fbPrayerBoxWeb     = '$_fb/projects%2Fprayer_box_web.jpg?alt=media';
  static const String fbPrayerBoxMobile  = '$_fb/projects%2Fprayer_box_mobile.jpg?alt=media';

  // WordPress — Cao Cao
  static const String fbCaoCao           = '$_fb/projects%2Fcao_cao.jpg?alt=media';

  // Data Engineering — Pipeline
  static const String fbDataPipeline     = '$_fb/projects%2Fdata_pipeline.jpg?alt=media';

  // UI Design gallery images — add one constant per design upload
  // static const String fbUIPrayerBox   = '$_fb/ui%2Fprayer_box_ui.jpg?alt=media';

  // ===== REAL PROJECT DATA =====

  // Prayer Box project
  static const String projPrayerBoxTitle   = "Prayer Box";
  static const String projPrayerBoxDesc    = "A cross-platform prayer journaling app that helps users record, organise and reflect on their prayers. Built with Flutter and Firebase.";
  static const String projPrayerBoxWeb     = "https://astounding-alfajores-a2eed0.netlify.app/";
  static const String projPrayerBoxMobile  = "https://astounding-alfajores-a2eed0.netlify.app/downloads/app-release.apk";
  static const String projPrayerBoxGithub  = "https://github.com/CauraTheAvatar/prayer-box";

  // GitHub listing
  static const String githubProfile        = "https://github.com/CauraTheAvatar";

  // WordPress - Cao Cao Investment
  static const String projCaoCaoTitle  = "Cao Cao Investment Website";
  static const String projCaoCaoDesc   = "Corporate investment firm website built on WordPress. Minimalistic design serving as the first point of contact for potential clients.";
  static const String projCaoCaoUrl    = "https://conceicaolaurauuyuni.wordpress.com/";

  // Hope Home Base (In Progress)
  static const String projHopeHomeTitle    = "Hope Home Base Healthcare";
  static const String projHopeHomeDesc     = "Healthcare information and outreach website for an NGO caring for chronically ill and bedridden patients. Features educational resources and contact form.";
  static const String projHopeHomeUrl      = ""; // Add when deployed

  // Data Engineering & Analytics
  static const String projPipelineTitle    = "Scalable Data Pipeline";
  static const String projPipelineDesc     = "End-to-end data pipeline for Cost of Living Analysis in Namibia. Handles ingestion, transformation, and loading across distributed sources.";
  static const String projPipelineGithub   = "https://github.com/CauraTheAvatar/Scalable-Data-Pipeline-for-Public-Health-Cost-of-Living-Insights-in-Namibia.git";

  // Abba Selah Quotation System
  static const String projAbbaSelahTitle   = "Abba Selah Automated Quotation Generator";
  static const String projAbbaSelahDesc    = "Automated quotation generation engine using JavaScript and Google Apps Script. Processes Google Form responses, computes item sums by category, generates PDF quotes within 30 seconds, and emails them to clients with copies to business owners.";
  static const String projAbbaSelahUrl     = ""; // Add if deployed

  // Data Analytics sub-categories
  static const String subDataAnalyticsFull = "Data Analytics";
  static const String subDataFullDesc      = "Full project documentation and analysis reports.";
  static const String subDataViz           = "Data Visualization";
  static const String subDataVizDesc       = "Tableau Public dashboards and interactive visualizations.";
  static const String subDataAnalyticsCode = "Code";
  static const String subDataCodeDesc      = "Analysis scripts and notebooks stored on GitHub.";
  static const String tableauProfile       = "https://public.tableau.com/app/profile/caura.technology"; // Update with your profile

  // Data Analytics project list 
  static const List<Map<String, String>> analyticsProjects = [
    {
      'title':   'Scalable Data Pipeline',
      'summary': 'End-to-end data pipeline for Cost of Living Analysis in Namibia. Includes data ingestion, transformation, and analysis scripts.',
      'docUrl':  'https://github.com/CauraTheAvatar/Scalable-Data-Pipeline-for-Public-Health-Cost-of-Living-Insights-in-Namibia.git',
    },
  ];
  static const String dataGithub       = "https://github.com/CauraTheAvatar/data-analytics";

  // UI Design 
  static const String figmaProfile     = "https://figma.com/@cauratech"; // Update with your profile
  static const String canvaProfile     = "https://canva.com/cauratech"; // Update with your profile

  // Graphic Design 
  static const String graphicBack      = "Back to Graphic Design";
  static const String graphicNotion    = "https://www.notion.so/DECOR-CONTENT-CREATION-PLANNER-2ee3ce6e325d81a1ac70f7b8238587ae?source=copy_link";
  static const String graphicLogos     = "https://drive.google.com/drive/folders/1wlhg3U8lP7yrM-75rJzlrTCne7VXx_2v?usp=drive_link";
  static const String graphicPosters   = "https://drive.google.com/drive/folders/1UpFrC2bNHB3n7YopqkIpWcarQ0-mTQTL?usp=drive_link";

  // Project category labels 
  static const String catSoftware     = "Software Development";
  static const String catWordPress    = "WordPress";
  static const String catDataEng      = "Data Engineering";
  static const String catDataAnalytics = "Data Analytics";
  static const String catUIDesign     = "UI Design";
  static const String catGraphicDesign = "Graphic Design";

  // Data analytics sub-category labels
  static const String subDataAnalyticsFullLabel = "Data Analytics Projects";
  static const String subTableauLabel           = "Tableau Dashboards";
  static const String subDataAnalyticsCodeLabel = "Code Repositories";

  // CTA labels used on project cards
  static const String ctaViewLive    = "View Live";
  static const String ctaViewGithub  = "GitHub";
  static const String ctaViewFigma   = "Figma";
  static const String ctaViewCanva   = "Canva";
  static const String ctaViewTableau = "Tableau";
  static const String ctaDownloadDoc = "View Code";
  static const String ctaViewNotion  = "View Notion";
  static const String ctaViewDrive   = "View Drive";
  static const String ctaDownloadApk = "Download APK";

  // Experience Section
  static const String expTitle = "Collaborations"; 
  static const String expSubtitle = "Companies and organizations we've collaborated with to build technological solutions."; 

  // Skill category cards
  static const List<Map<String, dynamic>> skillCategories = [
    {
      'title':    'Software Engineering',
      'icon':     'code',
      'skills':   [
        'Flutter', 'Dart', 'Node.js', 'TypeScript', 'Angular',
        'REST APIs', 'Firebase', 'Supabase', 'GetX', 
        'Riverpod', 'Git & GitHub', 'PostgreSQL', 'WordPress',
      ],
    },
    {
      'title': 'Data Science & Analytics',  
      'icon': 'analytics',
      'skills': [
        'Python', 'Data Engineering', 'Tableau',
        'Data Analytics', 'Data Visualization',  
        'Scalable Pipelines', 'SQL',
      ],
    },
    {
      'title':    'UI/UX Design',
      'icon':     'design',
      'skills':   [
        'Figma', 'Canva', 'Wireframing',
        'Prototyping', 'User Research',
        'Design Systems', 'Responsive Design',
      ],
    },
    {
      'title':    'Graphic Design',
      'icon':     'brush',
      'skills':   [
        'Poster Design', 'Brand Identity',
        'Typography', 'Print Design',
        'Digital Illustration', 'Canva Pro',
      ],
    },
  ];

  // Full flat skills list (used elsewhere e.g. chip grids)
  static const List<String> skills = [
    'Flutter',
    'Dart',
    'Firebase',
    'REST APIs',
    'GetX',
    'Riverpod',
    'Supabase',
    'Git & GitHub',
    'Figma',
    'UI/UX Design',
    'Node.js',
    'TypeScript',      
    'Angular',         
    'PostgreSQL',
    'Tableau',
    'Python',
    'Data Engineering',
    'WordPress',
  ];

  // About Section 
  static const String aboutTitle    = "About Us";
  static const String aboutSubtitle = "A little background.";

  // About block 1 — Education 
  static const String aboutEduTitle    = "Founder Education & Learning";
  static const String aboutEduBody     =
      "My journey into technology began with a genuine curiosity about how things work. "
      "I pursued a formal education in Computer Science, where I developed a strong "
      "foundation in software engineering, data structures, and systems thinking. "
      "Beyond the classroom, I've committed to continuous self-development — "
      "completing professional certifications in data analytics, machine learning, "
      "and mobile development. I believe learning never stops, and every project "
      "is an opportunity to grow. Outside of tech, I find balance in creative expression, "
      "community building, and the pursuit of excellence in everything I take on.";

  // About block 2 — Achievements (right-aligned) 
  static const String aboutAchTitle    = "Milestones & Achievements";
  static const String aboutAchBody     =
      "Across software, data, and design, we've had the privilege of building "
      "real-world solutions that people use. From engineering scalable data "
      "pipelines and deploying cross-platform Flutter applications, to founding "
      "C'aura Hair Care, a professional loctician business, and C'aura Technologies — "
      "we've learned to lead with intention and execute with discipline. "
      "Each milestone has sharpened both our technical edge and entrepreneurial instinct.";

  // About block 3 — Personal Profile 
  static const String aboutPersonalTitle = "Philosophy & Values";
  static const String aboutPersonalBody  =
      "We believe great software is built at the intersection of empathy and "
      "engineering. Our work philosophy centres on clarity, ownership, and craft — "
      "writing code that is as readable as it is functional. We lead by example, "
      "whether in a collaborative setting or tackling business ventures, and we hold our organisation "
      "to a standard of continuous improvement.";

  // Startup callouts
  static const String aboutStartup1     = "C'aura Hair Care";
  static const String aboutStartup1Sub  = "Loctician Business";

  static const String aboutCtaLabel = "Download CV";
  static const String aboutCtaLink  = "https://yourname.dev/cv.pdf";

  // Contact Section 
  static const String contactTitle    = "Contact";
  static const String contactSubtitle = "Let's work together.";
  static const String contactBody     =
      "Have a project in mind or just want to say hello? "
      "Drop us a message and we will get back to you as soon as possible.";

  static const String contactEmail    = "cauratechnology@gmail.com";
  static const String contactGithub   = "https://github.com/CauraTheAvatar";
  static const String contactLinkedin = "https://www.linkedin.com/in/conceicao-uuyuni-35a1a6200/"; // Update with your LinkedIn

  static const String contactEmailLabel    = "Email Us";
  static const String contactGithubLabel   = "GitHub";
  static const String contactLinkedinLabel = "LinkedIn";

  // Footer 
  static const String footerCopyright = "© 2026 C'aura Technology. All Rights Reserved.";
  static const String footerTagline   = "Building elegant solutions one line of code at a time.";
  static const String footerNav       = "Introduction  ·  Projects  ·  Skills  ·  Collaborations  ·  About  ·  Contact";

  // Form labels
  static const String formName        = "Full Name";
  static const String formEmail       = "Email Address";
  static const String formMessage     = "Message";
  static const String formSend        = "Send Message";
  static const String formToast       = "Message sent successfully. We'll respond soon.";
  static const String formHoneypot    = "_gotcha";             
  static const String formspreeUrl    = "https://formspree.io/f/xvzwovdo";
  static const String formSuccess     = "Message sent! We'll be in touch soon.";
  static const String formError       = "Something went wrong. Please try again.";
  static const String formValidName   = "Please enter your name.";
  static const String formValidEmail  = "Please enter a valid email address.";
  static const String formValidMsg    = "Please enter a message.";
}
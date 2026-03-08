/// EDIT THIS WHEN YOU CAN RUN THE APP

import 'package:portfolio_web_app/core/theme/app_colors.dart';
import 'package:portfolio_web_app/core/theme/app_textstyle.dart';

export 'package:portfolio_web_app/core/theme/app_colors.dart' show AppColors;
export 'package:portfolio_web_app/core/theme/app_textstyle.dart'
    show AppTextStyle;

class AppStrings {
  AppStrings._();

  // Identity 
  static const String developerName    = "Your Name";
  static const String developerTitle   = "Full-Stack Flutter Developer";

  // Professional titles 
  static const List<String> developerTitles = [
    "Software Developer",
    "Data Analyst",
    "ML Enthusiast",
    "Flutter Engineer",
    "UI/UX Designer",
  ];

  // Hero intro paragraph
  static const String heroIntro =
      "I build beautiful, high-performance applications across web, mobile & desktop. "
      "With a passion for clean code and thoughtful design, I bridge the gap between "
      "engineering precision and creative vision — turning ideas into polished digital experiences.";
  static const String developerTagline =
      "Crafting beautiful, high-performance apps\nfor web, mobile & desktop.";

  // Navbar 
  static const String navHero     = "Introduction";
  static const String navProjects = "Projects";
  static const String navSkills   = "Skills";
  static const String navExperience = "Experience"; // ADDED
  static const String navAbout    = "About";
  static const String navContact  = "Contact";

  // Hero Section 
  static const String heroGreeting  = "Hello, I'm";
  static const String heroCta       = "View My Work";
  static const String heroCtaSecond = "Get In Touch";

  // Projects Section 
  static const String projectsTitle    = "Projects";
  static const String projectsSubtitle = "A selection of things I've built.";
  static const String projectsBack     = "Back to Projects";
  static const String back             = "Back";

  // Software sub-categories 
  static const String subWeb           = "Web Applications";
  static const String subWebDesc       = "Full-stack and frontend web apps built for the browser.";
  static const String subMobile        = "Mobile Applications";
  static const String subMobileDesc    = "Cross-platform mobile apps built with Flutter.";
  static const String subGithub        = "GitHub Projects";
  static const String subGithubDesc    = "Open source and personal repositories.";

  // Firebase Storage base 
  // Replace YOUR_BUCKET with your Firebase project's storage bucket name.
  // All image URLs follow this pattern:
  //   https://firebasestorage.googleapis.com/v0/b/YOUR_BUCKET/o/PATH?alt=media
  //
  // After uploading images to Firebase Storage, paste the download URLs here.
  // No other file needs to change — all screens reference these constants.

  static const String _fb = 'https://firebasestorage.googleapis.com/v0/b/YOUR_BUCKET/o';

  // Profile image (hero section)
  static const String fbProfileImage     = '$_fb/profile%2Fprofile.jpg?alt=media';

  // Software — Prayer Box
  static const String fbPrayerBoxWeb     = '$_fb/projects%2Fprayer_box_web.jpg?alt=media';
  static const String fbPrayerBoxMobile  = '$_fb/projects%2Fprayer_box_mobile.jpg?alt=media';

  // WordPress — Cao Cao
  static const String fbCaoCao           = '$_fb/projects%2Fcao_cao.jpg?alt=media';

  // Data Engineering — Pipeline
  static const String fbDataPipeline     = '$_fb/projects%2Fdata_pipeline.jpg?alt=media';

  // UI Design gallery images — add one constant per design upload
  // static const String fbUIPrayerBox   = '$_fb/ui%2Fprayer_box_ui.jpg?alt=media';

  // Graphic Design gallery images — add one constant per image upload
  // Posters
  // static const String fbPoster1       = '$_fb/graphic%2Fposters%2Fposter_1.jpg?alt=media';
  // Brand Graphics
  // static const String fbBrand1        = '$_fb/graphic%2Fbrand%2Fbrand_1.jpg?alt=media';
  // Event Graphics
  // static const String fbEvent1        = '$_fb/graphic%2Fevents%2Fevent_1.jpg?alt=media';

  // Prayer Box project
  static const String projPrayerBoxTitle   = "Prayer Box";
  static const String projPrayerBoxDesc    = "A cross-platform prayer journaling app that helps users record, organise and reflect on their prayers. Built with Flutter and Firebase.";
  static const String projPrayerBoxWeb     = "https://prayer-box.web.app";
  static const String projPrayerBoxGithub  = "https://github.com/yourname/prayer-box";

  // GitHub listing
  static const String githubProfile        = "https://github.com/yourname";

  // WordPress 
  static const String projCaoCaoTitle  = "Cao Cao Investment Website";
  static const String projCaoCaoDesc   = "Corporate investment firm website built on WordPress. Includes service pages, team profiles, and a contact portal.";
  static const String projCaoCaoUrl    = "https://caocaoinvestments.com";

  // Data Engineering 
  static const String projPipelineTitle  = "Scalable Data Pipeline";
  static const String projPipelineDesc   = "An end-to-end data pipeline built for scalability. Handles ingestion, transformation, and loading across distributed sources.";
  static const String projPipelineGithub = "https://github.com/yourname/scalable-data-pipeline";

  // Data Analytics sub-categories
  static const String subDataAnalyticsFull = "Data Analytics";
  static const String subDataFullDesc      = "Full project documentation and analysis reports.";
  static const String subDataViz           = "Data Visualization";
  static const String subDataVizDesc       = "Tableau Public dashboards and interactive visualizations.";
  static const String subDataAnalyticsCode = "Code";
  static const String subDataCodeDesc      = "Analysis scripts and notebooks stored on GitHub.";
  static const String tableauProfile       = "https://public.tableau.com/app/profile/yourname";

  // Data Analytics project list 
  // Each entry: title, summary, docUrl
  // docUrl → Google Drive / Dropbox / direct PDF link for download button
  static const List<Map<String, String>> analyticsProjects = [
    {
      'title':   'Customer Churn Analysis',
      'summary': 'Cohort analysis identifying churn drivers across customer segments. Includes predictive modelling and actionable recommendations.',
      'docUrl':  'https://drive.google.com/your-doc-link',
    },
    {
      'title':   'Sales Performance Dashboard',
      'summary': 'End-to-end sales analysis covering revenue trends, regional performance, and YoY comparisons.',
      'docUrl':  'https://drive.google.com/your-doc-link',
    },
    {
      'title':   'Market Basket Analysis',
      'summary': 'Association rule mining on retail transaction data to uncover product affinity and cross-sell opportunities.',
      'docUrl':  'https://drive.google.com/your-doc-link',
    },
  ];
  static const String dataGithub       = "https://github.com/yourname/data-analytics";

  // UI Design 
  static const String figmaProfile     = "https://figma.com/@yourname";
  static const String canvaProfile     = "https://canva.com/yourname";

  // Graphic Design categories 
  static const String graphicBack      = "Back to Graphic Design";

  // Project category labels 
  static const String catSoftware     = "Software Development";
  static const String catWordPress    = "WordPress";
  static const String catDataEng      = "Data Engineering";
  static const String catDataViz      = "Data Visualization (Tableau)";
  static const String catDataAnalytics = "Data Analytics";
  static const String catUIDesign     = "UI Design";
  static const String catGraphicDesign = "Graphic Design";

  // Data analytics sub-category labels
  static const String subDataAnalyticsFullLabel = "Data Analytics (Full)";
  static const String subTableauLabel           = "Data Visualisation Dashboards";
  static const String subDataAnalyticsCodeLabel = "Code";

  // CTA labels used on project cards
  static const String ctaViewLive    = "View Live";
  static const String ctaViewGithub  = "GitHub";
  static const String ctaViewFigma   = "Figma";
  static const String ctaViewCanva   = "Canva";
  static const String ctaViewTableau = "Tableau";
  static const String ctaDownloadDoc = "Download Docs";

  // Skills Section 
  static const String skillsTitle    = "Skills";
  static const String skillsSubtitle = "Technologies & tools I work with.";

  // Skill category cards
  static const List<Map<String, dynamic>> skillCategories = [
    {
      'title':    'Software Engineering',
      'icon':     'code',
      'skills':   [
        'Flutter', 'Dart', 'Node.js', 'REST APIs',
        'Firebase', 'Supabase', 'GetX', 'Riverpod',
        'Git & GitHub', 'PostgreSQL', 'WordPress',
      ],
    },
    {
      'title':    'Data Science',
      'icon':     'analytics',
      'skills':   [
        'Python', 'Data Engineering', 'Tableau',
        'Data Analytics', 'Scalable Pipelines',
        'Data Visualisation', 'SQL',
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
    'PostgreSQL',
    'Tableau',
    'Python',
    'Data Engineering',
    'WordPress',
  ];

  // Experience Section
  static const String expTitle = "Experience";
  static const String expSubtitle = "My professional journey and work history.";

  // About Section 
  static const String aboutTitle    = "About Me";
  static const String aboutSubtitle = "A little background.";

  // About block 1 — Education 
  static const String aboutEduTitle    = "Education & Learning";
  static const String aboutEduBody     =
      "My journey into technology began with a genuine curiosity about how things work. "
      "I pursued a formal education in Computer Science, where I developed a strong "
      "foundation in software engineering, data structures, and systems thinking. "
      "Beyond the classroom, I've committed to continuous self-development — "
      "completing professional certifications in data analytics, machine learning, "
      "and mobile development. I believe learning never stops, and every project "
      "is an opportunity to grow.";

  // About block 2 — Achievements (right-aligned) 
  static const String aboutAchTitle    = "Milestones & Achievements";
  static const String aboutAchBody     =
      "Across software, data, and design, I've had the privilege of building "
      "real-world solutions that people use. From engineering scalable data "
      "pipelines and deploying cross-platform Flutter applications, to founding "
      "two independent ventures — C'aura Hair Care, a professional loctician "
      "business, and Abba Selah Collectives, an event décor rental service — "
      "I've learned to lead with intention and execute with discipline. "
      "Each milestone has sharpened both my technical edge and my entrepreneurial instinct.";

  // About block 3 — Personal Profile 
  static const String aboutPersonalTitle = "Philosophy & Values";
  static const String aboutPersonalBody  =
      "I believe great software is built at the intersection of empathy and "
      "engineering. My work philosophy centres on clarity, ownership, and craft — "
      "writing code that is as readable as it is functional. I lead by example, "
      "whether in a team setting or running my own ventures, and I hold myself "
      "to a standard of continuous improvement. Outside of tech, I find balance "
      "in creative expression, community building, and the pursuit of excellence "
      "in everything I take on.";

  // Startup callouts
  static const String aboutStartup1     = "C'aura Hair Care";
  static const String aboutStartup1Sub  = "Loctician Business";
  static const String aboutStartup2     = "Abba Selah Collectives";
  static const String aboutStartup2Sub  = "Event Décor Rental Service";

  static const String aboutCtaLabel = "Download CV";
  static const String aboutCtaLink  = "https://yourname.dev/cv.pdf";

  // Contact Section 
  static const String contactTitle    = "Contact";
  static const String contactSubtitle = "Let's work together.";
  static const String contactBody     =
      "Have a project in mind or just want to say hello? "
      "Drop me a message and I'll get back to you as soon as possible.";

  static const String contactEmail    = "hello@yourname.dev";
  static const String contactGithub   = "https://github.com/yourname";
  static const String contactLinkedin = "https://linkedin.com/in/yourname";

  static const String contactEmailLabel    = "Email Me";
  static const String contactGithubLabel   = "GitHub";
  static const String contactLinkedinLabel = "LinkedIn";

  // Footer 
  static const String footerCopyright = "© 2026 Laura Conceicao. All Rights Reserved.";
  static const String footerTagline   = "Building elegant solutions one line of code at a time.";
  static const String footerNav       = "Introduction  ·  Projects  ·  Skills  ·  Experience  ·  About  ·  Contact"; // UPDATED

  // Form labels
  static const String formName        = "Full Name";
  static const String formEmail       = "Email Address";
  static const String formMessage     = "Message";
  static const String formSend        = "Send Message";
  static const String formToast       = "Message sent successfully. I'll respond soon.";
  static const String formHoneypot    = "_gotcha";             
  static const String formspreeUrl    = "https://formspree.io/f/xvzwovdo";
  static const String formSuccess     = "Message sent! I'll be in touch soon.";
  static const String formError       = "Something went wrong. Please try again.";
  static const String formValidName   = "Please enter your name.";
  static const String formValidEmail  = "Please enter a valid email address.";
  static const String formValidMsg    = "Please enter a message.";
}
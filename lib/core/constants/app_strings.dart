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

  // Professional titles — cycled in the animated type-writer role display
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

  // Project category labels — each maps to a sub-screen
  static const String catSoftware     = "Software Development";
  static const String catWordPress    = "WordPress";
  static const String catDataEng      = "Data Engineering";
  static const String catDataViz       = "Data Visualization (Tableau)";
  static const String catDataAnalytics = "Data Analytics";
  static const String catUIDesign     = "UI Design";
  static const String catGraphicDesign = "Graphic Design";

  // Software sub-category labels
  static const String subWebApps     = "Web Applications";
  static const String subMobileApps  = "Mobile Applications";
  static const String subGithub      = "GitHub Projects";

  // Data analytics sub-category labels
  static const String subDataFull    = "Data Analytics (Full)";
  static const String subTableau     = "Data Visualisation Dashboards";
  static const String subDataCode    = "Code";

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

  // Skill category cards — 4 groups shown in the hover-blur row
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

  // Form labels
  static const String formName        = "Full Name";
  static const String formEmail       = "Email Address";
  static const String formMessage     = "Message";
  static const String formSend        = "Send Message";
  static const String formToast       = "Message sent successfully. I will get back to you soon.";
  static const String formHoneypot    = "_gotcha";             // hidden spam field name
  static const String formspreeUrl    = "https://formspree.io/f/xvzwovdo";
  static const String formSuccess     = "Message sent! I'll be in touch soon.";
  static const String formError       = "Something went wrong. Please try again.";
  static const String formValidName   = "Please enter your name.";
  static const String formValidEmail  = "Please enter a valid email address.";
  static const String formValidMsg    = "Please enter a message.";
}
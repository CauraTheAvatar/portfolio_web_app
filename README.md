# Portfolio Web App
A personal developer portfolio built with **Flutter Web** — a single-page, scroll-based application showcasing software development, data engineering, UI/UX design, and graphic design work. The app is fully responsive across mobile, tablet, and desktop, and is designed to be deployed as a static web application.

# Site URL


## Overview
This is a professionally structured Flutter Web project with a clean architecture separating concerns across constants, controllers, services, core utilities, and UI sections. The design language is built around a white and gold palette with Playfair Display and Montserrat typography, glassmorphism effects on the navbar, and smooth hover animations throughout.

## Tech Stack   
Framework:              Flutter (Web target)
Language:               Dart 
State Management:       GetX (`get: ^4.x`) 
HTTP Client:            `http: ^1.2.0` 
Form Submission:        Formspree (`https://formspree.io`) 
Toast Notifications:    `fluttertoast: ^8.2.4` 
Scroll Visibility:      `visibility_detector: ^0.4.0` 
Typography:             Playfair Display
                        Montserrat (Google Fonts, self-hosted) 
IDE:                    VS Code
                        Android Studio (emulator only)
Version Control:        GitHub 

# Portfolio Web App
A personal developer portfolio built with Flutter Web. Single-page scroll layout with sections for Introduction, Projects, Skills, About, and Contact.

## Built With
- Flutter Web & Dart
- GetX for state management
- Formspree for contact form handling
- FlutterToast for notifications
- Playfair Display & Montserrat typography

## Sections
1. **Hero** — Introduction with profile image and CTA buttons
2. **Projects** — Grid of project category cards, each opening a dedicated sub-screen
3. **Skills** — Four skill category cards with a hover blur-defocus effect
4. **About** — Three info blocks covering education, achievements, and personal values
5. **Contact** — Contact form wired to Formspree with spam protection and toast confirmation

## Project Categories
Software Development · WordPress · Data Engineering · Data Visualization · Data Analytics · UI Design · Graphic Design

## Setup
    flutter pub get
    flutter run -d chrome
    flutter build web --release

## Configuration
All personalisation is done in `lib/constants/app_strings.dart` — update your name, titles, bio, email, social links, and CV link there. Replace `assets/images/profile_placeholder.jpg` with your actual photo.

The Formspree endpoint is already configured at `https://formspree.io/f/xvzwovdo`.

## Still To Build
- Project category sub-screens
- Footer
- Deployment

# USER EXPERIENCE FLOW
1.  Visitor lands on Introduction.
2.  Scrolls to Projects.
3.  Opens a project category.
4.  Views project gallery.
5.  Opens a specific project.
6.  Returns to main portfolio.
7.  Scrolls to Skills.
8.  Scrolls to About.
9.  Scrolls to Contact.
10. Sends inquiry message.
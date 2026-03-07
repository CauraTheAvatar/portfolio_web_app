// ─────────────────────────────────────────────────────────────────────────────
// PHASE 36 — Performance Optimisation Notes
//
// This file documents the performance decisions made across the codebase.
// It is not imported anywhere — it is a reference document.
// ─────────────────────────────────────────────────────────────────────────────
//
// ── 1. const widgets ──────────────────────────────────────────────────────────
// All stateless leaf widgets that hold no dynamic data are declared const.
// This tells Flutter to reuse the same widget instance across rebuilds
// rather than creating a new one.
//
// Applied to:
//   - All placeholder widgets (_LoadingPlaceholder, _ErrorPlaceholder)
//   - All empty state widgets (_EmptyState, _EmptyGalleryState, etc.)
//   - All static text/icon children inside stateful parent widgets
//   - SecondaryScreenShell (entire shell is const when title/child are const)
//   - _BackButton (const constructor, no props)
//   - Navbar (const constructor)
//
// ── 2. Lazy loading ───────────────────────────────────────────────────────────
// All gallery and project card images use CachedNetworkImage.
//
// CachedNetworkImage provides two levels of laziness:
//   a) Download laziness — image is only fetched when the widget is built.
//      Flutter's scroll views build widgets lazily (SliverList, ListView),
//      but our Wrap-based grids build all items at once since Wrap is not
//      a sliver. For large galleries (20+ images), consider switching
//      to SliverMasonryGrid (flutter_staggered_grid_view package) which
//      builds only visible tiles.
//   b) Decode laziness — CachedNetworkImage decodes on a background isolate,
//      avoiding jank on the main thread.
//   c) Disk + memory cache — downloaded images are cached to disk. Repeat
//      visits serve from disk without a network round-trip.
//
// ── 3. Limited rebuilds ───────────────────────────────────────────────────────
// Rebuild scope is minimised across the app:
//
//   _ScrollProgressBar (home_screen.dart)
//     — isolated StatefulWidget that listens to scrollController independently.
//       Only this 3px bar rebuilds on scroll, not the entire HomeScreen.
//
//   Obx in navbar (navbar.dart)
//     — only the active link row rebuilds when activeSection changes.
//       The logo, hamburger, and glass background do not rebuild.
//
//   FadeInSection (fade_in_section.dart)
//     — AnimationController drives FadeTransition + SlideTransition directly.
//       These use render-layer animation (no setState, no widget rebuild).
//
//   MagneticCard (magnetic_card.dart)
//     — setState only updates _translate (2 doubles). The child widget tree
//       is hoisted outside the AnimatedContainer so it is not rebuilt
//       on each pointer move — only the transform matrix changes.
//
//   ContactController (contact_controller.dart)
//     — isSending and isSuccess are RxBool. Only the submit button
//       (wrapped in Obx) rebuilds on state change.
//
// ── 4. Image compression ──────────────────────────────────────────────────────
// Firebase Storage does not auto-compress images on upload.
// Recommended workflow before uploading to Firebase Storage:
//
//   Tool:      squoosh.app  (free, browser-based)
//   Format:    WebP (best compression) or JPEG (wider compatibility)
//   Quality:   80–85% (visually lossless at this range)
//   Max width: 1400px for gallery images, 800px for card thumbnails
//
//   Folder structure in Firebase Storage:
//     profile/
//       profile.jpg            ← profile photo (800×800, WebP)
//     projects/
//       prayer_box_web.jpg     ← project screenshots (1400px wide)
//       prayer_box_mobile.jpg
//       cao_cao.jpg
//       data_pipeline.jpg
//     ui/
//       [project_name].jpg     ← UI design previews (1400px wide)
//     graphic/
//       posters/
//         poster_1.jpg         ← poster images (1400px wide)
//       brand/
//         brand_1.jpg
//       events/
//         event_1.jpg
//
// ── 5. RepaintBoundary ────────────────────────────────────────────────────────
// RepaintBoundary isolates a widget subtree into its own render layer.
// When the subtree animates, Flutter only repaints that layer — not the
// entire screen. Wrap independently animating widgets with RepaintBoundary.
//
// Applied to (see home_screen.dart):
//   - Each FadeInSection — animates independently of siblings
//   - _ScrollProgressBar — repaints on every scroll frame
//
// Applied to (see projects_section.dart, skills_section.dart):
//   - Each card's ScaleTransition — scale animation is isolated per card
//
// ── 6. String concatenation ───────────────────────────────────────────────────
// All user-facing strings are static const in app_strings.dart.
// No string interpolation in build() methods — strings are resolved at
// compile time and never allocated during rendering.
//
// ── Summary checklist ─────────────────────────────────────────────────────────
// ✅  const constructors on all stateless leaf widgets
// ✅  CachedNetworkImage for all remote images (disk + memory cache)
// ✅  FadeTransition / SlideTransition (render-layer, no rebuild)
// ✅  Isolated Obx scopes (navbar active link, contact submit button)
// ✅  _ScrollProgressBar isolated — only 3px bar repaints on scroll
// ✅  MagneticCard child hoisted outside transform (no child rebuild)
// ✅  All strings static const
// ⬜  Compress images before Firebase upload (squoosh.app, WebP, 80–85%)
// ⬜  Consider SliverMasonryGrid for galleries with 20+ images
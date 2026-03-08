import 'package:get/get.dart';
import 'package:flutter/foundation.dart'; 

enum AnalyticsEvent {
  pageView,
  projectClick,
  skillHover,
  contactSubmit,
  downloadClick,
  externalLinkClick,
}

class AnalyticsService extends GetxService {
  static AnalyticsService get to => Get.find();

  // Track if analytics is enabled
  final RxBool isEnabled = true.obs;

  // Session tracking 
  final RxString sessionId = ''.obs;
  final Rx<DateTime> sessionStart = DateTime.now().obs; 

  @override
  void onInit() {
    super.onInit();
    _startNewSession();
  }

  void _startNewSession() {
    sessionId.value = DateTime.now().millisecondsSinceEpoch.toString();
    sessionStart.value = DateTime.now();
    _logEvent('session_start', {
      'session_id': sessionId.value,
      'timestamp': sessionStart.value.toIso8601String(),
    });
  }

  // Log a custom event
  void logEvent(AnalyticsEvent event, {Map<String, dynamic>? properties}) {
    if (!isEnabled.value) return;

    final eventName = event.toString().split('.').last;
    _logEvent(eventName, properties);
  }

  // Log screen view
  void logScreenView(String screenName, {Map<String, dynamic>? properties}) {
    if (!isEnabled.value) return;

    _logEvent('screen_view', {
      'screen_name': screenName,
      ...?properties,
    });
  }

  // Log user action
  void logUserAction(String action, {Map<String, dynamic>? properties}) {
    if (!isEnabled.value) return;

    _logEvent('user_action', {
      'action': action,
      ...?properties,
    });
  }

  // Internal logging method
  void _logEvent(String eventName, Map<String, dynamic>? properties) {
    final completeProperties = {
      'session_id': sessionId.value,
      'timestamp': DateTime.now().toIso8601String(),
      ...?properties,
    };

    debugPrint('[Analytics] $eventName: $completeProperties'); 
    // TODO: Send to actual analytics service (Firebase Analytics, etc.)
    // if (kReleaseMode) {
    //   // Send to Firebase Analytics
    //   FirebaseAnalytics.instance.logEvent(
    //     name: eventName,
    //     parameters: completeProperties,
    //   );
    // }
  }

  // Track project interaction 
  void trackProjectInteraction({
    required String projectId,
    required String projectTitle,
    required String action, // 'view', 'click', 'download'
  }) {
    logUserAction(
      'project_$action',
      properties: { 
        'project_id': projectId,
        'project_title': projectTitle,
      },
    );
  }

  // Track external link click 
  void trackExternalLink({
    required String url,
    required String source, // where the link was clicked
  }) {
    logEvent(
      AnalyticsEvent.externalLinkClick,
      properties: { 
        'url': url,
        'source': source,
      },
    );
  }

  // Track form submission 
  void trackFormSubmission({
    required String formName,
    required bool success,
    String? errorMessage,
  }) {
    logEvent(
      AnalyticsEvent.contactSubmit,
      properties: { 
        'form_name': formName,
        'success': success,
        'error': errorMessage ?? '',
      },
    );
  }

  // End session
  void endSession() {
    final sessionDuration = DateTime.now().difference(sessionStart.value);
    _logEvent('session_end', {
      'session_id': sessionId.value,
      'duration_seconds': sessionDuration.inSeconds,
    });
  }
}
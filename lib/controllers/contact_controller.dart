import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:portfolio_web_app/core/constants/app_strings.dart';
import 'package:portfolio_web_app/services/formspree_service.dart';
import 'package:portfolio_web_app/services/analytics_service.dart';

class ContactController extends GetxController {
  static ContactController get to => Get.find();

  // Observable state
  final isSending = false.obs;
  final isSuccess = false.obs;

  // Field controllers
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final messageCtrl = TextEditingController();
  final honeypotCtrl = TextEditingController();

  // Form key
  final formKey = GlobalKey<FormState>();

  // Validators
  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.formValidName;
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.formValidEmail;
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(value.trim())) {
      return AppStrings.formValidEmail;
    }
    return null;
  }

  String? validateMessage(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.formValidMsg;
    }
    if (value.trim().length < 10) {
      return 'Message must be at least 10 characters';
    }
    return null;
  }

  // Submit
  Future<void> submit() async {
    // Validate all fields
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    // Honeypot check
    if (honeypotCtrl.text.isNotEmpty) {
      AnalyticsService.to.logEvent(AnalyticsEvent.contactSubmit, properties: {
        'success': false,
        'error': 'bot_detected',
      });
      return;
    }

    // Enter loading state
    isSending.value = true;
    isSuccess.value = false;

    // Send via Formspree service
    final success = await FormspreeService.to.sendContactForm(
      name: nameCtrl.text.trim(),
      email: emailCtrl.text.trim(),
      message: messageCtrl.text.trim(),
      honeypot: honeypotCtrl.text,
    );

    // React to result with analytics
    if (success) {
      _clearFields();
      isSuccess.value = true;
      
      AnalyticsService.to.trackFormSubmission(
        formName: 'contact',
        success: true,
      );
      
      Get.snackbar(
        'Success',
        AppStrings.formSuccess,
        backgroundColor: AppColors.gold,
        colorText: AppColors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 4),
      );
    } else {
      final error = FormspreeService.to.lastError.value;
      
      AnalyticsService.to.trackFormSubmission(
        formName: 'contact',
        success: false,
        errorMessage: error,
      );
      
      Get.snackbar(
        'Error',
        error.isEmpty ? AppStrings.formError : error,
        backgroundColor: Colors.red,
        colorText: AppColors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 4),
      );
    }

    isSending.value = false;
  }

  // Clear fields
  void _clearFields() {
    nameCtrl.clear();
    emailCtrl.clear();
    messageCtrl.clear();
    formKey.currentState?.reset();
  }

  // Lifecycle
  @override
  void onClose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    messageCtrl.dispose();
    honeypotCtrl.dispose();
    super.onClose();
  }
}
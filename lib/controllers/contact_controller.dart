import 'dart:ffi';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'package:portfolio_web_app/core/constants/app_strings.dart';
import 'package:portfolio_web_app/services/contact_service.dart';
import 'package:portfolio_web_app/core/constants/app_strings.dart';
import 'package:portfolio_web_app/services/contact_service.dart';

class ContactController extends GetxController {

  static ContactController get to => Get.find();

  // Observable state 

  final isSending = false.obs;
  final isSuccess = false.obs;

  // Field controllers 
  // Owned here so the controller can clear them on success and dispose properly.

  final nameCtrl     = TextEditingController();
  final emailCtrl    = TextEditingController();
  final messageCtrl  = TextEditingController();
  final honeypotCtrl = TextEditingController(); // hidden spam trap

  // Form key 
  // Passed to the Form widget in ContactSection so validation can be
  // triggered from the controller via formKey.currentState!.validate().

  final formKey = GlobalKey<FormState>();

  // Validators 
  // Exposed as methods so widgets reference them without inline logic.

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
    return null;
  }

  // Submit 
  // Full send flow:
  //   1. Run form validation — abort if invalid
  //   2. Honeypot guard — silent abort if filled (bot detected)
  //   3. Set isSending = true
  //   4. Delegate POST to ContactService
  //   5. On success → clear fields, set isSuccess, show success toast
  //   6. On failure → show error toast
  //   7. Always → set isSending = false

  Future<void> submit() async {
    // Step 1 — validate all fields
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    // Step 2 — honeypot check (bots fill this, humans never see it)
    if (honeypotCtrl.text.isNotEmpty) return;

    // Step 3 — enter loading state
    isSending.value = true;
    isSuccess.value = false;

    // Step 4 — send via service
    final result = await ContactService.send(
      name:     nameCtrl.text,
      email:    emailCtrl.text,
      message:  messageCtrl.text,
      honeypot: honeypotCtrl.text,
    );

    // Step 5 / 6 — react to result
    if (result.success) {
      _clearFields();
      isSuccess.value = true;
      _showToast(success: true);
    } else {
      _showToast(success: false, message: result.error);
    }

    // Step 7
    isSending.value = false;
  }

  // Clear fields 

  void _clearFields() {
    nameCtrl.clear();
    emailCtrl.clear();
    messageCtrl.clear();
    // honeypotCtrl intentionally not cleared — irrelevant for UX
    // Reset form so validation error states are also cleared
    formKey.currentState?.reset();
  }

  // Toast 
  // Uses GetX snackbar so no BuildContext is needed.
  // Gold accent on success, red on failure.

  void _showToast({required bool success, String? message}) {
    Fluttertoast.showToast(
      msg:          success
          ? AppStrings.formToast
          : (message ?? AppStrings.formError),
      toastLength:  Toast.LENGTH_LONG,
      gravity:      ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: const Color(0xFF111111),  // black
      textColor:       const Color(0xFFFFFFFF),  // white
      fontSize:        14,
      webBgColor:      '#111111',
      webPosition:     'center',
    );
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
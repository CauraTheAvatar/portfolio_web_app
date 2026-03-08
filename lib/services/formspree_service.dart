import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart'; 
import 'package:http/http.dart' as http;
import 'package:portfolio_web_app/core/constants/app_strings.dart';

class FormspreeService extends GetxService {
  static FormspreeService get to => Get.find();

  final RxBool isSending = false.obs;
  final RxString lastError = ''.obs;
  final RxString lastSuccess = ''.obs;

  Future<bool> sendContactForm({
    required String name,
    required String email,
    required String message,
    String? honeypot,
  }) async {
    // If honeypot is filled, silently reject (bot detection)
    if (honeypot != null && honeypot.isNotEmpty) {
      debugPrint('Bot detected - honeypot triggered'); 
      return false;
    }

    try {
      isSending.value = true;
      lastError.value = '';
      lastSuccess.value = '';

      final response = await http.post(
        Uri.parse(AppStrings.formspreeUrl),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': name,
          'email': email,
          'message': message,
          '_gotcha': honeypot ?? '',
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        lastSuccess.value = AppStrings.formSuccess;
        return true;
      } else {
        final data = json.decode(response.body);
        lastError.value = data['error'] ?? AppStrings.formError;
        return false;
      }
    } catch (e) {
      lastError.value = e.toString();
      return false;
    } finally {
      isSending.value = false;
    }
  }

  // Clear status messages
  void clearStatus() {
    lastError.value = '';
    lastSuccess.value = '';
  }
}
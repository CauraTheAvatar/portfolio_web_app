import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:portfolio_web_app/core/constants/app_strings.dart';

class ContactService {
  ContactService._();
  static Future<ContactResult> send({
    required String name,
    required String email,
    required String message,
    String honeypot = '',
  }) async {
    try {
      final response = await http.post(
        Uri.parse(AppStrings.formspreeUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept':       'application/json',
        },
        body: jsonEncode({
          'name':                    name.trim(),
          'email':                   email.trim(),
          'message':                 message.trim(),
          AppStrings.formHoneypot:   honeypot,
        }),
      );

      if (response.statusCode == 200) {
        return const ContactResult.success();
      }

      // Formspree returns structured errors in the response body
      final body = _parseBody(response.body);
      final serverError = body['error'] as String? ??
          'Server returned status ${response.statusCode}.';

      return ContactResult.failure(serverError);

    } on http.ClientException catch (e) {
      debugPrint('[ContactService] Network error: $e');
      return ContactResult.failure(AppStrings.formError);

    } catch (e) {
      debugPrint('[ContactService] Unexpected error: $e');
      return ContactResult.failure(AppStrings.formError);
    }
  }

  // Safely parse JSON response body — returns empty map on failure
  static Map<String, dynamic> _parseBody(String body) {
    try {
      return jsonDecode(body) as Map<String, dynamic>;
    } catch (_) {
      return {};
    }
  }
}

// ContactResult
class ContactResult {

  const ContactResult._({
    required this.success,
    this.error,
  });

  const ContactResult.success()
      : success = true,
        error   = null;

  const ContactResult.failure(String message)
      : success = false,
        error   = message;

  final bool    success;
  final String? error;

  @override
  String toString() => success
      ? 'ContactResult(success)'
      : 'ContactResult(failure: $error)';
}
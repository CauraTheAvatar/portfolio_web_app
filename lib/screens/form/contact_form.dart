import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:portfolio_web_app/core/constants/app_sizes.dart';
import 'package:portfolio_web_app/core/theme/app_colors.dart';
import 'package:portfolio_web_app/services/formspree_service.dart'; 
import 'package:portfolio_web_app/services/analytics_service.dart'; 

class ContactFormWidget extends StatefulWidget {
  final VoidCallback? onSuccess;
  final VoidCallback? onError;

  const ContactFormWidget({
    super.key,
    this.onSuccess,
    this.onError,
  });

  @override
  State<ContactFormWidget> createState() => _ContactFormWidgetState();
}

class _ContactFormWidgetState extends State<ContactFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  final _honeypotController = TextEditingController();

  final _isSending = false.obs;
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    _honeypotController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    // Check honeypot
    if (_honeypotController.text.isNotEmpty) {
      AnalyticsService.to.logEvent(AnalyticsEvent.contactSubmit, properties: {
        'success': false,
        'error': 'bot_detected',
      });
      return;
    }

    try {
      _isSending.value = true;

      // Use Formspree service to send the form
      final success = await FormspreeService.to.sendContactForm(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        message: _messageController.text.trim(),
        honeypot: _honeypotController.text,
      );

      if (success) {
        // Track success
        AnalyticsService.to.trackFormSubmission(
          formName: 'contact',
          success: true,
        );

        // Show success message
        Get.snackbar(
          'Success',
          'Message sent successfully!',
          backgroundColor: AppColors.gold,
          colorText: AppColors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );

        // Clear form
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();

        widget.onSuccess?.call();
      } else {
        // Track failure
        AnalyticsService.to.trackFormSubmission(
          formName: 'contact',
          success: false,
          errorMessage: FormspreeService.to.lastError.value,
        );

        // Show error message
        Get.snackbar(
          'Error',
          FormspreeService.to.lastError.value.isNotEmpty
              ? FormspreeService.to.lastError.value
              : 'Failed to send message. Please try again.',
          backgroundColor: Colors.red,
          colorText: AppColors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        widget.onError?.call();
      }
    } catch (e) {
      AnalyticsService.to.trackFormSubmission(
        formName: 'contact',
        success: false,
        errorMessage: e.toString(),
      );

      Get.snackbar(
        'Error',
        'An unexpected error occurred. Please try again.',
        backgroundColor: Colors.red,
        colorText: AppColors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      widget.onError?.call();
    } finally {
      _isSending.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Name field
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Full Name',
              hintText: 'Jane Smith',
              prefixIcon: const Icon(Icons.person_outline_rounded),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusS),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusS),
                borderSide: const BorderSide(color: AppColors.gold, width: 2),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),

          const SizedBox(height: AppSizes.spaceXXL),

          // Email field
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email Address',
              hintText: 'jane@example.com',
              prefixIcon: const Icon(Icons.email_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusS),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusS),
                borderSide: const BorderSide(color: AppColors.gold, width: 2),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!GetUtils.isEmail(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),

          const SizedBox(height: AppSizes.spaceXXL),

          // Message field
          TextFormField(
            controller: _messageController,
            maxLines: 5,
            decoration: InputDecoration(
              labelText: 'Message',
              hintText: 'Tell me about your project...',
              prefixIcon: const Icon(Icons.chat_bubble_outline_rounded),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusS),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusS),
                borderSide: const BorderSide(color: AppColors.gold, width: 2),
              ),
              alignLabelWithHint: true,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your message';
              }
              if (value.length < 10) {
                return 'Message must be at least 10 characters';
              }
              return null;
            },
          ),

          const SizedBox(height: AppSizes.spaceS),

          // Honeypot (invisible to users)
          Opacity(
            opacity: 0,
            child: SizedBox(
              height: 0,
              child: TextFormField(
                controller: _honeypotController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                style: const TextStyle(fontSize: 0.1, height: 0.1),
              ),
            ),
          ),

          const SizedBox(height: AppSizes.space4XL),

          // Submit button
          Obx(() => ElevatedButton(
                onPressed: _isSending.value ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.black,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusS),
                  ),
                ),
                child: _isSending.value
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                        ),
                      )
                    : const Text(
                        'Send Message',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              )),
        ],
      ),
    );
  }
}
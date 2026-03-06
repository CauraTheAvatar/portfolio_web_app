import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import 'package:portfolio_web_app/core/constants/app_sizes.dart';
import 'package:portfolio_web_app/core/constants/app_strings.dart';
import 'package:portfolio_web_app/core/responsive/responsive.dart';
import 'package:portfolio_web_app/services/contact_service.dart';
import 'package:portfolio_web_app/controllers/contact_controller.dart';

class ContactSection extends StatelessWidget {

  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screen     = Responsive.of(context);
    Get.put(ContactController());

    return SectionWrapper(
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          // Section header
          _SectionHeader(),

          const SizedBox(height: AppSizes.sectionHeaderGapContent),

          // Contact content — social links + form side by side on desktop
          screen.isMobileOrTablet
              ? _MobileLayout()
              : _DesktopLayout(),

        ],
      ),
    );
  }
}

// Section Header

class _SectionHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Text(
          'GET IN TOUCH',
          style: AppTextStyle.overline,
        ),

        const SizedBox(height: AppSizes.sectionHeaderGapOverline),

        Text(
          AppStrings.contactTitle,
          style: AppTextStyle.sectionTitle,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: AppSizes.sectionHeaderGapRule),

        Container(
          width:  AppSizes.goldRuleWidth,
          height: AppSizes.goldRuleHeight,
          decoration: BoxDecoration(
            color: AppColors.gold,
            borderRadius: BorderRadius.circular(AppSizes.radiusXS),
          ),
        ),

        const SizedBox(height: AppSizes.sectionHeaderGapSubtitle),

        Text(
          AppStrings.contactSubtitle,
          style: AppTextStyle.sectionSubtitle,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: AppSizes.spaceM),

        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.heroParaMaxWidth),
          child: Text(
            AppStrings.contactBody,
            style: AppTextStyle.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),

      ],
    );
  }
}

// Desktop Layout — social info left, form right

class _DesktopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // Left — contact info + socials
        const Expanded(
          flex: 40,
          child: _ContactInfo(),
        ),

        const SizedBox(width: AppSizes.heroColGap),

        // Right — contact form
        const Expanded(
          flex: 60,
          child: _ContactForm(),
        ),

      ],
    );
  }
}

// Mobile Layout — info then form stacked

class _MobileLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _ContactInfo(),
        SizedBox(height: AppSizes.space5XL),
        _ContactForm(),
      ],
    );
  }
}

// Contact Info — email, github, linkedin social links

class _ContactInfo extends StatelessWidget {

  const _ContactInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          'Let\'s connect',
          style: AppTextStyle.cardTitle,
        ),

        const SizedBox(height: AppSizes.spaceM),

        Text(
          'Open to freelance projects, collaborations, and full-time opportunities. '
          'Reach out through the form or connect directly.',
          style: AppTextStyle.bodyMedium,
        ),

        const SizedBox(height: AppSizes.space4XL),

        _SocialLink(
          icon:  Icons.email_rounded,
          label: AppStrings.contactEmailLabel,
          value: AppStrings.contactEmail,
        ),

        const SizedBox(height: AppSizes.spaceXXL),

        _SocialLink(
          icon:  Icons.code_rounded,
          label: AppStrings.contactGithubLabel,
          value: AppStrings.contactGithub,
        ),

        const SizedBox(height: AppSizes.spaceXXL),

        _SocialLink(
          icon:  Icons.link_rounded,
          label: AppStrings.contactLinkedinLabel,
          value: AppStrings.contactLinkedin,
        ),

      ],
    );
  }
}

// Social Link row

class _SocialLink extends StatefulWidget {

  const _SocialLink({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String   label;
  final String   value;

  @override
  State<_SocialLink> createState() => _SocialLinkState();
}

class _SocialLinkState extends State<_SocialLink> {

  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => debugPrint('[Contact] ${widget.value}'),
        child: Row(
          children: [

            AnimatedContainer(
              duration: AppSizes.durationDefault,
              padding: const EdgeInsets.all(AppSizes.spaceM),
              decoration: BoxDecoration(
                color: _hovered
                    ? AppColors.gold.withOpacity(0.12)
                    : AppColors.lightGrey,
                borderRadius: BorderRadius.circular(AppSizes.radiusM),
              ),
              child: Icon(
                widget.icon,
                size:  AppSizes.iconS,
                color: _hovered ? AppColors.gold : AppColors.grey,
              ),
            ),

            const SizedBox(width: AppSizes.spaceL),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.label,
                  style: AppTextStyle.label.copyWith(fontSize: 13),
                ),
                Text(
                  widget.value,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: _hovered ? AppColors.gold : AppColors.grey,
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

// Contact Form
// Stateful — manages field controllers, validation, submission state.

class _ContactForm extends StatefulWidget {

  const _ContactForm();

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {

  ContactController get _ctrl => ContactController.to;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusL),
        border: Border.all(
          color: AppColors.gold.withOpacity(0.35),
          width: AppSizes.borderDefault,
        ),
        boxShadow: [
          BoxShadow(
            color:      Colors.black.withOpacity(0.04),
            blurRadius: AppSizes.cardShadowBlurRest,
            offset:     const Offset(0, 2),
          ),
        ],
      ),
      child: Form(
        key: _ctrl.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // Name field
            _FormField(
              controller: _ctrl.nameCtrl,
              label:      AppStrings.formName,
              hint:       'Jane Smith',
              icon:       Icons.person_outline_rounded,
              validator:  _ctrl.validateName,
            ),

            const SizedBox(height: AppSizes.spaceXXL),

            // Email field
            _FormField(
              controller:   _ctrl.emailCtrl,
              label:        AppStrings.formEmail,
              hint:         'jane@example.com',
              icon:         Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator:    _ctrl.validateEmail,
            ),

            const SizedBox(height: AppSizes.spaceXXL),

            // Message field
            _FormField(
              controller: _ctrl.messageCtrl,
              label:      AppStrings.formMessage,
              hint:       'Tell me about your project...',
              icon:       Icons.chat_bubble_outline_rounded,
              maxLines:   5,
              validator:  _ctrl.validateMessage,
            ),

            // Honeypot — invisible to humans, traps bots
            Opacity(
              opacity: 0,
              child: SizedBox(
                height: 0,
                child: TextFormField(
                  controller:  _ctrl.honeypotCtrl,
                  focusNode:   FocusNode()..skipTraversal = true,
                  autocorrect: false,
                ),
              ),
            ),

            const SizedBox(height: AppSizes.space4XL),

            // Submit button
            Obx(() => _SubmitButton(
              onTap:       _ctrl.submit,
              submitting:  _ctrl.isSending.value,
            )),

          ],
        ),
      ),
    );
  }
}

// Form Field — gold-outlined input with prefix icon

class _FormField extends StatefulWidget {

  const _FormField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    required this.validator,
    this.keyboardType,
    this.maxLines = 1,
  });

  final TextEditingController       controller;
  final String                      label;
  final String                      hint;
  final IconData                    icon;
  final String? Function(String?)   validator;
  final TextInputType?              keyboardType;
  final int                         maxLines;

  @override
  State<_FormField> createState() => _FormFieldState();
}

class _FormFieldState extends State<_FormField> {

  bool _focused = false;
  late final FocusNode _focus;

  @override
  void initState() {
    super.initState();
    _focus = FocusNode()
      ..addListener(() => setState(() => _focused = _focus.hasFocus));
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // Label
        Text(
          widget.label,
          style: AppTextStyle.label.copyWith(fontSize: 13),
        ),

        const SizedBox(height: AppSizes.spaceXS),

        // Input
        TextFormField(
          controller:   widget.controller,
          focusNode:    _focus,
          keyboardType: widget.keyboardType,
          maxLines:     widget.maxLines,
          validator:    widget.validator,
          style:        AppTextStyle.inputText,
          decoration: InputDecoration(
            hintText:    widget.hint,
            hintStyle:   AppTextStyle.inputHint,
            prefixIcon:  widget.maxLines == 1
                ? Icon(
                    widget.icon,
                    size:  AppSizes.iconS,
                    color: _focused ? AppColors.gold : AppColors.grey,
                  )
                : null,
            filled:       true,
            fillColor:    AppColors.lightGrey,
            // Borders — all states
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusS),
              borderSide:   BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusS),
              borderSide: BorderSide(
                color: AppColors.gold.withOpacity(0.3),
                width: AppSizes.borderThin,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusS),
              borderSide: const BorderSide(
                color: AppColors.gold,
                width: AppSizes.borderDefault,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusS),
              borderSide: const BorderSide(
                color: Color(0xFFB00020),
                width: AppSizes.borderThin,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusS),
              borderSide: const BorderSide(
                color: Color(0xFFB00020),
                width: AppSizes.borderDefault,
              ),
            ),
          ),
        ),

      ],
    );
  }
}

// Submit Button — black, hover → gold, loading spinner when submitting

class _SubmitButton extends StatefulWidget {

  const _SubmitButton({
    required this.onTap,
    required this.submitting,
  });

  final VoidCallback onTap;
  final bool         submitting;

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton> {

  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.submitting ? null : widget.onTap,
        child: AnimatedContainer(
          duration: AppSizes.durationDefault,
          height: 52,
          decoration: BoxDecoration(
            color: widget.submitting
                ? AppColors.grey
                : (_hovered ? AppColors.gold : AppColors.black),
            borderRadius: BorderRadius.circular(AppSizes.radiusS),
            boxShadow: _hovered && !widget.submitting
                ? [
                    BoxShadow(
                      color:      AppColors.gold.withOpacity(0.3),
                      blurRadius: AppSizes.shadowBlurM,
                      offset:     const Offset(0, AppSizes.spaceXXS),
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: widget.submitting
                ? const SizedBox(
                    width:  20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                    ),
                  )
                : Text(
                    AppStrings.formSend,
                    style: AppTextStyle.buttonPrimary,
                  ),
          ),
        ),
      ),
    );
  }
}
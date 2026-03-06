import 'package:flutter/material.dart';

class SectionContainer extends StatelessWidget {

  final Widget child;

  const SectionContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      padding: const EdgeInsets.symmetric(
        vertical: 120,
        horizontal: 60,
      ),

      width: double.infinity,

      child: child,

    );
  }
}
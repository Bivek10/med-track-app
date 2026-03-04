import 'package:flutter/material.dart';

import '../../../../core/config/theme/app_colors.dart';

/// A grouped settings section with a coloured header and a white card body.
class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
              color: AppColors.primary,
            ),
          ),
        ),

        // Section body
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.symmetric(
              horizontal: BorderSide(
                color: AppColors.primary.withValues(alpha: 0.05),
              ),
            ),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}

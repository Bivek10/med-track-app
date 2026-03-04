import 'package:flutter/material.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../shared/widgets/organisms/login_page_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MedTrack",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: isDark ? AppColors.slate100 : AppColors.slate900,
          ),
        ),
      ),
      body: SafeArea(child: LoginPageView()),
    );
  }
}

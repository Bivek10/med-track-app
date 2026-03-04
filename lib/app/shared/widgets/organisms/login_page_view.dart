import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/routes/route_path.dart';
import '../../../core/config/theme/app_colors.dart';
import '../../../core/utils/assets/index.dart';
import '../../../core/utils/extension/common_extension.dart';
import '../../../core/utils/extension/context_extension/dialog_extension.dart';
import '../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../molecules/login_input_field.dart';

class LoginPageView extends StatefulWidget {
  const LoginPageView({super.key});

  @override
  State<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  final formKey = GlobalKey<FormBuilderState>();

  void onAuthStateListener(BuildContext context, AuthState state) {
    if (state is AuthFailure) {
      context.showSnackBar(state.message);
    }
  }

  void onSignInButtonPressed() {
    context.push(AppPage.home.toPath);
    // if (formKey.currentState!.saveAndValidate()) {
    //   context.read<AuthBloc>().add(AuthSignIn(userMap: formKey.formValue));
    // }
  }

  void onRegisterButtonPressed() {
    context.push(AppPage.register.toPath);
  }

  @override
  void dispose() {
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      child: Column(
        children: [
          // ── Hero Image ──────────────────────────────────
          Image.asset(
            Assets.authHero,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),

          // ── Content ─────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),

                  // Title
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppColors.slate100 : AppColors.slate900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),

                  // Subtitle
                  Text(
                    "Manage your health and medications with ease",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: isDark ? AppColors.slate400 : AppColors.slate600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  // Form fields
                  LoginInputField(formKey: formKey),
                  const SizedBox(height: 24),

                  // Sign In button
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: onAuthStateListener,
                    builder: (_, state) {
                      return ElevatedButton(
                        onPressed: onSignInButtonPressed,
                        child: const Text("Sign In"),
                      ).withLoading(state is AuthLoading);
                    },
                  ),
                  const SizedBox(height: 24),

                  // OR divider
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: isDark
                              ? AppColors.slate800
                              : AppColors.slate200,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "OR",
                          style: TextStyle(
                            color: AppColors.slate400,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: isDark
                              ? AppColors.slate800
                              : AppColors.slate200,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Continue with Google
                  OutlinedButton(
                    onPressed: () {
                      // TODO: Google sign in
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Google "G" icon
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CustomPaint(
                            painter: _GoogleLogoPainter(),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "Continue with Google",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? AppColors.slate100
                                : AppColors.slate900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Footer — Create Account link
                  Center(
                    child: GestureDetector(
                      onTap: onRegisterButtonPressed,
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                            color: isDark
                                ? AppColors.slate400
                                : AppColors.slate600,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: "Create Account",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom painter that draws the four-colour Google "G" logo.
class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final bluePaint = Paint()..color = const Color(0xFF4285F4);
    final greenPaint = Paint()..color = const Color(0xFF34A853);
    final yellowPaint = Paint()..color = const Color(0xFFFBBC05);
    final redPaint = Paint()..color = const Color(0xFFEA4335);

    final center = Offset(w / 2, h / 2);
    final radius = w / 2;
    final strokeWidth = w * 0.2;

    // Blue arc (top-right)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -0.5,
      -1.8,
      false,
      bluePaint
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth,
    );

    // Green arc (bottom-right)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0.8,
      1.2,
      false,
      greenPaint
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth,
    );

    // Yellow arc (bottom-left)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      2.0,
      0.9,
      false,
      yellowPaint
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth,
    );

    // Red arc (top-left)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -2.3,
      1.0,
      false,
      redPaint
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth,
    );

    // Blue horizontal bar
    canvas.drawRect(
      Rect.fromLTWH(w * 0.5, h * 0.4, w * 0.5, strokeWidth),
      bluePaint..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

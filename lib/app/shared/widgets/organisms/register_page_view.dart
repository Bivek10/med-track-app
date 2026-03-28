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
import '../molecules/register_input_field.dart';

class RegisterPageView extends StatefulWidget {
  const RegisterPageView({super.key});

  @override
  State<RegisterPageView> createState() => _RegisterPageViewState();
}

class _RegisterPageViewState extends State<RegisterPageView> {
  final formKey = GlobalKey<FormBuilderState>();

  void onAuthStateListener(BuildContext context, AuthState state) {
    if (state is AuthFailure) {
      context.showSnackBar(state.message);
    }
    if (state is Authenticated) {
      context.showSnackBar("Registration successful");
      context.go(AppPage.home.toPath);
    }
  }

  void onSignUpButtonPressed() {
    if (formKey.currentState!.saveAndValidate()) {
      context.read<AuthBloc>().add(AuthSignUp(userMap: formKey.currentState!.value));
    }
  }

  void onLoginButtonPressed() {
    context.pop();
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
                    "Create Account",
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
                    "Start managing your health journey today",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: isDark ? AppColors.slate400 : AppColors.slate600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  // Form fields
                  RegisterInputField(formKey: formKey),
                  const SizedBox(height: 24),

                  // Sign Up button
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: onAuthStateListener,
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: onSignUpButtonPressed,
                        child: const Text("Sign Up"),
                      ).withLoading(state is AuthLoading);
                    },
                  ),
                  const SizedBox(height: 32),

                  // Footer — Sign In link
                  Center(
                    child: GestureDetector(
                      onTap: onLoginButtonPressed,
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(
                            color: isDark
                                ? AppColors.slate400
                                : AppColors.slate600,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: "Sign In",
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

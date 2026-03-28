import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../core/config/theme/app_colors.dart';
import '../../../core/validators/auth_validator.dart';
import '../atoms/input_field.dart';

class LoginInputField extends StatelessWidget with AuthValidator {
  final GlobalKey<FormBuilderState> formKey;
  LoginInputField({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      child: Column(
        children: [
          AppFormField(
            name: "email",
            label: "Email Address",
            hintText: "name@example.com",
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: emailValidator,
          ),
          const SizedBox(height: 16),
          AppFormField(
            name: "password",
            label: "Password",
            hintText: "Enter your password",
            obscureText: true,
            textInputAction: TextInputAction.done,
            validator: passwordValidator,
            labelTrailing: GestureDetector(
              onTap: () {
                // TODO: Navigate to forgot password
              },
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

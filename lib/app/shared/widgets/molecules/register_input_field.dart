import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../core/validators/auth_validator.dart';
import '../atoms/input_field.dart';

class RegisterInputField extends StatelessWidget with AuthValidator {
  final GlobalKey<FormBuilderState> formKey;

  RegisterInputField({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      child: Column(
        children: [
          AppFormField(
            name: "full_name",
            label: "Full Name",
            hintText: "Enter your full name",
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: fullNameValidator,
          ),
          const SizedBox(height: 16),
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
            hintText: "Create a password",
            obscureText: true,
            textInputAction: TextInputAction.done,
            validator: passwordValidator,
          ),
        ],
      ),
    );
  }
}

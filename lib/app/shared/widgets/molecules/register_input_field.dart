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
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppFormField(
            name: "full_name",
            hintText: "Enter your full name",
            validator: fullNameValidator,
          ),
          AppFormField(
            name: "email",
            hintText: "Enter email address",
            validator: emailValidator,
          ),
          AppFormField(
            name: "password",
            hintText: "Enter password",
            validator: passwordValidator,
          ),
        ],
      ),
    );
  }
}

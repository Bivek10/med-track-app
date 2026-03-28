import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../core/config/theme/app_colors.dart';
import '../../../core/utils/extension/common_extension.dart';
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
          Row(
            children: [
              Expanded(
                child: AppFormField(
                  name: "firstName",
                  label: "First Name",
                  hintText: "Enter first name",
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: firstNameValidator,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppFormField(
                  name: "lastName",
                  label: "Last Name",
                  hintText: "Enter last name",
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: lastNameValidator,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          FormBuilderDropdown<String>(
            name: 'gender',
            validator: genderValidator,
            decoration: InputDecoration(
              hintText: "Select Gender",
              label: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  "Gender",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.slate100
                            : AppColors.slate900,
                      ),
                ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
            items: ['male', 'female', 'other']
                .map((gender) => DropdownMenuItem(
                      value: gender,
                      child: Text(gender.toUpperCase()),
                    ))
                .toList(),
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

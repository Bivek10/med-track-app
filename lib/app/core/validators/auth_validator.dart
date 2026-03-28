import 'package:flutter/material.dart' show FormFieldValidator;
import 'package:form_builder_validators/form_builder_validators.dart'
    show FormBuilderValidators;

mixin AuthValidator {
  final FormFieldValidator<String> fullNameValidator =
      FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: "full name is required"),
      ]);
  final FormFieldValidator<String> emailValidator =
      FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: "email is required"),
        FormBuilderValidators.email(errorText: "enter a valid email"),
      ]);
  final FormFieldValidator<String> passwordValidator =
      FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: "password is required"),
        FormBuilderValidators.minLength(6,
            errorText: "password must be at least 6 characters"),
      ]);
  final FormFieldValidator<String> firstNameValidator =
      FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: "first name is required"),
      ]);
  final FormFieldValidator<String> lastNameValidator =
      FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: "last name is required"),
      ]);
  final FormFieldValidator<String> genderValidator =
      FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: "gender is required"),
      ]);
}

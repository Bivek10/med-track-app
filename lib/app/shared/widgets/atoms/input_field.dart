import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../core/config/theme/app_colors.dart';

/// A reusable form field widget built on top of [FormBuilderTextField].
///
/// Supports labels, hints, prefix/suffix icons, password visibility toggle,
/// and validators. It reads its base decoration from the current theme's
/// [InputDecorationTheme] and merges in any overrides you pass.
class AppFormField extends StatefulWidget {
  /// The form-builder field name (used as the key in the form value map).
  final String name;

  /// Optional label rendered above the input.
  final String? label;

  /// Optional trailing widget next to the label (e.g. "Forgot Password?" link).
  final Widget? labelTrailing;

  /// Hint text shown inside the input when it is empty.
  final String? hintText;

  /// Icon shown at the leading edge of the input.
  final IconData? prefixIcon;

  /// Custom suffix widget (takes precedence over the built-in obscure toggle).
  final Widget? suffixIcon;

  /// When `true`, the field shows a visibility toggle and obscures text.
  final bool obscureText;

  /// Validation function compatible with `FormBuilderTextField.validator`.
  final FormFieldValidator<String>? validator;

  /// Keyboard type.
  final TextInputType? keyboardType;

  /// Initial value for the field.
  final String? initialValue;

  /// Text input action (e.g. next, done).
  final TextInputAction? textInputAction;

  /// Whether the field is enabled.
  final bool enabled;

  /// Max lines for the text field.
  final int maxLines;

  const AppFormField({
    super.key,
    required this.name,
    this.label,
    this.labelTrailing,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
    this.initialValue,
    this.textInputAction,
    this.enabled = true,
    this.maxLines = 1,
  });

  @override
  State<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  late bool _obscured;

  @override
  void initState() {
    super.initState();
    _obscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Label row ──────────────────────────────────────
        if (widget.label != null || widget.labelTrailing != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.label != null)
                  Text(
                    widget.label!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: theme.brightness == Brightness.dark
                          ? AppColors.slate100
                          : AppColors.slate900,
                    ),
                  ),
                if (widget.labelTrailing != null) widget.labelTrailing!,
              ],
            ),
          ),

        // ── Input field ────────────────────────────────────
        FormBuilderTextField(
          name: widget.name,
          initialValue: widget.initialValue,
          obscureText: _obscured,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          enabled: widget.enabled,
          maxLines: widget.maxLines,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.brightness == Brightness.dark
                ? AppColors.slate100
                : AppColors.slate900,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon, size: 20, color: AppColors.slate400)
                : null,
            suffixIcon: _buildSuffix(),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget? _buildSuffix() {
    if (widget.suffixIcon != null) return widget.suffixIcon;

    if (widget.obscureText) {
      return GestureDetector(
        onTap: () => setState(() => _obscured = !_obscured),
        child: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Icon(
            _obscured
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            size: 22,
            color: AppColors.slate400,
          ),
        ),
      );
    }

    return null;
  }
}

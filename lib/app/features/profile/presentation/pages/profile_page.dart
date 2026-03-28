import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../shared/widgets/atoms/input_field.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final List<String> _conditions = ["Hypertension", "Type 2 Diabetes"];

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(const AuthStatus());
  }

  void _removeCondition(int index) {
    setState(() {
      _conditions.removeAt(index);
    });
  }

  void _addCondition() {
    // Basic dialog to add a new condition
    showDialog(
      context: context,
      builder: (ctx) {
        String newCondition = "";
        return AlertDialog(
          title: const Text("Add Condition"),
          content: TextField(
            onChanged: (val) => newCondition = val,
            decoration: const InputDecoration(hintText: "Enter condition name"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (newCondition.isNotEmpty) {
                  setState(() {
                    _conditions.add(newCondition);
                  });
                }
                Navigator.pop(ctx);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final isUpdating = state is Authenticated && state.isUpdating;

        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is AuthFailure) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Error: ${state.message}"),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<AuthBloc>().add(const AuthStatus()),
                    child: const Text("Retry"),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is Authenticated || state is AuthSuccess) {
          final user = state is Authenticated
              ? state.user
              : (context.read<AuthBloc>().state as Authenticated).user;

          return Scaffold(
            appBar: AppBar(
              title: const Text("My Health Profile"),
              actions: [
                IconButton(
                  onPressed: isUpdating
                      ? null
                      : () {
                          if (_formKey.currentState?.saveAndValidate() ??
                              false) {
                            final values = _formKey.currentState!.value;
                            final fullName =
                                (values['full_name'] as String? ?? "").trim();
                            final nameParts = fullName.split(' ');
                            final firstName = nameParts.first;
                            final lastName = nameParts.length > 1
                                ? nameParts.sublist(1).join(' ')
                                : "";

                            final weightStr = values['weight'] as String? ?? "";
                            final formattedWeight = weightStr.isEmpty
                                ? ""
                                : weightStr.contains('kg')
                                    ? weightStr
                                    : "${weightStr}kg";

                            context.read<AuthBloc>().add(
                                  AuthUpdateProfile(
                                    userMap: {
                                      "firstName": firstName,
                                      "lastName": lastName,
                                      "gender": values['gender'],
                                      "age":
                                          int.tryParse(values['age'].toString()),
                                      "weight": formattedWeight,
                                      "emergencyContactName":
                                          values['emergency_name'],
                                      "emergencyContactNumber":
                                          values['emergency_phone'],
                                      "image": user.profile,
                                    },
                                  ),
                                );
                          }
                        },
                  icon: isUpdating
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.primary,
                          ),
                        )
                      : const Icon(Icons.check, color: AppColors.primary),
                ),
              ],
            ),
            body: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else if (state is Authenticated && state.message != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message!),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else if (state is AuthFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // ── Avatar Section ──────────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Column(
                        children: [
                          // Profile picture
                          Stack(
                            children: [
                              Container(
                                width: 128,
                                height: 128,
                                decoration: BoxDecoration(
                                  color: AppColors.slate200,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: AppColors.white, width: 4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.black
                                          .withValues(alpha: 0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: user.profile.isNotEmpty
                                    ? ClipOval(
                                        child: Image.network(
                                          user.profile,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error,
                                                  stackTrace) =>
                                              const Icon(
                                            Icons.person,
                                            size: 64,
                                            color: AppColors.slate400,
                                          ),
                                        ),
                                      )
                                    : const Icon(
                                        Icons.person,
                                        size: 64,
                                        color: AppColors.slate400,
                                      ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    // TODO: pick image
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: AppColors.white, width: 2),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.primary
                                              .withValues(alpha: 0.3),
                                          blurRadius: 6,
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt,
                                      color: AppColors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            user.fullname,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user.email,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.slate500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ── Form ────────────────────────────────────────
                    FormBuilder(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            // ── Personal Information ──────────────────
                            _SectionCard(
                              icon: Icons.person_outline,
                              title: "Personal Information",
                              children: [
                                AppFormField(
                                  name: "full_name",
                                  label: "Full Name",
                                  hintText: "Enter your full name",
                                  initialValue: user.fullname,
                                  textInputAction: TextInputAction.next,
                                ),
                                const SizedBox(height: 16),
                                AppFormField(
                                  name: "age",
                                  label: "Age",
                                  hintText: "Enter your age",
                                  initialValue: user.age?.toString() ?? "",
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                ),
                                const SizedBox(height: 16),
                                // Gender dropdown
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Gender",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.slate900,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    FormBuilderDropdown<String>(
                                      name: "gender",
                                      initialValue: user.gender ?? "male",
                                      decoration: const InputDecoration(
                                        hintText: "Select gender",
                                      ),
                                      items: const [
                                        DropdownMenuItem(
                                          value: "male",
                                          child: Text("Male"),
                                        ),
                                        DropdownMenuItem(
                                          value: "female",
                                          child: Text("Female"),
                                        ),
                                        DropdownMenuItem(
                                          value: "other",
                                          child: Text("Other"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                AppFormField(
                                  name: "weight",
                                  label: "Weight (kg)",
                                  hintText: "Enter your weight",
                                  initialValue: user.weight?.toString() ?? "",
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // ── Medical Conditions ────────────────────
                            _SectionCard(
                              icon: Icons.medical_services_outlined,
                              title: "Medical Conditions",
                              children: [
                                // Condition chips
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    for (int i = 0; i < _conditions.length; i++)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary
                                              .withValues(alpha: 0.1),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              _conditions[i],
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.primary,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            GestureDetector(
                                              onTap: () => _removeCondition(i),
                                              child: const Icon(
                                                Icons.close,
                                                size: 16,
                                                color: AppColors.primary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                    // Add button
                                    GestureDetector(
                                      onTap: _addCondition,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColors.slate300,
                                            width: 2,
                                            style: BorderStyle.solid,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.add,
                                              size: 16,
                                              color: AppColors.slate500,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              "Add Condition",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.slate500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                AppFormField(
                                  name: "medical_notes",
                                  label: "Additional Medical Notes",
                                  hintText:
                                      "Enter any allergies or important health notes...",
                                  maxLines: 3,
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // ── Emergency Contact ─────────────────────
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: const Color(0xFFFEE2E2),
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        AppColors.black.withValues(alpha: 0.03),
                                    blurRadius: 4,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.emergency_outlined,
                                        color: Color(0xFFEF4444),
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        "Emergency Contact",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  AppFormField(
                                    name: "emergency_name",
                                    label: "Contact Name",
                                    hintText: "Enter emergency contact name",
                                    initialValue:
                                        user.emergencyContactName ?? "",
                                    textInputAction: TextInputAction.next,
                                  ),
                                  const SizedBox(height: 16),
                                  AppFormField(
                                    name: "emergency_phone",
                                    label: "Phone Number",
                                    hintText: "Enter phone number",
                                    initialValue:
                                        user.emergencyContactNumber ?? "",
                                    keyboardType: TextInputType.phone,
                                    textInputAction: TextInputAction.done,
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 56,
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        // TODO: call emergency contact
                                      },
                                      icon: const Icon(
                                        Icons.call,
                                        color: AppColors.white,
                                      ),
                                      label:
                                          const Text("Call Emergency Contact"),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFFEF4444),
                                        foregroundColor: AppColors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 24),

                            // ── Save Button ───────────────────────────
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: isUpdating
                                    ? null
                                    : () {
                                        if (_formKey.currentState
                                                ?.saveAndValidate() ??
                                            false) {
                                          final values =
                                              _formKey.currentState!.value;
                                          final fullName =
                                              (values['full_name'] as String? ??
                                                      "")
                                                  .trim();
                                          final nameParts = fullName.split(' ');
                                          final firstName = nameParts.first;
                                          final lastName = nameParts.length > 1
                                              ? nameParts.sublist(1).join(' ')
                                              : "";

                                          final weightStr =
                                              values['weight'] as String? ?? "";
                                          final formattedWeight =
                                              weightStr.isEmpty
                                                  ? ""
                                                  : weightStr.contains('kg')
                                                      ? weightStr
                                                      : "${weightStr}kg";

                                          context.read<AuthBloc>().add(
                                                AuthUpdateProfile(
                                                  userMap: {
                                                    "firstName": firstName,
                                                    "lastName": lastName,
                                                    "gender": values['gender'],
                                                    "age": int.tryParse(
                                                        values['age']
                                                            .toString()),
                                                    "weight": formattedWeight,
                                                    "emergencyContactName":
                                                        values[
                                                            'emergency_name'],
                                                    "emergencyContactNumber":
                                                        values[
                                                            'emergency_phone'],
                                                    "image": user.profile,
                                                  },
                                                ),
                                              );
                                        }
                                      },
                                child: isUpdating
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: AppColors.white,
                                        ),
                                      )
                                    : const Text(
                                        "Save Changes",
                                        style: TextStyle(fontSize: 18),
                                      ),
                              ),
                            ),

                            const SizedBox(height: 16),
                            // ── Logout Button ───────────────────────────
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: const Text("Logout"),
                                      content: const Text(
                                          "Are you sure you want to logout?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(ctx),
                                          child: const Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(ctx);
                                            context
                                                .read<AuthBloc>()
                                                .add(const AuthSignOut());
                                          },
                                          child: const Text("Logout",
                                              style: TextStyle(
                                                  color: Colors.red)),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                icon:
                                    const Icon(Icons.logout, color: Colors.red),
                                label: const Text(
                                  "Log Out",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.red),
                                ),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.red),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 48),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return const Scaffold(
          body: Center(child: Text("Please sign in to view your profile")),
        );
      },
    );
  }
}

/// A white card with an icon + title header row and content below.
class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<Widget> children;

  const _SectionCard({
    required this.icon,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.03),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }
}

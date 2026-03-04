import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/routes/route_path.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_tile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: AppColors.primary, size: 22),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Account Card ────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.05),
                  ),
                ),
                child: Row(
                  children: [
                    // Avatar
                    Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          "JD",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Name & email
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "John Doe",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "john.doe@example.com",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.slate500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Edit button
                    GestureDetector(
                      onTap: () {
                        context.push(AppPage.profile.toPath);
                        // TODO: navigate to profile edit
                      },
                      child: Text(
                        "Edit",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── General Section ─────────────────────────────
            SettingsSection(
              title: "General",
              children: [
                SettingsTile(
                  icon: Icons.notifications_outlined,
                  title: "Notifications",
                  subtitle: "Medication intake reminders",
                  trailing: Switch(
                    value: _notificationsEnabled,
                    onChanged: (v) =>
                        setState(() => _notificationsEnabled = v),
                    activeTrackColor: AppColors.primary,
                  ),
                ),
                SettingsTile(
                  icon: Icons.volume_up_outlined,
                  title: "Reminder Sound",
                  subtitle: "Crystal (Default)",
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: AppColors.slate400,
                  ),
                  onTap: () {
                    // TODO: reminder sound picker
                  },
                ),
                SettingsTile(
                  icon: Icons.snooze_outlined,
                  title: "Snooze Duration",
                  subtitle: "10 minutes",
                  showBorder: false,
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: AppColors.slate400,
                  ),
                  onTap: () {
                    // TODO: snooze picker
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ── Data & Sync Section ─────────────────────────
            SettingsSection(
              title: "Data & Sync",
              children: [
                SettingsTile(
                  icon: Icons.cloud_done_outlined,
                  title: "Cloud Sync",
                  subtitle: "Last synced: 2 mins ago",
                  trailing: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCFCE7),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Text(
                      "ACTIVE",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF16A34A),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                SettingsTile(
                  icon: Icons.storage_outlined,
                  title: "Export Data",
                  subtitle: "PDF or CSV format",
                  showBorder: false,
                  trailing: const Icon(
                    Icons.download_outlined,
                    color: AppColors.slate400,
                  ),
                  onTap: () {
                    // TODO: export data
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ── Logout Button ───────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // TODO: logout
                  },
                  icon: const Icon(Icons.logout, color: Color(0xFFEF4444)),
                  label: const Text(
                    "Logout from Account",
                    style: TextStyle(
                      color: Color(0xFFEF4444),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.white,
                    side: const BorderSide(color: Color(0xFFFEE2E2)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ── Version ─────────────────────────────────────
            Center(
              child: Text(
                "MEDTRACK V2.4.0",
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.slate400,
                  letterSpacing: 2,
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

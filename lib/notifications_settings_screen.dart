import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/responsive_helper.dart';

class NotificationsSettingsScreen extends StatefulWidget {
  const NotificationsSettingsScreen({super.key});

  @override
  State<NotificationsSettingsScreen> createState() => _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState extends State<NotificationsSettingsScreen> {
  static const Color primaryColor = Color(0xFF06A8E8);
  static const Color secondaryColor = Color(0xFF00C9D7);

  bool enableNotifications = true;
  bool quizReminders = true;
  bool dailyMissions = true;
  bool achievements = true;
  bool newQuestions = false;
  bool soundEnabled = true;
  bool vibrationEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      enableNotifications = prefs.getBool('enableNotifications') ?? true;
      quizReminders = prefs.getBool('quizReminders') ?? true;
      dailyMissions = prefs.getBool('dailyMissions') ?? true;
      achievements = prefs.getBool('achievements') ?? true;
      newQuestions = prefs.getBool('newQuestions') ?? false;
      soundEnabled = prefs.getBool('soundEnabled') ?? true;
      vibrationEnabled = prefs.getBool('vibrationEnabled') ?? true;
    });
  }

  Future<void> _saveSetting(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Settings saved',
            style: GoogleFonts.poppins(),
          ),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Notifications',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ResponsiveContainer(
        maxWidth: 800,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header with gradient
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(bottom: 40),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [primaryColor, secondaryColor],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                      ),
                      child: Icon(
                        PhosphorIcons.bell(PhosphorIconsStyle.fill),
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Notification Settings',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Manage your notification preferences',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: ResponsiveHelper.padding(context, mobile: 20, tablet: 24, desktop: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    
                    // Main Toggle
                    _buildMainToggle(
                      title: 'Enable Notifications',
                      subtitle: 'Turn on/off all notifications',
                      value: enableNotifications,
                      icon: PhosphorIcons.bellRinging(PhosphorIconsStyle.fill),
                      color: primaryColor,
                      onChanged: (value) {
                        setState(() {
                          enableNotifications = value;
                        });
                        _saveSetting('enableNotifications', value);
                      },
                    ),

                    const SizedBox(height: 24),
                    Text(
                      'Notification Types',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 12),

                    _buildToggleCard(
                      title: 'Quiz Reminders',
                      subtitle: 'Remind me to take quizzes',
                      value: quizReminders && enableNotifications,
                      icon: PhosphorIcons.alarm(PhosphorIconsStyle.bold),
                      color: Colors.blue,
                      enabled: enableNotifications,
                      onChanged: (value) {
                        setState(() {
                          quizReminders = value;
                        });
                        _saveSetting('quizReminders', value);
                      },
                    ),

                    const SizedBox(height: 12),
                    _buildToggleCard(
                      title: 'Daily Missions',
                      subtitle: 'Get notified about new missions',
                      value: dailyMissions && enableNotifications,
                      icon: PhosphorIcons.target(PhosphorIconsStyle.bold),
                      color: Colors.orange,
                      enabled: enableNotifications,
                      onChanged: (value) {
                        setState(() {
                          dailyMissions = value;
                        });
                        _saveSetting('dailyMissions', value);
                      },
                    ),

                    const SizedBox(height: 12),
                    _buildToggleCard(
                      title: 'Achievements',
                      subtitle: 'Celebrate your milestones',
                      value: achievements && enableNotifications,
                      icon: PhosphorIcons.trophy(PhosphorIconsStyle.bold),
                      color: Colors.amber.shade700,
                      enabled: enableNotifications,
                      onChanged: (value) {
                        setState(() {
                          achievements = value;
                        });
                        _saveSetting('achievements', value);
                      },
                    ),

                    const SizedBox(height: 12),
                    _buildToggleCard(
                      title: 'New Questions',
                      subtitle: 'When new quiz questions are added',
                      value: newQuestions && enableNotifications,
                      icon: PhosphorIcons.sparkle(PhosphorIconsStyle.bold),
                      color: Colors.purple,
                      enabled: enableNotifications,
                      onChanged: (value) {
                        setState(() {
                          newQuestions = value;
                        });
                        _saveSetting('newQuestions', value);
                      },
                    ),

                    const SizedBox(height: 24),
                    Text(
                      'Notification Style',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 12),

                    _buildToggleCard(
                      title: 'Sound',
                      subtitle: 'Play sound for notifications',
                      value: soundEnabled && enableNotifications,
                      icon: PhosphorIcons.speakerHigh(PhosphorIconsStyle.bold),
                      color: Colors.green,
                      enabled: enableNotifications,
                      onChanged: (value) {
                        setState(() {
                          soundEnabled = value;
                        });
                        _saveSetting('soundEnabled', value);
                      },
                    ),

                    const SizedBox(height: 12),
                    _buildToggleCard(
                      title: 'Vibration',
                      subtitle: 'Vibrate on notifications',
                      value: vibrationEnabled && enableNotifications,
                      icon: PhosphorIcons.vibrate(PhosphorIconsStyle.bold),
                      color: Colors.teal,
                      enabled: enableNotifications,
                      onChanged: (value) {
                        setState(() {
                          vibrationEnabled = value;
                        });
                        _saveSetting('vibrationEnabled', value);
                      },
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainToggle({
    required String title,
    required String subtitle,
    required bool value,
    required IconData icon,
    required Color color,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color,
            color.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: Colors.white.withOpacity(0.5),
            inactiveThumbColor: Colors.white.withOpacity(0.7),
            inactiveTrackColor: Colors.white.withOpacity(0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleCard({
    required String title,
    required String subtitle,
    required bool value,
    required IconData icon,
    required Color color,
    required bool enabled,
    required ValueChanged<bool> onChanged,
  }) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: value ? color.withOpacity(0.3) : Colors.grey.shade200,
            width: value ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: value,
              onChanged: enabled ? onChanged : null,
              activeColor: color,
              activeTrackColor: color.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}


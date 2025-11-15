import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'utils/responsive_helper.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  static const Color primaryColor = Color(0xFF06A8E8);
  static const Color secondaryColor = Color(0xFF00C9D7);

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
          'Privacy Policy',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ResponsiveContainer(
        maxWidth: 900,
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
                        PhosphorIcons.shield(PhosphorIconsStyle.fill),
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Privacy Policy',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Last updated: November 15, 2024',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: ResponsiveHelper.padding(context, mobile: 24, tablet: 32, desktop: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection(
                      title: '1. Information We Collect',
                      content:
                          'IQ Easy Quiz collects minimal information to provide you with the best quiz experience:\n\n'
                          '• Personal Information: Your name, age, and gender that you provide during registration\n'
                          '• Usage Data: Quiz results, scores, and progress to track your learning journey\n'
                          '• Device Information: Basic device information to optimize app performance\n'
                          '• Custom Questions: Questions you create are stored locally on your device',
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      title: '2. How We Use Your Information',
                      content:
                          'We use the collected information for:\n\n'
                          '• Personalizing your quiz experience\n'
                          '• Tracking your progress and achievements\n'
                          '• Improving app functionality and user experience\n'
                          '• Sending notifications about daily missions and achievements (if enabled)\n'
                          '• Storing your custom questions locally',
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      title: '3. Data Storage',
                      content:
                          'Your data is stored securely:\n\n'
                          '• All personal data is stored locally on your device using SharedPreferences\n'
                          '• Quiz history is stored in a local Isar database\n'
                          '• Custom questions are saved locally and not shared with any server\n'
                          '• We do not send your personal information to any third-party servers',
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      title: '4. Data Security',
                      content:
                          'We take data security seriously:\n\n'
                          '• All data is encrypted and stored securely on your device\n'
                          '• No sensitive information is transmitted over the internet\n'
                          '• Quiz questions from Open Trivia Database are fetched securely via HTTPS\n'
                          '• Your data remains under your control at all times',
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      title: '5. Third-Party Services',
                      content:
                          'The app uses the following third-party services:\n\n'
                          '• Open Trivia Database (opentdb.com) for quiz questions\n'
                          '• Google Fonts for typography\n'
                          '• No analytics or tracking services are used\n'
                          '• No advertising networks are integrated',
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      title: '6. Your Rights',
                      content:
                          'You have full control over your data:\n\n'
                          '• Access: View all your data through the app settings\n'
                          '• Modify: Edit your profile information at any time\n'
                          '• Delete: Clear all your data by logging out\n'
                          '• Export: Your custom questions can be viewed in the My Questions section',
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      title: '7. Children\'s Privacy',
                      content:
                          'The app is designed for users aged 6 and above. We:\n\n'
                          '• Do not collect personal information from children without consent\n'
                          '• Require age verification during registration\n'
                          '• Encourage parental supervision for younger users\n'
                          '• Do not share any data with third parties',
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      title: '8. Changes to Privacy Policy',
                      content:
                          'We may update this privacy policy from time to time. Changes will be:\n\n'
                          '• Notified within the app\n'
                          '• Updated with a new "Last updated" date\n'
                          '• Available for review at any time in Settings\n'
                          '• Effective immediately upon posting',
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      title: '9. Contact Us',
                      content:
                          'If you have any questions about this Privacy Policy, please contact us:\n\n'
                          '• Email: support@iqeasyquiz.com\n'
                          '• Through the app feedback option\n'
                          '• We typically respond within 24-48 hours',
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            primaryColor.withOpacity(0.1),
                            secondaryColor.withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: primaryColor.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            PhosphorIcons.info(PhosphorIconsStyle.fill),
                            color: primaryColor,
                            size: 32,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'By using IQ Easy Quiz, you agree to this Privacy Policy and our data practices.',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            content,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey.shade600,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}


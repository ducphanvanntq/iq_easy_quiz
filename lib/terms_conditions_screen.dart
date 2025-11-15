import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'utils/responsive_helper.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

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
          'Terms & Conditions',
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
                        PhosphorIcons.fileText(PhosphorIconsStyle.fill),
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Terms & Conditions',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Effective Date: November 15, 2024',
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
                      title: '1. Acceptance of Terms',
                      content:
                          'By downloading, installing, or using IQ Easy Quiz, you agree to be bound by these Terms and Conditions. If you do not agree to these terms, please do not use the app.\n\n'
                          '• These terms apply to all users of the app\n'
                          '• You must be at least 6 years old to use this app\n'
                          '• Parents or guardians must supervise children under 13',
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      title: '2. Use of the App',
                      content:
                          'IQ Easy Quiz grants you a limited, non-exclusive, non-transferable license to use the app for personal, non-commercial purposes:\n\n'
                          '• The app is provided for educational and entertainment purposes\n'
                          '• You may create custom quiz questions for personal use\n'
                          '• You may not modify, reverse engineer, or decompile the app\n'
                          '• You may not use the app for any illegal purposes',
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      title: '3. User Account',
                      content:
                          'When you create an account:\n\n'
                          '• You agree to provide accurate and complete information\n'
                          '• You are responsible for maintaining the confidentiality of your account\n'
                          '• You agree to notify us immediately of any unauthorized use\n'
                          '• You may delete your account at any time through the logout function',
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      title: '4. User-Generated Content',
                      content:
                          'When you create custom quiz questions:\n\n'
                          '• You retain ownership of your custom questions\n'
                          '• You are responsible for the content you create\n'
                          '• Questions must not contain offensive, inappropriate, or illegal content\n'
                          '• We reserve the right to remove content that violates these terms\n'
                          '• Custom questions are stored locally on your device',
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      title: '5. Quiz Content',
                      content:
                          'Quiz questions are sourced from:\n\n'
                          '• Open Trivia Database (opentdb.com) under Creative Commons license\n'
                          '• User-generated custom questions\n'
                          '• We strive for accuracy but do not guarantee the correctness of all questions\n'
                          '• Quiz content is provided "as is" without warranties',
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      title: '6. Points and Rewards',
                      content:
                          'The points system in IQ Easy Quiz:\n\n'
                          '• Points are earned by completing quizzes and missions\n'
                          '• Points have no monetary value and cannot be exchanged for cash\n'
                          '• We reserve the right to modify the points system at any time\n'
                          '• Points are stored locally and cannot be transferred between devices',
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      title: '7. Intellectual Property',
                      content:
                          'All rights, title, and interest in the app:\n\n'
                          '• The app design, logo, and interface are owned by IQ Easy Quiz\n'
                          '• Third-party quiz content is attributed to Open Trivia Database\n'
                          '• You may not copy, modify, or distribute the app without permission\n'
                          '• Trademarks and logos are property of their respective owners',
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      title: '8. Disclaimer of Warranties',
                      content:
                          'The app is provided "as is" without warranties of any kind:\n\n'
                          '• We do not guarantee uninterrupted or error-free operation\n'
                          '• We are not responsible for any loss of data\n'
                          '• Quiz results are for educational purposes only\n'
                          '• We do not guarantee the accuracy of quiz questions',
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      title: '9. Limitation of Liability',
                      content:
                          'To the maximum extent permitted by law:\n\n'
                          '• We are not liable for any indirect, incidental, or consequential damages\n'
                          '• Our total liability shall not exceed the amount you paid for the app (if any)\n'
                          '• We are not responsible for third-party content or services\n'
                          '• Some jurisdictions do not allow these limitations',
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      title: '10. Modifications to Terms',
                      content:
                          'We reserve the right to modify these terms at any time:\n\n'
                          '• Changes will be posted within the app\n'
                          '• Continued use of the app constitutes acceptance of new terms\n'
                          '• Material changes will be notified through the app\n'
                          '• You should review these terms periodically',
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      title: '11. Termination',
                      content:
                          'We may terminate or suspend your access:\n\n'
                          '• If you violate these terms and conditions\n'
                          '• If you engage in harmful or fraudulent activities\n'
                          '• For any reason at our sole discretion\n'
                          '• You may terminate by deleting the app and your account',
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      title: '12. Contact Information',
                      content:
                          'For questions about these Terms and Conditions:\n\n'
                          '• Email: support@iqeasyquiz.com\n'
                          '• Response time: 24-48 hours\n'
                          '• Available through app feedback section',
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
                            PhosphorIcons.handshake(PhosphorIconsStyle.fill),
                            color: primaryColor,
                            size: 32,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'Thank you for using IQ Easy Quiz! By using this app, you acknowledge that you have read and understood these Terms and Conditions.',
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


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/theme/colors.dart' as theme_colors;
import 'package:frontend/theme/texts.dart' as theme_texts;
import 'package:url_launcher/url_launcher.dart';
import 'package:frontend/config/app_config.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      debugPrint('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(32.0),
      decoration: BoxDecoration(
        color: theme_colors.kPortfolioSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme_colors.kPortfolioBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _SocialIcon(
                icon: FontAwesomeIcons.github,
                onTap: () => _launchURL(AppConfig.githubUrl), 
              ),
              _SocialIcon(
                icon: FontAwesomeIcons.linkedin,
                onTap: () => _launchURL(AppConfig.linkedinUrl), 
              ),
              _SocialIcon(
                icon: Icons.email_outlined,
                onTap: () {
                  Clipboard.setData(ClipboardData(text: AppConfig.emailAddress)).then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Email copied to clipboard!'),
                        behavior: SnackBarBehavior.floating,
                        width: 250,
                      ),
                    );
                  });
                },
              ),
              _SocialIcon(
                icon: FontAwesomeIcons.solidFileLines, // CV Icon
                onTap: () => _launchURL(AppConfig.cvUrl), 
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "About me",
                      style: textTheme.headlineMedium?.copyWith(
                        color: theme_colors.kPortfolioTextPrimary,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      theme_texts.aboutMe,
                      style: textTheme.bodyLarge?.copyWith(
                        color: theme_colors.kPortfolioTextSecondary,
                        fontSize: 18.0,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                flex: 3,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset(
                      AppConfig.profileImagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback to placeholder if image fails to load
                        return Container(
                          decoration: BoxDecoration(
                            color: theme_colors.kPortfolioBorder,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.person_outline,
                              size: 48,
                              color: theme_colors.kPortfolioTextSecondary,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SocialIcon({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: IconButton(
        onPressed: onTap,
        icon: FaIcon(icon),
        color: theme_colors.kPortfolioTextSecondary,
        hoverColor: theme_colors.kPortfolioAccent.withOpacity(0.1),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/project.dart';
import '../theme/colors.dart' as theme_colors;

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final videoUrl = project.videoUrl;

    return Card(
      elevation: 0,
      color: theme_colors.kPortfolioSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: theme_colors.kPortfolioBorder, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(project.title, style: textTheme.titleLarge?.copyWith(color: theme_colors.kPortfolioTextPrimary)),
                if (project.githubUrl != null && project.githubUrl!.isNotEmpty)
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.github, size: 20),
                    onPressed: () => _launchUrl(project.githubUrl!),
                    color: theme_colors.kPortfolioTextSecondary,
                    splashRadius: 20,
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Center(child: _buildMedia(videoUrl)),
            ),
            Text(
              project.description,
              style: textTheme.bodyMedium?.copyWith(color: theme_colors.kPortfolioTextSecondary.withOpacity(0.9)),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: project.tags.map((tag) => _TagBubble(text: tag)).toList(),
            )
          ],
        ),
      ),
    );
  }

   Widget _buildMedia(String? videoUrl) {
    if (videoUrl != null && videoUrl.isNotEmpty) {
      // It's a GIF
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: AspectRatio(
          aspectRatio: 12/6.5,
          child: Image.network(
            videoUrl,
            fit: BoxFit.fitWidth,
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox.shrink(); // Return empty space on error
            },
          ),
        ),
      );
    } else {
      // Not a GIF or URL is empty, return empty space
      return const SizedBox.shrink();
    }
  }
}

class _TagBubble extends StatelessWidget {
  final String text;

  const _TagBubble({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: theme_colors.kPortfolioTagBackground,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        text.toUpperCase(),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: theme_colors.kPortfolioTagText, fontWeight: FontWeight.w500),
      ),
    );
  }
}
      


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/experience.dart';
import '../theme/colors.dart' as theme_colors;

class ExperienceCard extends StatelessWidget {
  final Experience experience;

  const ExperienceCard({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final dateFormat = DateFormat('MMM yyyy');
    final dateText = '${dateFormat.format(experience.startDate)} - ${experience.endDate != null ? dateFormat.format(experience.endDate!) : 'Present'}';

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    experience.photoUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 80,
                        height: 80,
                        color: theme_colors.kPortfolioBackground,
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: theme_colors.kPortfolioTextSecondary.withOpacity(0.5),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(experience.title, style: textTheme.titleLarge?.copyWith(color: theme_colors.kPortfolioTextPrimary)),
                      const SizedBox(height: 4),
                      Text(experience.company, style: textTheme.titleMedium),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: [
                          _InfoBubble(
                            icon: Icons.location_on_outlined,
                            text: experience.location,
                          ),
                          _InfoBubble(
                            icon: Icons.calendar_today_outlined,
                            text: dateText,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              experience.description,
              style: textTheme.bodyMedium?.copyWith(color: theme_colors.kPortfolioTextSecondary.withOpacity(0.9)),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: experience.tags.map((tag) => _TagBubble(text: tag)).toList(),
            )
          ],
        ),
      ),
    );
  }
}

class _InfoBubble extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoBubble({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: theme_colors.kPortfolioBackground,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: theme_colors.kPortfolioTextSecondary.withOpacity(0.7)),
          const SizedBox(width: 6),
          Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: theme_colors.kPortfolioTextSecondary.withOpacity(0.9)),
          ),
        ],
      ),
    );
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


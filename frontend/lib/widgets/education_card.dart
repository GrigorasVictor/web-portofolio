import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/education.dart';
import '../theme/colors.dart' as theme_colors;

class EducationCard extends StatelessWidget {
  final Education education;

  const EducationCard({super.key, required this.education});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final dateFormat = DateFormat('MMM yyyy');

    return Card(
      elevation: 0,
      color: theme_colors.kPortfolioSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: theme_colors.kPortfolioBorder, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                education.photoUrl,
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
                  Text(education.degree, style: textTheme.titleLarge?.copyWith(color: theme_colors.kPortfolioTextPrimary)),
                  const SizedBox(height: 4),
                  Text(education.institution, style: textTheme.titleMedium),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: [
                      _InfoBubble(
                        icon: Icons.location_on_outlined,
                        text: education.location,
                      ),
                      _InfoBubble(
                        icon: Icons.calendar_today_outlined,
                        text: '${dateFormat.format(education.startDate)} - ${dateFormat.format(education.endDate)}',
                      ),
                    ],
                  ),
                ],
              ),
            ),
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

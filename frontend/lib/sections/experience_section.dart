import 'package:flutter/material.dart';
import '../models/experience.dart';
import '../widgets/experience_card.dart';
import '../theme/colors.dart' as theme_colors;

class ExperienceSection extends StatelessWidget {
  final List<Experience>? experiences;
  const ExperienceSection({super.key, required this.experiences});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Experience',
          style: textTheme.displaySmall?.copyWith(color: theme_colors.kPortfolioTextPrimary),
        ),
        const SizedBox(height: 40),
        if (experiences == null)
          _LoadingCard()
        else if (experiences!.isEmpty)
          _ErrorCard()
        else
          ListView.separated(
            itemCount: experiences!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              return ExperienceCard(experience: experiences![index]);
            },
          ),
      ],
    );
  }
}

class _LoadingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: theme_colors.kPortfolioSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: theme_colors.kPortfolioBorder, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
        child: Column(
          children: [
            const LinearProgressIndicator(
              backgroundColor: theme_colors.kPortfolioBackground,
              color: theme_colors.kPortfolioTextSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              'Fetching work experience...',
              style: TextStyle(color: theme_colors.kPortfolioTextSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
            Icon(
              Icons.sentiment_very_dissatisfied_outlined,
              size: 80,
              color: theme_colors.kPortfolioTextSecondary.withOpacity(0.5),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Failed to load experience details',
                    style: textTheme.titleLarge?.copyWith(color: theme_colors.kPortfolioTextPrimary),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'There might be an issue with the backend service.',
                    style: textTheme.titleMedium,
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

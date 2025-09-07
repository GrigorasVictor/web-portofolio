import 'package:flutter/material.dart';
import '../models/education.dart';
import '../widgets/education_card.dart';
import '../theme/colors.dart' as theme_colors;

class EducationSection extends StatelessWidget {
  final List<Education>? educations;
  const EducationSection({super.key, required this.educations});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Education',
          style: textTheme.displaySmall?.copyWith(color: theme_colors.kPortfolioTextPrimary),
        ),
        const SizedBox(height: 40),
        if (educations == null)
          _LoadingCard()
        else if (educations!.isEmpty)
          _ErrorCard()
        else
          ListView.separated(
            itemCount: educations!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              return EducationCard(education: educations![index]);
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
              'Fetching education history...',
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
                    'Failed to load education details',
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

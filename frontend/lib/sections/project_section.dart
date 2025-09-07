import 'package:flutter/material.dart';
import '../models/project.dart';
import '../widgets/project_card.dart';
import '../theme/colors.dart' as theme_colors;

class ProjectSection extends StatelessWidget {
  final List<Project>? projects;
  const ProjectSection({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Projects',
          style: textTheme.displaySmall?.copyWith(color: theme_colors.kPortfolioTextPrimary),
        ),
        const SizedBox(height: 40),
        if (projects == null)
          _LoadingCard()
        else if (projects!.isEmpty)
          _ErrorCard()
        else
          ListView.separated(
            itemCount: projects!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              return ProjectCard(project: projects![index]);
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
              'Fetching projects...',
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
                    'Failed to load project details',
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

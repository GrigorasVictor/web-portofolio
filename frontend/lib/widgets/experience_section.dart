import 'package:flutter/material.dart';
import '../models/experience.dart';
import 'experience_card.dart';
import '../theme/colors.dart' as theme_colors;

class ExperienceSection extends StatelessWidget {
  final List<Experience> experiences;
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
        ListView.separated(
          itemCount: experiences.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(height: 20),
          itemBuilder: (context, index) {
            return ExperienceCard(experience: experiences[index]);
          },
        ),
      ],
    );
  }
}

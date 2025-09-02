import 'package:flutter/material.dart';
import 'section_container.dart';
import 'section_header.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final skills = [
      'Flutter',
      'Dart',
      'State Management',
      'Animations',
      'REST / GraphQL',
      'Firebase',
      'Testing',
      'CI/CD',
      'Design Systems',
      'Responsive Web',
      'Accessibility',
    ];

    return SectionContainer(
      background: theme.colorScheme.surfaceVariant.withOpacity(0.25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Skills',
            subtitle: 'Tools and technologies I use often',
          ),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (final s in skills)
                Chip(
                  label: Text(s),
                  avatar: const Icon(Icons.check_circle_outline, size: 18),
                )
            ],
          ),
        ],
      ),
    );
  }
}

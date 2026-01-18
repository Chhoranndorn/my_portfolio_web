import 'package:flutter/material.dart';
import 'section_container.dart';
import 'section_header.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Skills grouped by category like your CV
    final skillsMap = {
      'Programming Languages': ['Dart', 'JavaScript'],
      'Frameworks & Libraries': ['Flutter', 'React Native'],
      'Database': ['MySQL', 'Firebase'],
      'Deployment & Hosting': [
        'Google Play Store',
        'Apple App Store',
        'Firebase'
      ],
      'Tools': ['Git', 'Postman', 'Android Studio', 'Xcode', 'VS Code'],
      'Programming Concepts': [
        'OOP',
        'MVC',
        'Functional Programming',
        'REST API Design'
      ],
      'UX/UI': ['Figma'],
    };

    return SectionContainer(
      background: theme.colorScheme.surfaceVariant.withOpacity(0.25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: const SectionHeader(
              title: 'Skills',
              // subtitle: 'Tools and technologies I use often',
            ),
          ),

          // Categories
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: skillsMap.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    Text(
                      '${entry.key}:',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ...entry.value.map((skill) => Chip(
                          label: Text(skill),
                          avatar: const Icon(
                            Icons.check_circle_outline,
                            size: 18,
                          ),
                        )),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

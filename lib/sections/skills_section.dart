import 'package:flutter/material.dart';
import 'package:my_porfolio_web/l10n/app_strings.dart';
import 'section_container.dart';
import 'section_header.dart';

class SkillsSection extends StatelessWidget {
  final AppStrings strings;

  const SkillsSection({super.key, required this.strings});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final skillsMap = strings.skills;

    return SectionContainer(
      background:
          theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: SectionHeader(
              title: strings.skillsTitle,
              subtitle: strings.skillsSubtitle,
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
                          side: BorderSide(
                            color: theme.colorScheme.outlineVariant,
                          ),
                          backgroundColor: theme.colorScheme.surface,
                          label: Text(skill),
                          avatar: Icon(
                            Icons.check_circle_outline,
                            size: 18,
                            color: theme.colorScheme.primary,
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

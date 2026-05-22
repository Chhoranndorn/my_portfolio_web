import 'package:flutter/material.dart';
import 'package:my_porfolio_web/l10n/app_strings.dart';
import 'section_container.dart';
import 'section_header.dart';

class AboutSection extends StatelessWidget {
  final AppStrings strings;

  const AboutSection({super.key, required this.strings});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Helper method to create job experiences
    Widget buildJobExperience({
      required String role,
      required String duration,
      required String company,
      required List<String> responsibilities,
    }) {
      return Container(
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: theme.colorScheme.outlineVariant),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withValues(alpha: 0.06),
              blurRadius: 14,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              duration,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              role,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              company,
              style: theme.textTheme.bodyLarge
                  ?.copyWith(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: responsibilities
                  .map(
                    (r) => Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Container(
                              width: 7,
                              height: 7,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              r,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                                height: 1.45,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      );
    }

    return SectionContainer(
      child: Align(
        alignment: Alignment.topLeft, // Ensure top-left alignment
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: strings.aboutTitle,
              subtitle: strings.aboutSubtitle,
            ),
            ...strings.jobs.map(
              (job) => buildJobExperience(
                role: job.role,
                duration: job.duration,
                company: job.company,
                responsibilities: job.responsibilities,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

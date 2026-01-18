import 'package:flutter/material.dart';
import 'section_container.dart';
import 'section_header.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

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
      return Align(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$role - $duration',
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
                  .map((r) => Text('• $r', style: theme.textTheme.bodyLarge))
                  .toList(),
            ),
            const SizedBox(height: 16),
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
            const SectionHeader(
              title: 'Work Experience',
              // subtitle:
              //     'Professional experience showcasing Flutter development projects.',
            ),

            // Current Job
            buildJobExperience(
              role: 'Flutter Developer',
              duration: 'Jul 2024 - Present',
              company: 'Eocambo Technology (EOT) – Siem Reap, Cambodia',
              responsibilities: [
                'Developed 5+ Flutter (Dart) e-commerce apps, tailored to client requirements.',
                'Maintained and optimized legacy apps for performance, stability, and scalability.',
                'Implemented clean, modular code using GetX and Provider for state management.',
                'Collaborated with UI/UX teams to convert designs into functional apps.',
                'Published apps to Play Store and App Store; integrated RESTful APIs with Laravel backends.',
                'Conducted testing and debugging for smooth Android and iOS performance.',
                'Supported clients directly, addressing technical issues, gathering feedback, and ensuring requirements were met.',
                'Participated in team meetings to align on project goals and timelines.',
                'Used Git for version control and participated in agile development workflows.',
                'Assisted in feature planning and code reviews to improve code quality and maintainability.',
              ],
            ),

            // Internship
            buildJobExperience(
              role: 'Flutter Developer Internship',
              duration: 'Mar 2024 - Jun 2024',
              company: 'Eocambo Technology (EOT) – Siem Reap, Cambodia',
              responsibilities: [
                'Developed and optimized cross-platform Flutter (Dart) apps with GetX and Provider for state management.',
                'Improved UI/UX and app performance; integrated RESTful APIs using Dio/http.',
                'Collaborated in code reviews, agile workflows, and Git version control.',
                'Tested and debugged apps on Android and iOS for cross-platform compatibility.',
              ],
            ),
            buildJobExperience(
              role: 'Customer Service',
              duration: 'Jul 2023 - Jan 2024',
              company: 'Vireak Buntham Logistics and Travel & Bus Service',
              responsibilities: [
                'Provided professional customer support and handled inquiries.',
                'Assisted customers with booking and service-related issues.',
                'Developed strong communication and problem-solving skills.',
              ],
            ),
          ],
        ),
      ),
    );
  }
}

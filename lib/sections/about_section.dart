import 'package:flutter/material.dart';
import 'section_container.dart';
import 'section_header.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'About',
            subtitle: 'A quick intro about who I am and how I work',
          ),
          Text(
            'I am a Flutter developer focused on creating fast, scalable and beautiful applications. '
            'My work emphasizes clean architecture, thoughtful design systems, and smooth animations.\n\n'
            'I enjoy collaborating with product and design teams, writing maintainable code, and mentoring other developers. '
            'Beyond code, I love good typography, coffee, and open-source.',
            style: theme.textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}


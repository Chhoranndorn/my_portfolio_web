import 'package:flutter/material.dart';
import 'section_container.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onContactTap;
  final VoidCallback onProjectsTap;

  const HeroSection({super.key, required this.onContactTap, required this.onProjectsTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.colorScheme.primaryContainer, theme.colorScheme.surface],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SectionContainer(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 900;
            final nameStyle = theme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w800,
              height: 1.1,
            );
            final titleStyle = theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            );
            final intro = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('BO CHHORANNDORN', style: nameStyle),
                const SizedBox(height: 8),
                Text('Flutter Developer · Web & Mobile', style: titleStyle),
                const SizedBox(height: 16),
                Text(
                  'I craft responsive, accessible apps with Flutter.\n'
                  'I love clean architecture, performance, and delightful UX.',
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    FilledButton.icon(
                      onPressed: onProjectsTap,
                      icon: const Icon(Icons.work_outline),
                      label: const Text('View Projects'),
                    ),
                    OutlinedButton.icon(
                      onPressed: onContactTap,
                      icon: const Icon(Icons.mail_outline),
                      label: const Text('Contact Me'),
                    ),
                  ],
                ),
              ],
            );

            final avatar = CircleAvatar(
              radius: isNarrow ? 64 : 96,
              backgroundColor: theme.colorScheme.primary,
              child: Text(
                'YN',
                style: TextStyle(
                  color: theme.colorScheme.onPrimary,
                  fontSize: isNarrow ? 32 : 44,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );

            if (isNarrow) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  intro,
                  const SizedBox(height: 24),
                  Center(child: avatar),
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: intro),
                const SizedBox(width: 24),
                avatar,
              ],
            );
          },
        ),
      ),
    );
  }
}


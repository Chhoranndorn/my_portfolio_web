import 'package:flutter/material.dart';
import 'package:my_porfolio_web/widgets/reveal.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;

  const SectionHeader({super.key, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Reveal(
      delay: const Duration(milliseconds: 80),
      offset: const Offset(0, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: theme.textTheme.headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          if (subtitle != null) ...[
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Text(
                subtitle!,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
            ),
          ],
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

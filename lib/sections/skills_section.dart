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
                    ...entry.value.map(
                      (skill) => _LiveSkillChip(
                        label: skill,
                        highlighted: _coreSkills.contains(skill),
                      ),
                    ),
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

const _coreSkills = {
  'Flutter',
  'Dart',
  'Laravel',
  'Firebase',
  'REST API Design',
};

class _LiveSkillChip extends StatefulWidget {
  final String label;
  final bool highlighted;

  const _LiveSkillChip({required this.label, required this.highlighted});

  @override
  State<_LiveSkillChip> createState() => _LiveSkillChipState();
}

class _LiveSkillChipState extends State<_LiveSkillChip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final reduceMotion = MediaQuery.maybeDisableAnimationsOf(context) ?? false;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final pulse = reduceMotion || !widget.highlighted
            ? 0.0
            : Curves.easeInOut.transform(_controller.value);

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
            color: Color.lerp(
              theme.colorScheme.surface,
              theme.colorScheme.primaryContainer,
              pulse * 0.48,
            ),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: Color.lerp(
                theme.colorScheme.outlineVariant,
                theme.colorScheme.primary,
                pulse * 0.72,
              )!,
            ),
            boxShadow: [
              if (widget.highlighted)
                BoxShadow(
                  color: theme.colorScheme.primary
                      .withValues(alpha: 0.08 + pulse * 0.14),
                  blurRadius: 12 + pulse * 12,
                  offset: const Offset(0, 6),
                ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.highlighted
                    ? Icons.bolt_outlined
                    : Icons.check_circle_outline,
                size: 18,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 6),
              Text(
                widget.label,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight:
                      widget.highlighted ? FontWeight.w800 : FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

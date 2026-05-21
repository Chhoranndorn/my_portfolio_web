import 'package:flutter/material.dart';
import 'package:my_porfolio_web/l10n/app_strings.dart';
import 'section_container.dart';
import 'section_header.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatelessWidget {
  final AppStrings strings;

  const ProjectsSection({super.key, required this.strings});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SectionContainer(
      background: theme.colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: strings.projectsTitle,
            subtitle: strings.projectsSubtitle,
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: strings.projects
                .map((project) =>
                    _ProjectCard(project: project, strings: strings))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final LocalizedProject project;
  final AppStrings strings;

  const _ProjectCard({required this.project, required this.strings});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovering = false;

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.platformDefault,
      webOnlyWindowName: '_blank',
    )) {
      throw 'Could not launch $uri';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final project = widget.project;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        margin: const EdgeInsets.only(bottom: 24),
        transform: Matrix4.translationValues(0, _hovering ? -4 : 0, 0),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _hovering
                ? theme.colorScheme.primary.withValues(alpha: 0.42)
                : theme.colorScheme.outlineVariant,
          ),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withValues(
                alpha: _hovering ? 0.16 : 0.08,
              ),
              blurRadius: _hovering ? 24 : 12,
              offset: Offset(0, _hovering ? 14 : 8),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 820;
            final image = _ProjectImage(path: project.imageUrl);
            final details = Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _Tag(project.type),
                      _Tag(project.role),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    project.title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    project.description,
                    style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    project.techStack,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 14),
                  ...project.highlights.map(
                    (highlight) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            size: 18,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              highlight,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                                height: 1.45,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      FilledButton.tonalIcon(
                        onPressed: () => _open(project.googlePlayUrl),
                        icon: const Icon(Icons.android),
                        label: Text(widget.strings.googlePlay),
                      ),
                      OutlinedButton.icon(
                        onPressed: () => _open(project.appStoreUrl),
                        icon: const Icon(Icons.apple),
                        label: Text(widget.strings.appStore),
                      ),
                    ],
                  ),
                ],
              ),
            );

            if (!isWide) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [image, details],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 420, child: image),
                Expanded(child: details),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ProjectImage extends StatelessWidget {
  final String path;

  const _ProjectImage({required this.path});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AspectRatio(
      aspectRatio: 16 / 10,
      child: Container(
        color: theme.colorScheme.surfaceContainerHighest,
        child: Image.asset(
          path,
          fit: BoxFit.contain,
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;

  const _Tag(this.label);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

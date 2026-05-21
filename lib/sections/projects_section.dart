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

  void _showDetails() {
    showDialog<void>(
      context: context,
      builder: (context) => _ProjectDetailsDialog(
        project: widget.project,
        strings: widget.strings,
        onOpen: _open,
      ),
    );
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
                  _BuildLogPanel(strings: widget.strings, compact: true),
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
                      FilledButton.icon(
                        onPressed: _showDetails,
                        icon: const Icon(Icons.article_outlined),
                        label: Text(widget.strings.viewDetails),
                      ),
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
        padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 18),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
        ),
        child: Center(
          child: AspectRatio(
            aspectRatio: 9 / 16,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.inverseSurface,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.shadow.withValues(alpha: 0.22),
                    blurRadius: 24,
                    offset: const Offset(0, 14),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Container(
                  color: theme.colorScheme.surface,
                  child: Image.asset(
                    path,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectDetailsDialog extends StatelessWidget {
  final LocalizedProject project;
  final AppStrings strings;
  final Future<void> Function(String url) onOpen;

  const _ProjectDetailsDialog({
    required this.project,
    required this.strings,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 920),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              _ProjectImage(path: project.imageUrl),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                strings.projectDetails,
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                project.title,
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          tooltip: strings.close,
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    _DialogSectionTitle(strings.overview),
                    Text(
                      project.description,
                      style: theme.textTheme.bodyLarge?.copyWith(height: 1.55),
                    ),
                    const SizedBox(height: 18),
                    _DialogSectionTitle(strings.techStackLabel),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: project.techStack
                          .split(',')
                          .map((tech) => _Tag(tech.trim()))
                          .toList(),
                    ),
                    const SizedBox(height: 18),
                    _DialogSectionTitle(strings.buildLog),
                    _BuildLogPanel(strings: strings),
                    const SizedBox(height: 18),
                    _DialogSectionTitle(strings.highlights),
                    ...project.highlights.map(
                      (highlight) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              size: 19,
                              color: theme.colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                highlight,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  height: 1.5,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        FilledButton.tonalIcon(
                          onPressed: () => onOpen(project.googlePlayUrl),
                          icon: const Icon(Icons.android),
                          label: Text(strings.googlePlay),
                        ),
                        OutlinedButton.icon(
                          onPressed: () => onOpen(project.appStoreUrl),
                          icon: const Icon(Icons.apple),
                          label: Text(strings.appStore),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(strings.close),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DialogSectionTitle extends StatelessWidget {
  final String text;

  const _DialogSectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _BuildLogPanel extends StatefulWidget {
  final AppStrings strings;
  final bool compact;

  const _BuildLogPanel({required this.strings, this.compact = false});

  @override
  State<_BuildLogPanel> createState() => _BuildLogPanelState();
}

class _BuildLogPanelState extends State<_BuildLogPanel>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
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
    final items = widget.strings.buildLogItems;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(widget.compact ? 12 : 14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final active = reduceMotion || items.isEmpty
              ? -1
              : (_controller.value * items.length).floor() % items.length;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.strings.buildLog,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.primary,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              for (var i = 0; i < items.length; i++)
                Padding(
                  padding: EdgeInsets.only(top: i == 0 ? 0 : 5),
                  child: Row(
                    children: [
                      Icon(
                        i == active
                            ? Icons.sync_outlined
                            : Icons.check_circle_outline,
                        size: 16,
                        color: i == active
                            ? theme.colorScheme.primary
                            : theme.colorScheme.tertiary,
                      ),
                      const SizedBox(width: 7),
                      Expanded(
                        child: Text(
                          i == active ? '${items[i]} ...' : items[i],
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: i == active
                                ? theme.colorScheme.primary
                                : theme.colorScheme.onSurfaceVariant,
                            fontFamily: 'monospace',
                            fontWeight:
                                i == active ? FontWeight.w800 : FontWeight.w500,
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
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

import 'dart:math' as math;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'section_container.dart';
import 'package:my_porfolio_web/l10n/app_strings.dart';
import 'package:my_porfolio_web/util/images.dart';
import 'package:my_porfolio_web/widgets/reveal.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onContactTap;
  final VoidCallback onProjectsTap;
  final AppStrings strings;

  const HeroSection({
    super.key,
    required this.onContactTap,
    required this.onProjectsTap,
    required this.strings,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Future<void> openUrl(String value) async {
      final url = Uri.parse(value);
      if (!await launchUrl(
        url,
        mode: LaunchMode.platformDefault,
        webOnlyWindowName: '_blank',
      )) {
        throw 'Could not launch $url';
      }
    }

    return Stack(
      children: [
        const Positioned.fill(
          child: RepaintBoundary(child: _UniverseBackground()),
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primaryContainer.withValues(alpha: 0.76),
                  theme.colorScheme.surface.withValues(alpha: 0.88),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        SectionContainer(
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
              final introAlignment = isNarrow
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start;
              final heroTextAlign =
                  isNarrow ? TextAlign.center : TextAlign.start;
              final intro = Column(
                crossAxisAlignment: introAlignment,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color:
                            theme.colorScheme.primary.withValues(alpha: 0.22),
                      ),
                    ),
                    child: Text(
                      strings.heroBadge,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  // Name
                  Text(
                    'BO CHHORANNDORN',
                    style: nameStyle,
                    textAlign: heroTextAlign,
                  ),
                  const SizedBox(height: 8),
                  // Role
                  // Text('Mobile Application Developer', style: titleStyle),
                  Text(
                    strings.role,
                    style: titleStyle,
                    textAlign: heroTextAlign,
                  ),

                  const SizedBox(height: 14),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 660),
                    child: Text(
                      strings.heroIntro,
                      textAlign: heroTextAlign,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        height: 1.55,
                      ),
                    ),
                  ),
                  if (!isNarrow) ...[
                    const SizedBox(height: 16),
                    const _TerminalStatusStrip(),
                    const SizedBox(height: 14),
                    const _TechIconRail(),
                  ],

                  const SizedBox(height: 24), // Buttons
                  Wrap(
                    alignment:
                        isNarrow ? WrapAlignment.center : WrapAlignment.start,
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      FilledButton.icon(
                        onPressed: onProjectsTap,
                        icon: const Icon(Icons.work_outline),
                        label: Text(strings.viewProjects),
                      ),
                      OutlinedButton.icon(
                        onPressed: onContactTap,
                        icon: const Icon(Icons.mail_outline),
                        label: Text(strings.contactMe),
                      ),
                      if (!isNarrow) ...[
                        FilledButton.tonalIcon(
                          onPressed: () => openUrl('BO_CHHORANNDORN_CV.pdf'),
                          icon: const Icon(Icons.download_outlined),
                          label: Text(strings.downloadCv),
                        ),
                        TextButton.icon(
                          onPressed: () =>
                              openUrl('https://github.com/Chhoranndorn'),
                          icon: const Icon(Icons.open_in_new),
                          label: const Text('GitHub'),
                        ),
                      ],
                    ],
                  ),
                  if (!isNarrow) ...[
                    const SizedBox(height: 28),
                    Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _HeroStat(value: '20+', label: strings.statApps),
                        _HeroStat(value: '10+', label: strings.statStores),
                        _HeroStat(value: 'REST', label: strings.statApi),
                      ],
                    ),
                  ],
                ],
              );

              final avatar = CircleAvatar(
                radius: isNarrow ? 64 : 96,
                backgroundColor: theme.colorScheme.primary,
                // Use app asset from Images helper; falls back to initials.
                foregroundImage: const ResizeImage(
                  AssetImage(Images.profile),
                  width: 384,
                  height: 384,
                ),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Reveal(
                        delay: const Duration(milliseconds: 80),
                        offset: const Offset(0, 20),
                        child: avatar,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Reveal(
                      delay: const Duration(milliseconds: 140),
                      offset: const Offset(0, 28),
                      child: intro,
                    ),
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Reveal(
                          delay: const Duration(milliseconds: 100),
                          offset: const Offset(0, 32),
                          child: intro)),
                  const SizedBox(width: 24),
                  Reveal(
                      delay: const Duration(milliseconds: 200),
                      offset: const Offset(0, 24),
                      child: avatar),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _UniverseBackground extends StatefulWidget {
  const _UniverseBackground();

  @override
  State<_UniverseBackground> createState() => _UniverseBackgroundState();
}

class _UniverseBackgroundState extends State<_UniverseBackground> {
  static const _frameInterval = Duration(milliseconds: 83);

  Timer? _timer;
  late final List<_Star> _stars;
  Offset _cursor = const Offset(0.5, 0.5);
  double _progress = 0;
  DateTime _lastCursorUpdate = DateTime.fromMillisecondsSinceEpoch(0);

  @override
  void initState() {
    super.initState();
    final random = math.Random(14);
    _stars = List.generate(58, (index) {
      return _Star(
        x: random.nextDouble(),
        y: random.nextDouble(),
        radius: 0.5 + random.nextDouble() * 1.8,
        depth: 0.25 + random.nextDouble() * 0.95,
        phase: random.nextDouble() * math.pi * 2,
      );
    });
    _timer = Timer.periodic(_frameInterval, (_) {
      if (!mounted) return;
      setState(() {
        _progress = (_progress + _frameInterval.inMilliseconds / 18000) % 1;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateCursor(PointerEvent event, Size size) {
    if (size.width <= 0 || size.height <= 0) return;
    final now = DateTime.now();
    if (now.difference(_lastCursorUpdate) < const Duration(milliseconds: 40)) {
      return;
    }
    final nextCursor = Offset(
      (event.localPosition.dx / size.width).clamp(0.0, 1.0),
      (event.localPosition.dy / size.height).clamp(0.0, 1.0),
    );
    if ((nextCursor - _cursor).distance < 0.012) return;
    _lastCursorUpdate = now;
    setState(() {
      _cursor = nextCursor;
    });
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.maybeDisableAnimationsOf(context) ?? false;

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);

        return MouseRegion(
          onHover: (event) => _updateCursor(event, size),
          onExit: (_) {
            if (_cursor == const Offset(0.5, 0.5)) return;
            setState(() => _cursor = const Offset(0.5, 0.5));
          },
          child: CustomPaint(
            isComplex: true,
            willChange: !reduceMotion,
            painter: _UniversePainter(
              stars: _stars,
              cursor: _cursor,
              progress: reduceMotion ? 0 : _progress,
              colorScheme: Theme.of(context).colorScheme,
            ),
          ),
        );
      },
    );
  }
}

class _UniversePainter extends CustomPainter {
  final List<_Star> stars;
  final Offset cursor;
  final double progress;
  final ColorScheme colorScheme;

  const _UniversePainter({
    required this.stars,
    required this.cursor,
    required this.progress,
    required this.colorScheme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    final rect = Offset.zero & size;
    final cursorOffset =
        Offset(cursor.dx * size.width, cursor.dy * size.height);
    final drift = Offset((cursor.dx - 0.5) * 34, (cursor.dy - 0.5) * 26);

    final background = Paint()
      ..shader = RadialGradient(
        center: Alignment(cursor.dx * 2 - 1, cursor.dy * 2 - 1),
        radius: 1.05,
        colors: [
          colorScheme.primary.withValues(alpha: 0.32),
          colorScheme.surface.withValues(alpha: 0.96),
        ],
      ).createShader(rect);
    canvas.drawRect(rect, background);

    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          colorScheme.secondary.withValues(alpha: 0.24),
          colorScheme.primary.withValues(alpha: 0.12),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: cursorOffset,
          radius: math.max(size.width, size.height) * 0.42,
        ),
      );
    canvas.drawCircle(
      cursorOffset,
      math.max(size.width, size.height) * 0.42,
      glowPaint,
    );

    final linePaint = Paint()
      ..color = colorScheme.primary.withValues(alpha: 0.08)
      ..strokeWidth = 1;
    for (var i = 0; i < stars.length; i += 12) {
      final a = _starPosition(stars[i], size, drift);
      final b = _starPosition(stars[(i + 5) % stars.length], size, drift);
      if ((a - b).distance < 190) {
        canvas.drawLine(a, b, linePaint);
      }
    }

    for (final star in stars) {
      final position = _starPosition(star, size, drift);
      final pulse = 0.65 + math.sin(progress * math.pi * 2 + star.phase) * 0.35;
      final alpha = (0.28 + star.depth * 0.54 + pulse * 0.16).clamp(0.0, 1.0);
      final radius = star.radius * (0.75 + star.depth * 0.95);
      final paint = Paint()
        ..color = colorScheme.onSurface.withValues(alpha: alpha * 0.64);
      canvas.drawCircle(position, radius, paint);

      if (star.depth > 0.72) {
        final haloPaint = Paint()
          ..color = colorScheme.primary.withValues(alpha: 0.08 * pulse);
        canvas.drawCircle(position, radius * 4, haloPaint);
      }
    }
  }

  Offset _starPosition(_Star star, Size size, Offset drift) {
    final orbit = Offset(
      math.sin(progress * math.pi * 2 + star.phase) * 8,
      math.cos(progress * math.pi * 2 + star.phase) * 6,
    );
    return Offset(star.x * size.width, star.y * size.height) +
        drift * star.depth +
        orbit * star.depth;
  }

  @override
  bool shouldRepaint(covariant _UniversePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.cursor != cursor ||
        oldDelegate.colorScheme != colorScheme;
  }
}

class _Star {
  final double x;
  final double y;
  final double radius;
  final double depth;
  final double phase;

  const _Star({
    required this.x,
    required this.y,
    required this.radius,
    required this.depth,
    required this.phase,
  });
}

class _HeroStat extends StatelessWidget {
  final String value;
  final String label;

  const _HeroStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 128,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.74),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _TerminalStatusStrip extends StatefulWidget {
  const _TerminalStatusStrip();

  @override
  State<_TerminalStatusStrip> createState() => _TerminalStatusStripState();
}

class _TerminalStatusStripState extends State<_TerminalStatusStrip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  static const _lines = [
    '> stack: Flutter + Laravel + Firebase',
    '> mobile: Android + iOS + Web',
    '> status: available_for_projects',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
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

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 560),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withValues(alpha: 0.72),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: theme.colorScheme.primary.withValues(alpha: 0.24),
          ),
        ),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final activeLine =
                (_controller.value * _lines.length).floor() % _lines.length;
            final cursorVisible = (_controller.value * 16).floor().isEven;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < _lines.length; i++)
                  Padding(
                    padding: EdgeInsets.only(top: i == 0 ? 0 : 4),
                    child: Text(
                      i == activeLine && cursorVisible
                          ? '${_lines[i]} _'
                          : _lines[i],
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: i == activeLine
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurfaceVariant,
                        fontFamily: 'monospace',
                        fontWeight:
                            i == activeLine ? FontWeight.w700 : FontWeight.w500,
                        height: 1.35,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TechIconRail extends StatefulWidget {
  const _TechIconRail();

  @override
  State<_TechIconRail> createState() => _TechIconRailState();
}

class _TechIconRailState extends State<_TechIconRail>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  static const _items = [
    _TechIconItem('Flutter', FontAwesomeIcons.flutter),
    _TechIconItem('Dart', FontAwesomeIcons.dartLang),
    _TechIconItem('React Native', FontAwesomeIcons.react),
    _TechIconItem('Kotlin', FontAwesomeIcons.android),
    _TechIconItem('Swift', FontAwesomeIcons.swift),
    _TechIconItem('Laravel', FontAwesomeIcons.laravel),
    _TechIconItem('Firebase', FontAwesomeIcons.fire),
    _TechIconItem('MySQL', FontAwesomeIcons.database),
    _TechIconItem('Git', FontAwesomeIcons.gitAlt),
    _TechIconItem('Figma', FontAwesomeIcons.figma),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    final theme = Theme.of(context);

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 650),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withValues(alpha: 0.64),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.74),
          ),
        ),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final pulse = reduceMotion
                ? 0.0
                : Curves.easeInOut.transform(_controller.value);

            return Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (var i = 0; i < _items.length; i++)
                  _TechIconButton(
                    item: _items[i],
                    active:
                        ((pulse * _items.length).floor() % _items.length) == i,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TechIconButton extends StatelessWidget {
  final _TechIconItem item;
  final bool active;

  const _TechIconButton({required this.item, required this.active});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Tooltip(
      message: item.label,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: active
              ? theme.colorScheme.primaryContainer
              : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: active
                ? theme.colorScheme.primary.withValues(alpha: 0.72)
                : theme.colorScheme.outlineVariant,
          ),
          boxShadow: [
            if (active)
              BoxShadow(
                color: theme.colorScheme.primary.withValues(alpha: 0.18),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
          ],
        ),
        alignment: Alignment.center,
        child: FaIcon(
          item.icon,
          size: 20,
          color: active
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _TechIconItem {
  final String label;
  final IconData icon;

  const _TechIconItem(this.label, this.icon);
}

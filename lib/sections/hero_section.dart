import 'dart:math' as math;

import 'package:flutter/material.dart';
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
        const Positioned.fill(child: _UniverseBackground()),
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
              final contactStyle = theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ) ??
                  TextStyle(
                    fontSize: 16,
                    color: theme.colorScheme.onSurface,
                  );
              final contactLabelStyle = contactStyle.copyWith(
                fontWeight: FontWeight.bold,
              );
              final linkStyle = contactStyle.copyWith(
                color: theme.colorScheme.primary,
              );
              final intro = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Text('BO CHHORANNDORN', style: nameStyle),
                  const SizedBox(height: 8),
                  // Role
                  // Text('Mobile Application Developer', style: titleStyle),
                  Text(strings.role, style: titleStyle),

                  const SizedBox(height: 14),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 660),
                    child: Text(
                      strings.heroIntro,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        height: 1.55,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Contact Info - each on a new line
// Contact Info - each on a new line with bold labels
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: contactStyle,
                          children: [
                            TextSpan(
                              text: strings.addressLabel,
                              style: contactLabelStyle,
                            ),
                            TextSpan(text: strings.address),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      RichText(
                        text: TextSpan(
                          style: contactStyle,
                          children: [
                            TextSpan(
                              text: strings.phoneLabel,
                              style: contactLabelStyle,
                            ),
                            TextSpan(text: '+855 17 824 303 (Telegram)'),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      RichText(
                        text: TextSpan(
                          style: contactStyle,
                          children: [
                            TextSpan(
                              text: strings.emailLabel,
                              style: contactLabelStyle,
                            ),
                            TextSpan(text: 'ranndorn99@gmail.com'),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      // LinkedIn
                      InkWell(
                        onTap: () async {
                          await openUrl(
                              'https://www.linkedin.com/in/bo-chhoranndorn-32402b35a/');
                        },
                        child: RichText(
                          text: TextSpan(
                            style: linkStyle,
                            children: [
                              TextSpan(
                                text: 'LinkedIn: ',
                                style: contactLabelStyle,
                              ),
                              TextSpan(
                                text:
                                    'linkedin.com/in/bo-chhoranndorn-32402b35a/',
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 4),

// GitHub
                      InkWell(
                        onTap: () async {
                          await openUrl('https://github.com/Chhoranndorn');
                        },
                        child: RichText(
                          text: TextSpan(
                            style: linkStyle,
                            children: [
                              TextSpan(
                                text: 'GitHub: ',
                                style: contactLabelStyle,
                              ),
                              TextSpan(
                                text: 'github.com/Chhoranndorn',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24), // Buttons
                  Wrap(
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
                  ),
                  const SizedBox(height: 28),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _HeroStat(value: '20+', label: strings.statApps),
                      _HeroStat(value: '10+', label: strings.statStores),
                      _HeroStat(value: 'REST', label: strings.statApi),
                    ],
                  ),
                ],
              );

              final avatar = CircleAvatar(
                radius: isNarrow ? 64 : 96,
                backgroundColor: theme.colorScheme.primary,
                // Use app asset from Images helper; falls back to initials.
                foregroundImage: const AssetImage(Images.profile),
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
                    Reveal(
                        delay: const Duration(milliseconds: 100),
                        offset: const Offset(0, 32),
                        child: intro),
                    const SizedBox(height: 24),
                    Center(
                        child: Reveal(
                            delay: const Duration(milliseconds: 200),
                            offset: const Offset(0, 24),
                            child: avatar)),
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

class _UniverseBackgroundState extends State<_UniverseBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_Star> _stars;
  Offset _cursor = const Offset(0.5, 0.5);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat();

    final random = math.Random(14);
    _stars = List.generate(90, (index) {
      return _Star(
        x: random.nextDouble(),
        y: random.nextDouble(),
        radius: 0.5 + random.nextDouble() * 1.8,
        depth: 0.25 + random.nextDouble() * 0.95,
        phase: random.nextDouble() * math.pi * 2,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateCursor(PointerEvent event, Size size) {
    if (size.width <= 0 || size.height <= 0) return;
    setState(() {
      _cursor = Offset(
        (event.localPosition.dx / size.width).clamp(0.0, 1.0),
        (event.localPosition.dy / size.height).clamp(0.0, 1.0),
      );
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
          onExit: (_) => setState(() => _cursor = const Offset(0.5, 0.5)),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: _UniversePainter(
                  stars: _stars,
                  cursor: _cursor,
                  progress: reduceMotion ? 0 : _controller.value,
                  colorScheme: Theme.of(context).colorScheme,
                ),
              );
            },
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
    for (var i = 0; i < stars.length; i += 9) {
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

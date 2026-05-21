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

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primaryContainer,
            theme.colorScheme.surface
          ],
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
                      color: theme.colorScheme.primary.withValues(alpha: 0.22),
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
    );
  }
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

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'section_container.dart';
import 'package:my_porfolio_web/util/images.dart';
import 'package:my_porfolio_web/widgets/reveal.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onContactTap;
  final VoidCallback onProjectsTap;

  const HeroSection(
      {super.key, required this.onContactTap, required this.onProjectsTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
            final intro = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text('BO CHHORANNDORN', style: nameStyle),
                const SizedBox(height: 8),
                // Role
                Text('Mobile Application Developer (Flutter)',
                    style: titleStyle),
                const SizedBox(height: 16),

                // Contact Info - each on a new line
// Contact Info - each on a new line with bold labels
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Address: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                              text:
                                  'Salakansaeng Village, Siem Reap Province, Cambodia'),
                        ],
                      ),
                    ),
                    SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Phone: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: '+855 17 824 303 (Telegram)'),
                        ],
                      ),
                    ),
                    SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Email: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: 'ranndorn99@gmail.com'),
                        ],
                      ),
                    ),
                    SizedBox(height: 4),
                    // LinkedIn
                    InkWell(
                      onTap: () async {
                        final url = Uri.parse(
                            'https://www.linkedin.com/in/bo-chhoranndorn-32402b35a/');
                        if (!await launchUrl(url)) {
                          throw 'Could not launch $url';
                        }
                      },
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                          children: [
                            TextSpan(
                              text: 'LinkedIn: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
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
                        final url =
                            Uri.parse('https://github.com/Chhoranndorn');
                        if (!await launchUrl(url)) {
                          throw 'Could not launch $url';
                        }
                      },
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                          children: [
                            TextSpan(
                              text: 'GitHub: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
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

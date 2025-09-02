import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'section_container.dart';
import 'section_header.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  bool _copied = false;

  Future<void> _copy(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!mounted) return;
    setState(() => _copied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _copied = false);
  }

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(
      uri,
      mode: LaunchMode.platformDefault,
      webOnlyWindowName: '_blank',
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const email = 'ranndorn99@gmail.com';
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Contact',
            subtitle: 'Let’s build something great together',
          ),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Icon(Icons.mail_outline, color: theme.colorScheme.primary),
              SelectableText(email, style: theme.textTheme.titleMedium),
              FilledButton.tonalIcon(
                onPressed: () => _copy(email),
                icon: Icon(_copied ? Icons.check : Icons.copy),
                label: Text(_copied ? 'Copied' : 'Copy email'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Socials
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _Social(icon: FontAwesomeIcons.github, label: 'GitHub', onTap: () => _open('https://github.com/Chhoranndorn')),
              _Social(icon: FontAwesomeIcons.facebook, label: 'Facebook', onTap: () => _open('https://www.facebook.com/don.bx.1')),
              _Social(icon: FontAwesomeIcons.youtube, label: 'YouTube', onTap: () => _open('https://www.youtube.com/@bochhoranndorn3266')),
              _Social(icon: FontAwesomeIcons.tiktok, label: 'TikTok', onTap: () => _open('https://www.tiktok.com/@ranndorn?lang=en')),
              _Social(icon: FontAwesomeIcons.linkedin, label: 'LinkedIn', onTap: () => _open('https://www.linkedin.com/in/bo-chhoranndorn-32402b35a/')),
              _Social(icon: FontAwesomeIcons.instagram, label: 'Instagram', onTap: () => _open('https://www.instagram.com/rann_dxrn/')),
              _Social(icon: FontAwesomeIcons.xTwitter, label: 'X', onTap: () => _open('https://x.com/ranndorn')),
              _Social(icon: FontAwesomeIcons.telegram, label: 'Telegram', onTap: () => _open('https://t.me/rann_dxrn')),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            children: const [
              _ContactBadge(icon: Icons.location_on_outlined, label: 'Remote / GMT+0'),
              _ContactBadge(icon: Icons.language_outlined, label: 'English'),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContactBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ContactBadge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
    );
  }
}

class _Social extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _Social({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Tooltip(
      message: label,
      child: InkResponse(
        onTap: onTap,
        radius: 24,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant.withOpacity(0.6),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: theme.colorScheme.outlineVariant),
          ),
          alignment: Alignment.center,
          child: FaIcon(icon, size: 18),
        ),
      ),
    );
  }
}

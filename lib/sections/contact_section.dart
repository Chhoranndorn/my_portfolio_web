import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'section_container.dart';
import 'section_header.dart';

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


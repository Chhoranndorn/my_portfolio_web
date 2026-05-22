import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_porfolio_web/l10n/app_strings.dart';
import 'section_container.dart';
import 'section_header.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactSection extends StatefulWidget {
  final AppStrings strings;

  const ContactSection({super.key, required this.strings});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _copied = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

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

  void _clearContactForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _emailController.clear();
    _messageController.clear();
  }

  Future<void> _sendMessage() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final message = _messageController.text.trim();
    final uri = Uri.https(
      'mail.google.com',
      '/mail/',
      {
        'view': 'cm',
        'fs': '1',
        'to': 'ranndorn99@gmail.com',
        'su': 'Portfolio project inquiry from $name',
        'body': 'Name: $name\nEmail: $email\n\n$message',
      },
    );

    _clearContactForm();
    await launchUrl(
      uri,
      mode: LaunchMode.platformDefault,
      webOnlyWindowName: '_blank',
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return widget.strings.contactRequired;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    const email = 'ranndorn99@gmail.com';
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: widget.strings.contactTitle,
            subtitle: widget.strings.contactSubtitle,
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 760;
              final formCard = _ContactFormCard(
                formKey: _formKey,
                nameController: _nameController,
                emailController: _emailController,
                messageController: _messageController,
                strings: widget.strings,
                validator: _requiredValidator,
                onSubmit: _sendMessage,
              );
              final directContactCard = _DirectContactCard(
                email: email,
                copied: _copied,
                strings: widget.strings,
                onCopyEmail: () => _copy(email),
                onOpen: _open,
              );

              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    formCard,
                    const SizedBox(height: 16),
                    directContactCard,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 5, child: formCard),
                  const SizedBox(width: 18),
                  Expanded(flex: 3, child: directContactCard),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ContactFormCard extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController messageController;
  final AppStrings strings;
  final String? Function(String? value) validator;
  final VoidCallback onSubmit;

  const _ContactFormCard({
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.messageController,
    required this.strings,
    required this.validator,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.72),
        ),
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              strings.contactFormTitle,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 18),
            TextFormField(
              controller: nameController,
              validator: validator,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: strings.contactNameLabel,
                prefixIcon: const Icon(Icons.person_outline),
                filled: true,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: emailController,
              validator: validator,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: strings.contactEmailLabel,
                prefixIcon: const Icon(Icons.alternate_email),
                filled: true,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: messageController,
              validator: validator,
              minLines: 5,
              maxLines: 7,
              decoration: InputDecoration(
                labelText: strings.contactMessageLabel,
                alignLabelWithHint: true,
                prefixIcon: const Icon(Icons.notes_outlined),
                filled: true,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Align(
              alignment: Alignment.centerLeft,
              child: FilledButton.icon(
                onPressed: onSubmit,
                icon: const Icon(Icons.send_outlined),
                label: Text(strings.contactSendMessage),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DirectContactCard extends StatelessWidget {
  final String email;
  final bool copied;
  final AppStrings strings;
  final VoidCallback onCopyEmail;
  final Future<void> Function(String url) onOpen;

  const _DirectContactCard({
    required this.email,
    required this.copied,
    required this.strings,
    required this.onCopyEmail,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.72),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            strings.contactDirectTitle,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child:
                    Icon(Icons.mail_outline, color: theme.colorScheme.primary),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SelectableText(
                  email,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          FilledButton.tonalIcon(
            onPressed: onCopyEmail,
            icon: Icon(copied ? Icons.check : Icons.copy),
            label: Text(copied ? strings.copied : strings.copyEmail),
          ),
          const SizedBox(height: 20),
          Divider(color: theme.colorScheme.outlineVariant),
          const SizedBox(height: 14),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _Social(
                  icon: FontAwesomeIcons.telegram,
                  label: 'Telegram',
                  onTap: () => onOpen('https://t.me/chhoranndorn_bo')),
              _Social(
                  icon: FontAwesomeIcons.linkedin,
                  label: 'LinkedIn',
                  onTap: () => onOpen(
                      'https://www.linkedin.com/in/bo-chhoranndorn-32402b35a/')),
              _Social(
                  icon: FontAwesomeIcons.github,
                  label: 'GitHub',
                  onTap: () => onOpen('https://github.com/Chhoranndorn')),
            ],
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _ContactBadge(
                  icon: Icons.location_on_outlined, label: strings.location),
              _ContactBadge(
                  icon: Icons.language_outlined,
                  label: strings.spokenLanguages),
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
      visualDensity: VisualDensity.compact,
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
            color: theme.colorScheme.surfaceContainerHighest.withValues(
              alpha: 0.52,
            ),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: theme.colorScheme.outlineVariant.withValues(alpha: 0.72),
            ),
          ),
          alignment: Alignment.center,
          child: FaIcon(
            icon,
            size: 18,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

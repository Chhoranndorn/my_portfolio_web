import 'package:flutter/material.dart';

import 'l10n/app_strings.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/skills_section.dart';
import 'sections/projects_section.dart';
import 'sections/contact_section.dart';
import 'util/images.dart';
import 'util/local_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const _themePreferenceKey = 'portfolio.theme';
  static const _languagePreferenceKey = 'portfolio.language';

  ThemeMode _themeMode = ThemeMode.dark;
  AppLanguage _language = AppLanguage.en;
  Map<AppLanguage, AppStrings> _translations = const {};

  @override
  void initState() {
    super.initState();
    _loadAppState();
  }

  Future<void> _loadAppState() async {
    final savedTheme = await LocalPreferences.read(_themePreferenceKey);
    final savedLanguage = await LocalPreferences.read(_languagePreferenceKey);
    final loaded = await Future.wait(
      AppLanguage.values.map(
        (language) async => MapEntry(
          language,
          await AppStrings.load(language),
        ),
      ),
    );
    if (!mounted) return;
    setState(() {
      _themeMode = savedTheme == 'light' ? ThemeMode.light : ThemeMode.dark;
      _language = AppLanguage.values.firstWhere(
        (language) => language.name == savedLanguage,
        orElse: () => AppLanguage.en,
      );
      _translations = Map.fromEntries(loaded);
    });
  }

  void _toggleTheme() {
    final nextTheme =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    setState(() {
      _themeMode = nextTheme;
    });
    LocalPreferences.write(
      _themePreferenceKey,
      nextTheme == ThemeMode.light ? 'light' : 'dark',
    );
  }

  void _changeLanguage(AppLanguage language) {
    setState(() {
      _language = language;
    });
    LocalPreferences.write(_languagePreferenceKey, language.name);
  }

  @override
  Widget build(BuildContext context) {
    final activeStrings = _translations[_language];
    final light = ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo, brightness: Brightness.light),
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: const Color(0xFFFAFAFC),
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
    );
    final dark = ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo, brightness: Brightness.dark),
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: activeStrings?.portfolioTitle ?? 'BO CHHORANNDORN',
      theme: light,
      darkTheme: dark,
      themeMode: _themeMode,
      home: activeStrings == null
          ? const _AppLoadingScreen()
          : PortfolioPage(
              onToggleTheme: _toggleTheme,
              themeMode: _themeMode,
              language: _language,
              strings: activeStrings,
              onLanguageChanged: _changeLanguage,
            ),
    );
  }
}

class _AppLoadingScreen extends StatelessWidget {
  const _AppLoadingScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final ThemeMode themeMode;
  final AppLanguage language;
  final AppStrings strings;
  final ValueChanged<AppLanguage> onLanguageChanged;

  const PortfolioPage({
    super.key,
    required this.onToggleTheme,
    required this.themeMode,
    required this.language,
    required this.strings,
    required this.onLanguageChanged,
  });

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();
  double _scrollProgress = 0;

  final _homeKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateScrollProgress);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_updateScrollProgress)
      ..dispose();
    super.dispose();
  }

  void _updateScrollProgress() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    final maxScroll = position.maxScrollExtent;
    final nextProgress =
        maxScroll <= 0 ? 0.0 : (position.pixels / maxScroll).clamp(0.0, 1.0);
    if ((nextProgress - _scrollProgress).abs() < 0.002) return;
    setState(() {
      _scrollProgress = nextProgress;
    });
  }

  Future<void> _scrollTo(GlobalKey key) async {
    final ctx = key.currentContext;
    if (ctx == null) return;
    await Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      alignment: 0.05,
    );
  }

  AppStrings get strings => widget.strings;

  List<Widget> _buildActions(bool isSmall) {
    final t = strings;
    final items = <_NavItem>[
      _NavItem(t.navHome, Icons.home_outlined, () => _scrollTo(_homeKey)),
      _NavItem(t.navAbout, Icons.badge_outlined, () => _scrollTo(_aboutKey)),
      _NavItem(t.navSkills, Icons.tune_outlined, () => _scrollTo(_skillsKey)),
      _NavItem(
          t.navProjects, Icons.work_outline, () => _scrollTo(_projectsKey)),
      _NavItem(t.navContact, Icons.mail_outline, () => _scrollTo(_contactKey)),
    ];

    if (isSmall) {
      return items
          .map((e) => ListTile(
                title: Text(e.label),
                onTap: () {
                  Navigator.of(context).pop();
                  e.onTap();
                },
              ))
          .toList();
    }

    return items
        .map((e) => TextButton(
              onPressed: e.onTap,
              child: Text(e.label),
            ))
        .toList();
  }

  Widget _buildMobileDrawer() {
    final theme = Theme.of(context);
    final t = strings;
    final navItems = <_NavItem>[
      _NavItem(t.navHome, Icons.home_outlined, () => _scrollTo(_homeKey)),
      _NavItem(t.navAbout, Icons.badge_outlined, () => _scrollTo(_aboutKey)),
      _NavItem(t.navSkills, Icons.tune_outlined, () => _scrollTo(_skillsKey)),
      _NavItem(
          t.navProjects, Icons.work_outline, () => _scrollTo(_projectsKey)),
      _NavItem(t.navContact, Icons.mail_outline, () => _scrollTo(_contactKey)),
    ];

    void openSection(_NavItem item) {
      Navigator.of(context).pop();
      item.onTap();
    }

    return Drawer(
      width: 320,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: theme.colorScheme.primary,
                      foregroundImage: const AssetImage(Images.profile),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'BO CHHORANNDORN',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            t.role,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onPrimaryContainer
                                  .withValues(alpha: 0.74),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 14, 12, 8),
                    child: Text(
                      t.navigation,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  ...navItems.map(
                    (item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        leading: Icon(item.icon),
                        title: Text(item.label),
                        trailing: const Icon(Icons.chevron_right, size: 18),
                        onTap: () => openSection(item),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 14, 12, 8),
                    child: Text(
                      t.languageLabel,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  ...AppLanguage.values.map(
                    (language) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: RadioListTile<AppLanguage>(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        value: language,
                        groupValue: widget.language,
                        title: Text(language.label),
                        secondary: _FlagBadge(language: language),
                        onChanged: (value) {
                          if (value == null) return;
                          widget.onLanguageChanged(value);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(12),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                leading: Icon(widget.themeMode == ThemeMode.dark
                    ? Icons.light_mode
                    : Icons.dark_mode),
                title: Text(widget.themeMode == ThemeMode.dark
                    ? t.lightMode
                    : t.darkMode),
                subtitle: Text(t.changeAppearance),
                onTap: () {
                  Navigator.of(context).pop();
                  widget.onToggleTheme();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 900;
        final t = strings;
        return Scaffold(
          appBar: AppBar(
            title: Text(t.appTitle),
            actions: [
              if (!isSmall) ..._buildActions(false),
              if (!isSmall)
                _LanguageMenu(
                  selected: widget.language,
                  onChanged: widget.onLanguageChanged,
                  tooltip: t.languageLabel,
                ),
              IconButton(
                tooltip: widget.themeMode == ThemeMode.dark
                    ? t.switchToLightMode
                    : t.switchToDarkMode,
                icon: Icon(widget.themeMode == ThemeMode.dark
                    ? Icons.light_mode
                    : Icons.dark_mode),
                onPressed: widget.onToggleTheme,
              ),
            ],
          ),
          drawer: isSmall ? _buildMobileDrawer() : null,
          body: Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                        key: _homeKey,
                        child: HeroSection(
                            strings: t,
                            onContactTap: () => _scrollTo(_contactKey),
                            onProjectsTap: () => _scrollTo(_projectsKey))),
                    Container(key: _aboutKey, child: AboutSection(strings: t)),
                    Container(
                        key: _skillsKey, child: SkillsSection(strings: t)),
                    Container(
                        key: _projectsKey, child: ProjectsSection(strings: t)),
                    Container(
                        key: _contactKey, child: ContactSection(strings: t)),
                    const SizedBox(height: 24),
                    _Footer(strings: t),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: _ScrollProgressBar(progress: _scrollProgress),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ScrollProgressBar extends StatelessWidget {
  final double progress;

  const _ScrollProgressBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 3,
      child: Stack(
        children: [
          Positioned.fill(
            child: ColoredBox(
              color: theme.colorScheme.surfaceContainerHighest
                  .withValues(alpha: 0.22),
            ),
          ),
          FractionallySizedBox(
            widthFactor: progress,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.secondary,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  _NavItem(this.label, this.icon, this.onTap);
}

class _LanguageMenu extends StatelessWidget {
  final AppLanguage selected;
  final ValueChanged<AppLanguage> onChanged;
  final String tooltip;

  const _LanguageMenu({
    required this.selected,
    required this.onChanged,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PopupMenuButton<AppLanguage>(
      tooltip: tooltip,
      initialValue: selected,
      onSelected: onChanged,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: theme.colorScheme.outlineVariant),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _FlagBadge(language: selected, size: 24),
              const SizedBox(width: 8),
              Text(
                selected.shortLabel,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
      itemBuilder: (context) {
        return AppLanguage.values
            .map(
              (language) => PopupMenuItem(
                value: language,
                child: Row(
                  children: [
                    _FlagBadge(language: language, size: 24),
                    const SizedBox(width: 10),
                    Expanded(child: Text(language.label)),
                    if (selected == language)
                      Icon(
                        Icons.check,
                        size: 18,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                  ],
                ),
              ),
            )
            .toList();
      },
    );
  }
}

class _FlagBadge extends StatelessWidget {
  final AppLanguage language;
  final double size;

  const _FlagBadge({required this.language, this.size = 28});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: size + 6,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        language.flagAsset,
        width: size + 6,
        height: size,
        fit: BoxFit.cover,
        cacheWidth: 64,
        filterQuality: FilterQuality.medium,
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final AppStrings strings;

  const _Footer({required this.strings});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Column(
        children: [
          const Divider(height: 1),
          const SizedBox(height: 16),
          Text(
            strings.footer(DateTime.now().year),
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

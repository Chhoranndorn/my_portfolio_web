import 'package:flutter/material.dart';

import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/skills_section.dart';
import 'sections/projects_section.dart';
import 'sections/contact_section.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    final light = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo, brightness: Brightness.light),
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
    final dark = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo, brightness: Brightness.dark),
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Portfolio',
      theme: light,
      darkTheme: dark,
      themeMode: _themeMode,
      home: PortfolioPage(
        onToggleTheme: _toggleTheme,
        themeMode: _themeMode,
      ),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final ThemeMode themeMode;

  const PortfolioPage({super.key, required this.onToggleTheme, required this.themeMode});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();

  final _homeKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _contactKey = GlobalKey();

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

  List<Widget> _buildActions(bool isSmall) {
    final items = <_NavItem>[
      _NavItem('Home', () => _scrollTo(_homeKey)),
      _NavItem('About', () => _scrollTo(_aboutKey)),
      _NavItem('Skills', () => _scrollTo(_skillsKey)),
      _NavItem('Projects', () => _scrollTo(_projectsKey)),
      _NavItem('Contact', () => _scrollTo(_contactKey)),
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 900;
        return Scaffold(
          appBar: AppBar(
            title: const Text('My Portfolio'),
            actions: [
              if (!isSmall) ..._buildActions(false),
              IconButton(
                tooltip: widget.themeMode == ThemeMode.dark ? 'Switch to light mode' : 'Switch to dark mode',
                icon: Icon(widget.themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode),
                onPressed: widget.onToggleTheme,
              ),
            ],
          ),
          drawer: isSmall
              ? Drawer(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    children: [
                      const ListTile(
                        title: Text(
                          'Navigate',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      ..._buildActions(true),
                    ],
                  ),
                )
              : null,
          body: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(key: _homeKey, child: HeroSection(onContactTap: () => _scrollTo(_contactKey), onProjectsTap: () => _scrollTo(_projectsKey))),
                Container(key: _aboutKey, child: const AboutSection()),
                Container(key: _skillsKey, child: const SkillsSection()),
                Container(key: _projectsKey, child: const ProjectsSection()),
                Container(key: _contactKey, child: const ContactSection()),
                const SizedBox(height: 24),
                const _Footer(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _NavItem {
  final String label;
  final VoidCallback onTap;
  _NavItem(this.label, this.onTap);
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Column(
        children: [
          const Divider(height: 1),
          const SizedBox(height: 16),
          Text(
            '© ${DateTime.now().year} BO CHHORANNDORN · Built with Flutter',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

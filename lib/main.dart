import 'package:flutter/material.dart';

import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/skills_section.dart';
import 'sections/projects_section.dart';
import 'sections/contact_section.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Portfolio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

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
            actions: isSmall ? null : _buildActions(false),
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
            '© ${DateTime.now().year} Your Name · Built with Flutter',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

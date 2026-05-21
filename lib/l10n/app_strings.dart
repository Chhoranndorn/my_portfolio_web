import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:my_porfolio_web/util/images.dart';

enum AppLanguage {
  en('English', 'EN', Images.usflage, 'assets/i18n/en.json'),
  km('ភាសាខ្មែរ', 'ខ្មែរ', Images.khflage, 'assets/i18n/km.json'),
  zh('中文', '中文', Images.cnflage, 'assets/i18n/zh.json');

  final String label;
  final String shortLabel;
  final String flagAsset;
  final String assetPath;

  const AppLanguage(
      this.label, this.shortLabel, this.flagAsset, this.assetPath);
}

class AppStrings {
  final AppLanguage language;
  final Map<String, dynamic> _data;

  const AppStrings._(this.language, this._data);

  static Future<AppStrings> load(AppLanguage language) async {
    final jsonText = await rootBundle.loadString(language.assetPath);
    final data = jsonDecode(jsonText) as Map<String, dynamic>;
    return AppStrings._(language, data);
  }

  String _text(String key) => _data[key] as String? ?? key;

  List<String> _stringList(Object? value) {
    return (value as List<dynamic>? ?? const [])
        .map((item) => item.toString())
        .toList();
  }

  String get appTitle => _text('appTitle');
  String get role => _text('role');
  String get portfolioTitle => _text('portfolioTitle');
  String get navHome => _text('navHome');
  String get navAbout => _text('navAbout');
  String get navSkills => _text('navSkills');
  String get navProjects => _text('navProjects');
  String get navContact => _text('navContact');
  String get navigation => _text('navigation');
  String get languageLabel => _text('languageLabel');
  String get lightMode => _text('lightMode');
  String get darkMode => _text('darkMode');
  String get changeAppearance => _text('changeAppearance');
  String get switchToLightMode => _text('switchToLightMode');
  String get switchToDarkMode => _text('switchToDarkMode');
  String get heroBadge => _text('heroBadge');
  String get heroIntro => _text('heroIntro');
  String get addressLabel => _text('addressLabel');
  String get phoneLabel => _text('phoneLabel');
  String get emailLabel => _text('emailLabel');
  String get address => _text('address');
  String get viewProjects => _text('viewProjects');
  String get contactMe => _text('contactMe');
  String get downloadCv => _text('downloadCv');
  String get statApps => _text('statApps');
  String get statStores => _text('statStores');
  String get statApi => _text('statApi');
  String get aboutTitle => _text('aboutTitle');
  String get aboutSubtitle => _text('aboutSubtitle');
  String get skillsTitle => _text('skillsTitle');
  String get skillsSubtitle => _text('skillsSubtitle');
  String get projectsTitle => _text('projectsTitle');
  String get projectsSubtitle => _text('projectsSubtitle');
  String get googlePlay => _text('googlePlay');
  String get appStore => _text('appStore');
  String get contactTitle => _text('contactTitle');
  String get contactSubtitle => _text('contactSubtitle');
  String get copyEmail => _text('copyEmail');
  String get copied => _text('copied');
  String get location => _text('location');
  String get spokenLanguages => _text('spokenLanguages');

  String footer(int year) => _text('footer').replaceAll('{year}', '$year');

  List<LocalizedJob> get jobs {
    return (_data['jobs'] as List<dynamic>? ?? const []).map((item) {
      final job = item as Map<String, dynamic>;
      return LocalizedJob(
        role: job['role'] as String,
        duration: job['duration'] as String,
        company: job['company'] as String,
        responsibilities: _stringList(job['responsibilities']),
      );
    }).toList();
  }

  Map<String, List<String>> get skills {
    final raw = _data['skills'] as Map<String, dynamic>? ?? const {};
    return raw
        .map((category, values) => MapEntry(category, _stringList(values)));
  }

  List<LocalizedProject> get projects {
    return (_data['projects'] as List<dynamic>? ?? const []).map((item) {
      final project = item as Map<String, dynamic>;
      return LocalizedProject(
        title: project['title'] as String,
        role: project['role'] as String,
        type: project['type'] as String,
        techStack: project['techStack'] as String,
        description: project['description'] as String,
        highlights: _stringList(project['highlights']),
        imageUrl: _projectImage(project['imageKey'] as String?),
        googlePlayUrl: project['googlePlayUrl'] as String,
        appStoreUrl: project['appStoreUrl'] as String,
      );
    }).toList();
  }

  String _projectImage(String? key) {
    return switch (key) {
      'mvp' => Images.mvp,
      'npn' => Images.npn,
      'mol' => Images.mol,
      _ => Images.mvp,
    };
  }
}

class LocalizedJob {
  final String role;
  final String duration;
  final String company;
  final List<String> responsibilities;

  const LocalizedJob({
    required this.role,
    required this.duration,
    required this.company,
    required this.responsibilities,
  });
}

class LocalizedProject {
  final String title;
  final String role;
  final String type;
  final String techStack;
  final String description;
  final List<String> highlights;
  final String imageUrl;
  final String googlePlayUrl;
  final String appStoreUrl;

  const LocalizedProject({
    required this.title,
    required this.role,
    required this.type,
    required this.techStack,
    required this.description,
    required this.highlights,
    required this.imageUrl,
    required this.googlePlayUrl,
    required this.appStoreUrl,
  });
}

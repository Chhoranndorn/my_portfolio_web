class Project {
  final String title;
  final String description;
  final List<String> technologies;
  final String? imageUrl;
  final String? link;

  const Project({
    required this.title,
    required this.description,
    required this.technologies,
    this.imageUrl,
    this.link,
  });
}


class Project {
  final String number;
  final String category;
  final String title;
  final String subtitle;
  final String description;
  final List<String> bullets;
  final List<String> tags;
  final String imagePath;
  final bool imageLeft;

  const Project({
    required this.number,
    required this.category,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.bullets,
    required this.tags,
    required this.imagePath,
    required this.imageLeft,
  });
}

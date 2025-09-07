class Project {
  final String title;
  final String description;
  final List<String> tags;
  final String? videoUrl;
  final String? githubUrl;

  Project({
    required this.title,
    required this.description,
    required this.tags,
    this.videoUrl,
    this.githubUrl,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      title: json['title'],
      description: json['description'],
      tags: (json['tags'] as List).map((tag) => tag['name'] as String).toList(),
      videoUrl: json['videoUrl'],
      githubUrl: json['githubUrl'],
    );
  }
}

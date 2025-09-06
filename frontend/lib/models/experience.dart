class Experience {
  final String title;
  final String company;
  final String location;
  final DateTime startDate;
  final DateTime? endDate;
  final String photoUrl;
  final String description;
  final List<String> tags;

  Experience({
    required this.title,
    required this.company,
    required this.location,
    required this.startDate,
    this.endDate,
    required this.photoUrl,
    required this.description,
    required this.tags,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      title: json['title'],
      company: json['company'],
      location: json['location'],
      startDate: DateTime.parse(json['startDate']),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      photoUrl: json['photoUrl'],
      description: json['description'],
      tags: (json['tags'] as List).map((tag) => tag['name'] as String).toList(),
    );
  }
}

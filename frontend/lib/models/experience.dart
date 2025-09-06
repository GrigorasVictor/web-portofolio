class Experience {
  final String degree;
  final String institution;
  final String location;
  final DateTime startDate;
  final DateTime endDate;
  final String photoUrl;

  Experience({
    required this.degree,
    required this.institution,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.photoUrl,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      degree: json['degree'],
      institution: json['institution'],
      location: json['location'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      photoUrl: json['photoUrl'],
    );
  }
}

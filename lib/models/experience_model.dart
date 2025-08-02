class ExperienceModel {
  final String id;
  final String title;
  final String company;
  final String duration;
  final String location;
  final String description;
  final List<String> achievements;
  final bool isCurrent;

  ExperienceModel({
    required this.id,
    required this.title,
    required this.company,
    required this.duration,
    required this.location,
    required this.description,
    required this.achievements,
    this.isCurrent = false,
  });
}

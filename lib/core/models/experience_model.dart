class ExperienceModel {
  final String company;
  final String role;
  final String duration;
  final List<String> points;

  const ExperienceModel({
    required this.company,
    required this.role,
    required this.duration,
    required this.points,
  });
}

class EducationModel {
  final String institute;
  final String degree;
  final String duration;
  final List<String> points;

  const EducationModel({
    required this.institute,
    required this.degree,
    required this.duration,
    required this.points,
  });
}

class ProjectModel {
  final String title;
  final String description;
  final List<String> tags;
  final List<ProjectLink> links;

  const ProjectModel({
    required this.title,
    required this.description,
    required this.tags,
    this.links = const [],
  });
}

class ProjectLink {
  final String label;
  final String url;
  final ProjectLinkType type;

  const ProjectLink({
    required this.label,
    required this.url,
    required this.type,
  });
}

enum ProjectLinkType { playStore, appStore, github, website }

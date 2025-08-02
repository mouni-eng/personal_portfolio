class ProjectModel {
  final String id;
  final String name;
  final String description;
  final String logoPath;
  final String? googlePlayUrl;
  final String? appStoreUrl;
  final List<String> technologies;
  final List<String> features;
  final ProjectType type;
  final String company;
  final String duration;

  ProjectModel({
    required this.id,
    required this.name,
    required this.description,
    required this.logoPath,
    this.googlePlayUrl,
    this.appStoreUrl,
    required this.technologies,
    required this.features,
    required this.type,
    required this.company,
    required this.duration,
  });

  bool get hasGooglePlay => googlePlayUrl != null && googlePlayUrl!.isNotEmpty;
  bool get hasAppStore => appStoreUrl != null && appStoreUrl!.isNotEmpty;
  bool get isMvpOnly => type == ProjectType.mvp;
  bool get isAppStoreOnly => type == ProjectType.appStoreOnly;
}

enum ProjectType {
  published, // Available on both stores
  mvp, // MVP only
  appStoreOnly // Apple Store only
}

class SkillModel {
  final String name;
  final int proficiencyLevel; // 1-5 scale
  final String? iconPath;

  SkillModel({
    required this.name,
    required this.proficiencyLevel,
    this.iconPath,
  });
}

class SkillCategory {
  final String title;
  final List<SkillModel> skills;

  SkillCategory({
    required this.title,
    required this.skills,
  });
}

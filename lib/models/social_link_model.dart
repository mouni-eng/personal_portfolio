class SocialLinkModel {
  final String name;
  final String url;
  final String iconPath;
  final SocialLinkType type;

  SocialLinkModel({
    required this.name,
    required this.url,
    required this.iconPath,
    required this.type,
  });
}

enum SocialLinkType {
  linkedin,
  instagram,
  facebook,
  twitter,
  whatsapp,
  email,
  phone,
  upwork,
  github,
}

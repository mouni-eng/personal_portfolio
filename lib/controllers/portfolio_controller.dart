import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:universal_html/html.dart' as html;
import '../models/project_model.dart';
import '../models/experience_model.dart';
import '../models/skill_model.dart';
import '../models/social_link_model.dart';
import '../core/managers/assets_manager.dart';
import '../core/managers/svgs_manager.dart';
import '../core/utils/string_extensions.dart';

class PortfolioController extends GetxController {
  // Theme Management
  final RxBool isDarkMode = false.obs;

  // Navigation
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final RxInt currentSection = 0.obs;
  final RxBool isDrawerOpen = false.obs;

  // Scroll to top functionality
  final RxBool showScrollToTop = false.obs;

  // Section keys for scrolling
  final List<String> sectionKeys = [
    'hero',
    'about',
    'experience',
    'projects',
    'contact'
  ];

  @override
  void onInit() {
    super.onInit();
    // Listen to scroll position changes
    itemPositionsListener.itemPositions.addListener(_updateCurrentSection);
  }

  void _updateCurrentSection() {
    final positions = itemPositionsListener.itemPositions.value;
    if (positions.isNotEmpty) {
      // Find the section that's most visible on screen
      double maxVisibleArea = 0;
      int mostVisibleIndex = 0;

      for (final position in positions) {
        final itemIndex = position.index;
        final visibleArea = _calculateVisibleArea(position);

        if (visibleArea > maxVisibleArea && itemIndex < sectionKeys.length) {
          maxVisibleArea = visibleArea;
          mostVisibleIndex = itemIndex;
        }
      }

      // Update current section and scroll to top visibility
      currentSection.value = mostVisibleIndex;
      showScrollToTop.value =
          mostVisibleIndex > 0 || (positions.first.itemTrailingEdge < 0.8);
    }
  }

  double _calculateVisibleArea(ItemPosition position) {
    final leadingEdge = position.itemLeadingEdge;
    final trailingEdge = position.itemTrailingEdge;

    if (leadingEdge >= 1.0 || trailingEdge <= 0.0) {
      return 0.0; // Not visible
    }

    final visibleLeading = leadingEdge < 0.0 ? 0.0 : leadingEdge;
    final visibleTrailing = trailingEdge > 1.0 ? 1.0 : trailingEdge;

    return visibleTrailing - visibleLeading;
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  void scrollToSection(int index) {
    if (itemScrollController.isAttached) {
      itemScrollController.scrollTo(
        index: index,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
      currentSection.value = index;
    }
  }

  void scrollToTop() {
    if (itemScrollController.isAttached) {
      itemScrollController.scrollTo(
        index: 0,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  void toggleDrawer() {
    isDrawerOpen.value = !isDrawerOpen.value;
  }

  void closeDrawer() {
    isDrawerOpen.value = false;
  }

  // Download CV functionality
  Future<void> downloadCV() async {
    try {
      // Load the CV file from assets
      final ByteData data =
          await rootBundle.load('assets/files/mohamed-mounir-flutter-cv.pdf');
      final Uint8List bytes = data.buffer.asUint8List();

      // Create a blob and download it
      final blob = html.Blob([bytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);

      // Create download link
      final anchor = html.AnchorElement(href: url)
        ..target = 'blank'
        ..download = 'Mohamed_Mounir_Flutter_CV.pdf';

      // Trigger download
      html.document.body?.append(anchor);
      anchor.click();
      anchor.remove();

      // Clean up the URL
      html.Url.revokeObjectUrl(url);

      Get.snackbar(
        'Download Started',
        'CV download has been initiated',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      debugPrint('Error downloading CV: $e');
      Get.snackbar(
        'Download Failed',
        'Unable to download CV. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  // Portfolio Data
  List<ProjectModel> get projects => [
        ProjectModel(
          id: 'alpha_drive',
          name: 'projects.alpha_drive.name'.translate,
          description: 'projects.alpha_drive.description'.translate,
          logoPath: AssetsManager.alphaLogo,
          googlePlayUrl:
              'https://play.google.com/store/apps/details?id=com.alpha.drive&pcampaignid=web_share',
          appStoreUrl:
              'https://apps.apple.com/eg/app/alpha-drive-customer/id6739975764',
          technologies: [
            'technologies.flutter'.translate,
            'technologies.dart'.translate,
            'technologies.websockets'.translate,
            'technologies.google_maps'.translate,
            'technologies.firebase'.translate
          ],
          features: [
            'projects.alpha_drive.feature_1'.translate,
            'projects.alpha_drive.feature_2'.translate,
            'projects.alpha_drive.feature_3'.translate,
            'projects.alpha_drive.feature_4'.translate
          ],
          type: ProjectType.published,
          company: 'Alpha Drive',
          duration: 'Dec 2024 — Current',
        ),
        ProjectModel(
          id: 'chaqt',
          name: 'projects.chaqt.name'.translate,
          description: 'projects.chaqt.description'.translate,
          logoPath: AssetsManager.chaqtLogo,
          googlePlayUrl:
              'https://play.google.com/store/apps/details?id=com.chaqt.app&hl=en',
          appStoreUrl: 'https://apps.apple.com/eg/app/chaqt/id6743349098',
          technologies: [
            'technologies.flutter'.translate,
            'technologies.dart'.translate,
            'technologies.websockets'.translate,
            'technologies.in_app_purchases'.translate,
            'technologies.firebase'.translate
          ],
          features: [
            'projects.chaqt.feature_1'.translate,
            'projects.chaqt.feature_2'.translate,
            'projects.chaqt.feature_3'.translate,
            'projects.chaqt.feature_4'.translate
          ],
          type: ProjectType.published,
          company: 'CHAQT LLC',
          duration: 'Nov 2024 — Current',
        ),
        ProjectModel(
          id: 'marketplace',
          name: 'projects.marketplace.name'.translate,
          description: 'projects.marketplace.description'.translate,
          logoPath: AssetsManager.marketplaceLogo,
          technologies: [
            'technologies.flutter'.translate,
            'technologies.dart'.translate,
            'technologies.rest_apis'.translate,
            'technologies.firebase'.translate,
            'technologies.push_notifications'.translate
          ],
          features: [
            'projects.marketplace.feature_1'.translate,
            'projects.marketplace.feature_2'.translate,
            'projects.marketplace.feature_3'.translate,
            'projects.marketplace.feature_4'.translate
          ],
          type: ProjectType.mvp,
          company: 'Diyar United Company',
          duration: 'Apr 2025 — Current',
        ),
        ProjectModel(
          id: 'lahzi',
          name: 'projects.lahzi.name'.translate,
          description: 'projects.lahzi.description'.translate,
          logoPath: AssetsManager.lahziLogo,
          appStoreUrl: 'https://apps.apple.com/eg/app/lahzi/id6745610221',
          technologies: [
            'technologies.flutter'.translate,
            'technologies.dart'.translate,
            'technologies.websockets'.translate,
            'technologies.real_time_updates'.translate,
            'technologies.firebase'.translate
          ],
          features: [
            'projects.lahzi.feature_1'.translate,
            'projects.lahzi.feature_2'.translate,
            'projects.lahzi.feature_3'.translate,
            'projects.lahzi.feature_4'.translate
          ],
          type: ProjectType.appStoreOnly,
          company: 'Nextera',
          duration: 'Dec 2024 — Sep 2025',
        ),
        ProjectModel(
          id: 'rentx',
          name: 'projects.rentx.name'.translate,
          description: 'projects.rentx.description'.translate,
          logoPath: AssetsManager.rentxLogo,
          googlePlayUrl:
              'https://play.google.com/store/apps/details?id=com.inoventgroup.rentx&pcampaignid=web_share',
          appStoreUrl:
              'https://apps.apple.com/eg/app/rentx-car-rentals/id6446690464',
          technologies: [
            'technologies.flutter'.translate,
            'technologies.dart'.translate,
            'technologies.calendar_integration'.translate,
            'technologies.payment_gateway'.translate,
            'technologies.firebase'.translate
          ],
          features: [
            'projects.rentx.feature_1'.translate,
            'projects.rentx.feature_2'.translate,
            'projects.rentx.feature_3'.translate,
            'projects.rentx.feature_4'.translate,
            'projects.rentx.feature_5'.translate
          ],
          type: ProjectType.published,
          company: 'Rentx',
          duration: 'Jul 2023 — Dec 2023',
        ),
      ];

  List<ExperienceModel> get experiences => [
        ExperienceModel(
          id: 'alpha_drive_exp',
          title: 'experiences.alpha_drive.title'.translate,
          company: 'experiences.alpha_drive.company'.translate,
          duration: 'experiences.alpha_drive.duration'.translate,
          location: 'experiences.alpha_drive.location'.translate,
          description: 'experiences.alpha_drive.description'.translate,
          achievements: [
            'experiences.alpha_drive.achievement_1'.translate,
            'experiences.alpha_drive.achievement_2'.translate,
            'experiences.alpha_drive.achievement_3'.translate
          ],
          isCurrent: true,
        ),
        ExperienceModel(
          id: 'chaqt_exp',
          title: 'experiences.chaqt.title'.translate,
          company: 'experiences.chaqt.company'.translate,
          duration: 'experiences.chaqt.duration'.translate,
          location: 'experiences.chaqt.location'.translate,
          description: 'experiences.chaqt.description'.translate,
          achievements: [
            'experiences.chaqt.achievement_1'.translate,
            'experiences.chaqt.achievement_2'.translate,
            'experiences.chaqt.achievement_3'.translate
          ],
          isCurrent: true,
        ),
        ExperienceModel(
          id: 'diyar_exp',
          title: 'experiences.diyar.title'.translate,
          company: 'experiences.diyar.company'.translate,
          duration: 'experiences.diyar.duration'.translate,
          location: 'experiences.diyar.location'.translate,
          description: 'experiences.diyar.description'.translate,
          achievements: [
            'experiences.diyar.achievement_1'.translate,
            'experiences.diyar.achievement_2'.translate,
            'experiences.diyar.achievement_3'.translate,
            'experiences.diyar.achievement_4'.translate,
            'experiences.diyar.achievement_5'.translate
          ],
          isCurrent: true,
        ),
        ExperienceModel(
          id: 'nextera_exp',
          title: 'experiences.nextera.title'.translate,
          company: 'experiences.nextera.company'.translate,
          duration: 'experiences.nextera.duration'.translate,
          location: 'experiences.nextera.location'.translate,
          description: 'experiences.nextera.description'.translate,
          achievements: [
            'experiences.nextera.achievement_1'.translate,
            'experiences.nextera.achievement_2'.translate,
            'experiences.nextera.achievement_3'.translate
          ],
        ),
        ExperienceModel(
          id: 'rentx_exp',
          title: 'experiences.rentx.title'.translate,
          company: 'experiences.rentx.company'.translate,
          duration: 'experiences.rentx.duration'.translate,
          location: 'experiences.rentx.location'.translate,
          description: 'experiences.rentx.description'.translate,
          achievements: [
            'experiences.rentx.achievement_1'.translate,
            'experiences.rentx.achievement_2'.translate,
            'experiences.rentx.achievement_3'.translate,
            'experiences.rentx.achievement_4'.translate,
            'experiences.rentx.achievement_5'.translate,
            'experiences.rentx.achievement_6'.translate
          ],
        ),
        ExperienceModel(
          id: 'upwork_exp',
          title: 'experiences.upwork.title'.translate,
          company: 'experiences.upwork.company'.translate,
          duration: 'experiences.upwork.duration'.translate,
          location: 'experiences.upwork.location'.translate,
          description: 'experiences.upwork.description'.translate,
          achievements: [],
          isCurrent: true,
        ),
      ];

  List<SkillCategory> get skillCategories => [
        SkillCategory(
          title: 'skills.categories.frontend'.translate,
          skills: [
            SkillModel(name: 'skills.flutter'.translate, proficiencyLevel: 5),
            SkillModel(name: 'skills.dart'.translate, proficiencyLevel: 5),
            SkillModel(name: 'skills.figma'.translate, proficiencyLevel: 4),
          ],
        ),
        SkillCategory(
          title: 'skills.categories.backend'.translate,
          skills: [
            SkillModel(name: 'skills.firebase'.translate, proficiencyLevel: 5),
            SkillModel(name: 'skills.nodejs'.translate, proficiencyLevel: 3),
          ],
        ),
        SkillCategory(
          title: 'skills.categories.soft_skills'.translate,
          skills: [
            SkillModel(
                name: 'skills.problem_solving'.translate, proficiencyLevel: 5),
            SkillModel(
                name: 'skills.team_collaboration'.translate,
                proficiencyLevel: 5),
            SkillModel(
                name: 'skills.project_management'.translate,
                proficiencyLevel: 4),
          ],
        ),
      ];

  List<SocialLinkModel> get socialLinks => [
        SocialLinkModel(
          name: 'social_links.linkedin'.translate,
          url:
              'https://www.linkedin.com/in/mohamed-mounir-2175711b2?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=ios_app',
          iconPath: SvgsManager.linkedinColored,
          type: SocialLinkType.linkedin,
        ),
        SocialLinkModel(
          name: 'social_links.upwork'.translate,
          url:
              'https://www.upwork.com/freelancers/~01e7cebb16cfb01e10?mp_source=share',
          iconPath: SvgsManager.verified,
          type: SocialLinkType.upwork,
        ),
        SocialLinkModel(
          name: 'social_links.email'.translate,
          url: 'mailto:mounirmohamed372@gmail.com',
          iconPath: SvgsManager.email,
          type: SocialLinkType.email,
        ),
        SocialLinkModel(
          name: 'social_links.phone'.translate,
          url: 'tel:+201011020577',
          iconPath: SvgsManager.telephone,
          type: SocialLinkType.phone,
        ),
        SocialLinkModel(
          name: 'social_links.whatsapp'.translate,
          url: 'https://wa.me/201011020577',
          iconPath: SvgsManager.whatsapp,
          type: SocialLinkType.whatsapp,
        ),
      ];
}

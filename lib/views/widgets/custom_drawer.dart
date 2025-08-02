import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../controllers/portfolio_controller.dart';
import '../../core/utils/string_extensions.dart';
import '../../core/theme/app_colors.dart';
import '../../core/managers/assets_manager.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();

    return Drawer(
      width: 280,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).scaffoldBackgroundColor,
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Modern Header
              _buildModernHeader(context),

              // Navigation Section
              Expanded(
                child: AnimationLimiter(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      // Navigation Items
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSectionLabel(context,
                                  'navigation.section_label'.translate),
                              const SizedBox(height: 12),
                              ..._buildNavigationItems(controller, context),
                              const SizedBox(height: 32),
                              _buildSectionLabel(context,
                                  'navigation.quick_actions'.translate),
                              const SizedBox(height: 12),
                              ..._buildQuickActions(context),
                              const SizedBox(height: 32),
                              _buildSectionLabel(
                                  context, 'navigation.connect'.translate),
                              const SizedBox(height: 12),
                              _buildSocialSection(context),
                            ],
                          ),
                        ),
                      ),

                      // Modern Footer
                      _buildModernFooter(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernHeader(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: 0,
      duration: const Duration(milliseconds: 600),
      child: SlideAnimation(
        verticalOffset: -30.0,
        child: FadeInAnimation(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                // Logo
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        const AssetImage(AssetsManager.personalImage),
                    backgroundColor: Colors.white.withOpacity(0.2),
                  ),
                ),

                const SizedBox(height: 16),

                // Name
                AutoSizeText(
                  'hero.name'.translate,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                ),

                const SizedBox(height: 4),

                // Title
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: AutoSizeText(
                    'hero.title'.translate,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: AutoSizeText(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
              letterSpacing: 0.5,
            ),
        maxLines: 1,
      ),
    );
  }

  List<Widget> _buildNavigationItems(
      PortfolioController controller, BuildContext context) {
    final items = [
      {
        'title': 'navigation.home'.translate,
        'icon': Icons.home_outlined,
        'index': 0
      },
      {
        'title': 'navigation.about'.translate,
        'icon': Icons.person_outline,
        'index': 1
      },
      {
        'title': 'navigation.experience'.translate,
        'icon': Icons.work_outline,
        'index': 2
      },
      {
        'title': 'navigation.projects'.translate,
        'icon': Icons.apps_outlined,
        'index': 3
      },
      {
        'title': 'navigation.contact'.translate,
        'icon': Icons.contact_mail_outlined,
        'index': 4
      },
    ];

    return items.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;

      return AnimationConfiguration.staggeredList(
        position: index + 1,
        duration: const Duration(milliseconds: 400),
        child: SlideAnimation(
          horizontalOffset: -50.0,
          child: FadeInAnimation(
            child: Obx(() => _buildModernNavItem(
                  context,
                  item['title'] as String,
                  item['icon'] as IconData,
                  item['index'] as int,
                  controller.currentSection.value == item['index'],
                  () => _navigateToSection(
                      item['index'] as int, controller, context),
                )),
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _buildQuickActions(BuildContext context) {
    final actions = [
      {
        'title': 'hero.download_cv'.translate,
        'icon': Icons.download_outlined,
        'action': () => _downloadCV()
      },
      {
        'title': 'about.upwork_profile'.translate,
        'icon': Icons.verified_outlined,
        'action': () => _launchUrl(
            'https://www.upwork.com/freelancers/~01e7cebb16cfb01e10?mp_source=share')
      },
    ];

    return actions.asMap().entries.map((entry) {
      final index = entry.key;
      final action = entry.value;

      return AnimationConfiguration.staggeredList(
        position: index + 6,
        duration: const Duration(milliseconds: 400),
        child: SlideAnimation(
          horizontalOffset: -50.0,
          child: FadeInAnimation(
            child: _buildActionItem(
              context,
              action['title'] as String,
              action['icon'] as IconData,
              action['action'] as VoidCallback,
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildModernNavItem(
    BuildContext context,
    String title,
    IconData icon,
    int index,
    bool isActive,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.primary.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isActive
                    ? AppColors.primary.withOpacity(0.3)
                    : Colors.transparent,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.primary
                        : AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: isActive ? Colors.white : AppColors.primary,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AutoSizeText(
                    title,
                    style: TextStyle(
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                      color: isActive
                          ? AppColors.primary
                          : Theme.of(context).textTheme.bodyLarge?.color,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                  ),
                ),
                if (isActive)
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.primary,
                    size: 12,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).dividerColor.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: AppColors.secondary,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AutoSizeText(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                  ),
                ),
                Icon(
                  Icons.open_in_new,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                  size: 14,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialSection(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: 8,
      duration: const Duration(milliseconds: 400),
      child: SlideAnimation(
        horizontalOffset: -50.0,
        child: FadeInAnimation(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSocialButton(
                  Icons.business_outlined,
                  () => _launchUrl(
                      'https://www.linkedin.com/in/mohamed-mounir-2175711b2?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=ios_app'),
                ),
                _buildSocialButton(
                  Icons.email_outlined,
                  () => _launchUrl('mailto:mounirmohamed372@gmail.com'),
                ),
                _buildSocialButton(
                  Icons.phone_outlined,
                  () => _launchUrl('tel:+201011020577'),
                ),
                _buildSocialButton(
                  Icons.work_outline,
                  () => _launchUrl(
                      'https://www.upwork.com/freelancers/~01e7cebb16cfb01e10?mp_source=share'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 18,
          ),
        ),
      ),
    );
  }

  Widget _buildModernFooter(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: 9,
      duration: const Duration(milliseconds: 400),
      child: SlideAnimation(
        verticalOffset: 30.0,
        child: FadeInAnimation(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor.withOpacity(0.3),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).dividerColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Icons.flutter_dash,
                        color: AppColors.primary,
                        size: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    AutoSizeText(
                      'footer.built_with'.translate,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToSection(
      int index, PortfolioController controller, BuildContext context) {
    controller.scrollToSection(index);
    Navigator.of(context).pop();
  }

  void _downloadCV() {
    final controller = Get.find<PortfolioController>();
    controller.downloadCV();
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

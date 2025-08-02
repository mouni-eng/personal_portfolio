import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/portfolio_controller.dart';
import '../../core/utils/string_extensions.dart';
import '../../core/theme/app_colors.dart';
import '../../core/managers/assets_manager.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;

    return AnimationLimiter(
      child: AnimationConfiguration.staggeredList(
        position: 0,
        duration: const Duration(milliseconds: 600),
        child: SlideAnimation(
          verticalOffset: 30.0,
          child: FadeInAnimation(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).scaffoldBackgroundColor,
                    AppColors.primary.withOpacity(0.05),
                  ],
                ),
              ),
              child: Column(
                children: [
                  // Main Footer Content
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 16 : (isTablet ? 32 : 48),
                      vertical: 48,
                    ),
                    child: Column(
                      children: [
                        // Logo and Name Section
                        _buildHeader(context, isMobile),

                        const SizedBox(height: 32),

                        // Quick Links
                        if (!isMobile) _buildQuickLinks(context, controller),

                        if (!isMobile) const SizedBox(height: 32),

                        // Social Links
                        _buildSocialLinks(context, controller),

                        const SizedBox(height: 32),

                        // Divider
                        Container(
                          height: 1,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                AppColors.primary.withOpacity(0.3),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Copyright and Built With
                        _buildBottomSection(context, isMobile),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isMobile) {
    return Column(
      children: [
        // Logo
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 30,
            backgroundImage: const AssetImage(AssetsManager.personalImage),
            backgroundColor: AppColors.primary.withOpacity(0.1),
          ),
        ),

        const SizedBox(height: 16),

        // Name and Title
        AutoSizeText(
          'Mohamed Mounir',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.headlineSmall?.color ??
                    (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black),
              ),
          textAlign: TextAlign.center,
          maxLines: 1,
        ),

        const SizedBox(height: 8),

        AutoSizeText(
          'hero.title'.translate,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
          textAlign: TextAlign.center,
          maxLines: 1,
        ),

        const SizedBox(height: 16),

        // Description
        AutoSizeText(
          'footer.description'.translate,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ],
    );
  }

  Widget _buildQuickLinks(
      BuildContext context, PortfolioController controller) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 32,
      runSpacing: 16,
      children: [
        _buildQuickLink(
            'navigation.home'.translate, () => controller.scrollToSection(0)),
        _buildQuickLink(
            'navigation.about'.translate, () => controller.scrollToSection(1)),
        _buildQuickLink('navigation.experience'.translate,
            () => controller.scrollToSection(2)),
        _buildQuickLink('navigation.projects'.translate,
            () => controller.scrollToSection(3)),
        _buildQuickLink('navigation.contact'.translate,
            () => controller.scrollToSection(4)),
      ],
    );
  }

  Widget _buildQuickLink(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AutoSizeText(
        title,
        style: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildSocialLinks(
      BuildContext context, PortfolioController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(
          icon: Icons.email_outlined,
          onTap: () => _launchUrl('mailto:mounirmohamed372@gmail.com'),
        ),
        const SizedBox(width: 16),
        _buildSocialButton(
          icon: Icons.phone_outlined,
          onTap: () => _launchUrl('tel:+201011020577'),
        ),
        const SizedBox(width: 16),
        _buildSocialButton(
          icon: Icons.work_outline,
          onTap: () => _launchUrl(
              'https://www.upwork.com/freelancers/~01e7cebb16cfb01e10?mp_source=share'),
        ),
        const SizedBox(width: 16),
        _buildSocialButton(
          icon: Icons.business_outlined,
          onTap: () => _launchUrl(
              'https://www.linkedin.com/in/mohamed-mounir-2175711b2?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=ios_app'),
        ),
      ],
    );
  }

  Widget _buildSocialButton(
      {required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          color: AppColors.primary,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context, bool isMobile) {
    if (isMobile) {
      return Column(
        children: [
          _buildCopyright(context),
          const SizedBox(height: 12),
          _buildBuiltWith(context),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _buildCopyright(context)),
        Expanded(child: _buildBuiltWith(context)),
      ],
    );
  }

  Widget _buildCopyright(BuildContext context) {
    return AutoSizeText(
      'footer.copyright'.translate,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: (Theme.of(context).brightness == Brightness.dark
                ? Colors.white60
                : Colors.black54),
          ),
      textAlign: TextAlign.center,
      maxLines: 1,
    );
  }

  Widget _buildBuiltWith(BuildContext context) {
    return Row(
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
            size: 16,
          ),
        ),
        const SizedBox(width: 8),
        AutoSizeText(
          'footer.built_with'.translate,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: (Theme.of(context).brightness == Brightness.dark
                    ? Colors.white60
                    : Colors.black54),
                fontWeight: FontWeight.w500,
              ),
          textAlign: TextAlign.center,
          maxLines: 1,
        ),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

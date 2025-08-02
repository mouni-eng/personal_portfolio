import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/portfolio_controller.dart';
import '../../core/utils/string_extensions.dart';
import '../../core/theme/app_colors.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;

    return Container(
      width: double.infinity,
      color: Theme.of(context).cardColor.withOpacity(0.3),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : (isTablet ? 32 : 48),
        vertical: 80,
      ),
      child: AnimationLimiter(
        child: Column(
          children: [
            // Section Title
            AnimationConfiguration.staggeredList(
              position: 0,
              duration: const Duration(milliseconds: 600),
              child: SlideAnimation(
                verticalOffset: 30.0,
                child: FadeInAnimation(
                  child: Column(
                    children: [
                      AutoSizeText(
                        'contact.title'.translate,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 60,
                        height: 4,
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 16),
                      AutoSizeText(
                        'contact.subtitle'.translate,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 48),

            // Contact Info Cards
            _buildContactCards(context, controller, isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCards(
      BuildContext context, PortfolioController controller, bool isMobile) {
    return AnimationConfiguration.staggeredList(
      position: 1,
      duration: const Duration(milliseconds: 800),
      child: SlideAnimation(
        verticalOffset: 30.0,
        child: FadeInAnimation(
          child: isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildContactCard(
                        context,
                        Icons.email_outlined,
                        'contact.email_label'.translate,
                        'contact.email'.translate,
                        'mailto:mounirmohamed372@gmail.com'),
                    const SizedBox(height: 16),
                    _buildContactCard(
                        context,
                        Icons.phone_outlined,
                        'contact.phone_label'.translate,
                        'contact.phone'.translate,
                        'tel:+201011020577'),
                    const SizedBox(height: 16),
                    _buildContactCard(
                        context,
                        Icons.location_on_outlined,
                        'contact.location_label'.translate,
                        'contact.location'.translate,
                        null),
                    const SizedBox(height: 32),
                    _buildSocialLinks(context, controller),
                  ],
                )
              : Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: _buildContactCard(
                                context,
                                Icons.email_outlined,
                                'contact.email_label'.translate,
                                'contact.email'.translate,
                                'mailto:mounirmohamed372@gmail.com')),
                        const SizedBox(width: 16),
                        Expanded(
                            child: _buildContactCard(
                                context,
                                Icons.phone_outlined,
                                'contact.phone_label'.translate,
                                'contact.phone'.translate,
                                'tel:+201011020577')),
                        const SizedBox(width: 16),
                        Expanded(
                            child: _buildContactCard(
                                context,
                                Icons.location_on_outlined,
                                'contact.location_label'.translate,
                                'contact.location'.translate,
                                null)),
                      ],
                    ),
                    const SizedBox(height: 32),
                    _buildSocialLinks(context, controller),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildContactCard(BuildContext context, IconData icon, String title,
      String value, String? url) {
    return GestureDetector(
      onTap: url != null ? () => _launchUrl(url) : null,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(height: 16),
            AutoSizeText(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              maxLines: 1,
            ),
            const SizedBox(height: 8),
            AutoSizeText(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialLinks(
      BuildContext context, PortfolioController controller) {
    return AnimationConfiguration.staggeredList(
      position: 2,
      duration: const Duration(milliseconds: 1000),
      child: SlideAnimation(
        verticalOffset: 30.0,
        child: FadeInAnimation(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                AutoSizeText(
                  'contact.follow_me'.translate,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  maxLines: 1,
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: controller.socialLinks
                      .map(
                        (social) => _buildSocialButton(
                            context, social.iconPath, social.url, social.name),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(
      BuildContext context, String iconPath, String url, String name) {
    return GestureDetector(
      onTap: () => _launchUrl(url),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: SvgPicture.asset(
            iconPath,
            width: 28,
            height: 28,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

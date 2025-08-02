import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/utils/string_extensions.dart';
import '../../core/theme/app_colors.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;

    return Container(
      width: double.infinity,
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
                        'about.title'.translate,
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
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 48),

            // Main Content
            if (isMobile)
              Column(
                children: [
                  _buildDescription(context),
                  const SizedBox(height: 40),
                  _buildStatistics(context, isMobile),
                  const SizedBox(height: 40),
                  _buildUpworkHighlight(context),
                ],
              )
            else
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description
                  Expanded(
                    flex: 3,
                    child: _buildDescription(context),
                  ),

                  const SizedBox(width: 48),

                  // Statistics & Highlight
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        _buildStatistics(context, isMobile),
                        const SizedBox(height: 32),
                        _buildUpworkHighlight(context),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: 1,
      duration: const Duration(milliseconds: 800),
      child: SlideAnimation(
        horizontalOffset: -50.0,
        child: FadeInAnimation(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                'about.description'.translate,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.8,
                      fontSize: 16,
                    ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 24),
              AutoSizeText(
                'about.upwork_description'.translate,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.7,
                    ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatistics(BuildContext context, bool isMobile) {
    return AnimationConfiguration.staggeredList(
      position: 2,
      duration: const Duration(milliseconds: 1000),
      child: SlideAnimation(
        horizontalOffset: 50.0,
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
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: isMobile
                ? Column(
                    children: [
                      _buildStatItem(
                          context,
                          'about.years_experience'.translate,
                          'about.years_label'.translate),
                      const SizedBox(height: 20),
                      _buildStatItem(
                          context,
                          'about.projects_completed'.translate,
                          'about.projects_label'.translate),
                      const SizedBox(height: 20),
                      _buildStatItem(context, 'about.happy_clients'.translate,
                          'about.clients_label'.translate),
                    ],
                  )
                : Column(
                    children: [
                      _buildStatItem(
                          context,
                          'about.years_experience'.translate,
                          'about.years_label'.translate),
                      const SizedBox(height: 24),
                      _buildStatItem(
                          context,
                          'about.projects_completed'.translate,
                          'about.projects_label'.translate),
                      const SizedBox(height: 24),
                      _buildStatItem(context, 'about.happy_clients'.translate,
                          'about.clients_label'.translate),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label) {
    return Column(
      children: [
        AutoSizeText(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
          maxLines: 1,
        ),
        const SizedBox(height: 4),
        AutoSizeText(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ],
    );
  }

  Widget _buildUpworkHighlight(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: 3,
      duration: const Duration(milliseconds: 1200),
      child: SlideAnimation(
        verticalOffset: 30.0,
        child: FadeInAnimation(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(16),
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
                const Icon(
                  Icons.verified,
                  color: Colors.white,
                  size: 32,
                ),
                const SizedBox(height: 12),
                AutoSizeText(
                  'about.highlight'.translate,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _launchUpworkProfile(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.open_in_new, size: 18),
                      const SizedBox(width: 8),
                      AutoSizeText(
                        'about.view_profile'.translate,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUpworkProfile() async {
    final uri = Uri.parse(
        'https://www.upwork.com/freelancers/~01e7cebb16cfb01e10?mp_source=share');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

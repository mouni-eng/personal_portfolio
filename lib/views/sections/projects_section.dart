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
import '../../core/managers/svgs_manager.dart';
import '../../models/project_model.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();
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
                        'projects.title'.translate,
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

            // Projects Grid
            _buildProjectsGrid(
                context, controller.projects, isMobile, isTablet),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectsGrid(BuildContext context, List<ProjectModel> projects,
      bool isMobile, bool isTablet) {
    if (isMobile) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index + 1,
            duration: const Duration(milliseconds: 800),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: _buildProjectCard(context, projects[index], isMobile),
                ),
              ),
            ),
          );
        },
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isTablet ? 2 : 3,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: isTablet ? 0.8 : 0.75,
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        return AnimationConfiguration.staggeredGrid(
          position: index,
          duration: const Duration(milliseconds: 800),
          columnCount: isTablet ? 2 : 3,
          child: ScaleAnimation(
            child: FadeInAnimation(
              child: _buildProjectCard(context, projects[index], isMobile),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProjectCard(
      BuildContext context, ProjectModel project, bool isMobile) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project Image/Logo
          Container(
            width: double.infinity,
            height: isMobile ? 120 : 140,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              gradient: AppColors.primaryGradient.scale(0.3),
            ),
            child: Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    project.logoPath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Project Name
                AutoSizeText(
                  project.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                  maxLines: 1,
                ),

                const SizedBox(height: 4),

                // Company
                AutoSizeText(
                  project.company,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                  maxLines: 1,
                ),

                const SizedBox(height: 8),

                // Duration
                AutoSizeText(
                  project.duration,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 1,
                ),

                const SizedBox(height: 12),

                // Description
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: isMobile ? 60 : 50,
                    maxHeight: isMobile ? 80 : 70,
                  ),
                  child: AutoSizeText(
                    project.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          height: 1.5,
                        ),
                    maxLines: isMobile ? 4 : 3,
                    overflow: TextOverflow.ellipsis,
                    minFontSize: 10,
                  ),
                ),

                const SizedBox(height: 16),

                // Technologies
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: project.technologies
                      .take(3)
                      .map(
                        (tech) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: AutoSizeText(
                            tech,
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      )
                      .toList(),
                ),

                const SizedBox(height: 16),

                // Store Links or Status
                _buildProjectActions(context, project),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectActions(BuildContext context, ProjectModel project) {
    if (project.isMvpOnly) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.warning.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.warning.withOpacity(0.3)),
        ),
        child: AutoSizeText(
          'projects.mvp_only'.translate,
          style: TextStyle(
            color: AppColors.warning,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
        ),
      );
    }

    if (project.isAppStoreOnly) {
      return Container(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () => _launchUrl(project.appStoreUrl!),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          icon: SvgPicture.asset(
            SvgsManager.appleIcon,
            width: 16,
            height: 16,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          label: AutoSizeText(
            'projects.apple_only'.translate,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            maxLines: 1,
          ),
        ),
      );
    }

    // Both stores available
    return Column(
      children: [
        if (project.hasGooglePlay)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 8),
            child: ElevatedButton.icon(
              onPressed: () => _launchUrl(project.googlePlayUrl!),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: SvgPicture.asset(
                SvgsManager.googleIcon,
                width: 16,
                height: 16,
              ),
              label: AutoSizeText(
                'projects.view_on_google'.translate,
                style:
                    const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                maxLines: 1,
              ),
            ),
          ),
        if (project.hasAppStore)
          Container(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _launchUrl(project.appStoreUrl!),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: SvgPicture.asset(
                SvgsManager.appleIcon,
                width: 16,
                height: 16,
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              label: AutoSizeText(
                'projects.view_on_apple'.translate,
                style:
                    const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                maxLines: 1,
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

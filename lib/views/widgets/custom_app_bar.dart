import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../controllers/portfolio_controller.dart';
import '../../controllers/locale_controller.dart';
import '../../core/utils/string_extensions.dart';
import '../../core/managers/svgs_manager.dart';
import '../../core/theme/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;

    return AppBar(
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor.withOpacity(0.95),
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : (isTablet ? 24 : 48),
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.95),
          border: Border(
            bottom: BorderSide(
              color: AppColors.primary.withOpacity(0.1),
              width: 1,
            ),
          ),
        ),
        child: SafeArea(
          child: Row(
            children: [
              // Simple Logo - Code Brackets
              _buildLogo(context),

              const Spacer(),

              // Navigation Menu (Desktop/Tablet)
              if (!isMobile) ...[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildNavItem(
                        context, 'navigation.home'.translate, 0, controller),
                    _buildNavItem(
                        context, 'navigation.about'.translate, 1, controller),
                    _buildNavItem(context, 'navigation.experience'.translate, 2,
                        controller),
                    _buildNavItem(context, 'navigation.projects'.translate, 3,
                        controller),
                    _buildNavItem(
                        context, 'navigation.contact'.translate, 4, controller),
                  ],
                ),
                const SizedBox(width: 24),
              ],

              // Actions
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Theme Toggle
                  Obx(() => IconButton(
                        onPressed: controller.toggleTheme,
                        icon: Icon(
                          controller.isDarkMode.value
                              ? Icons.light_mode_outlined
                              : Icons.dark_mode_outlined,
                          size: 22,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.primary.withOpacity(0.1),
                          foregroundColor: AppColors.primary,
                          minimumSize: const Size(40, 40),
                        ),
                      )),

                  const SizedBox(width: 12),

                  // Language Toggle
                  IconButton(
                    onPressed: () {
                      final localeController = Get.find<LocaleController>();
                      localeController.toggleLanguage();
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                      foregroundColor: AppColors.primary,
                      minimumSize: const Size(40, 40),
                    ),
                    icon: SvgPicture.asset(
                      SvgsManager.language,
                      width: 20,
                      height: 20,
                      colorFilter: const ColorFilter.mode(
                        AppColors.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),

                  // Mobile Menu Button
                  if (isMobile) ...[
                    const SizedBox(width: 12),
                    IconButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.primary.withOpacity(0.1),
                        foregroundColor: AppColors.primary,
                        minimumSize: const Size(40, 40),
                      ),
                      icon: const Icon(Icons.menu, size: 22),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Center(
        child: Text(
          '</>',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: 'monospace',
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String title, int index,
      PortfolioController controller) {
    return Obx(() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: TextButton(
            onPressed: () => controller.scrollToSection(index),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: controller.currentSection.value == index
                  ? AppColors.primary.withOpacity(0.1)
                  : Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: AutoSizeText(
              title,
              style: TextStyle(
                color: controller.currentSection.value == index
                    ? AppColors.primary
                    : Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.color
                        ?.withOpacity(0.8),
                fontWeight: controller.currentSection.value == index
                    ? FontWeight.w600
                    : FontWeight.w500,
                fontSize: 14,
              ),
              maxLines: 1,
            ),
          ),
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 8);
}

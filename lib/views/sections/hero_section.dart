import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../controllers/portfolio_controller.dart';
import '../../core/utils/string_extensions.dart';
import '../../core/theme/app_colors.dart';
import '../../core/managers/assets_manager.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).scaffoldBackgroundColor,
            Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : (isTablet ? 32 : 48),
          vertical: 32,
        ),
        child: AnimationLimiter(
          child: isMobile
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildContent(context, controller, isMobile),
                )
              : Row(
                  children: [
                    // Text Content
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            _buildTextContent(context, controller, isMobile),
                      ),
                    ),

                    const SizedBox(width: 48),

                    // Image
                    Expanded(
                      flex: 2,
                      child: _buildHeroImage(context),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  List<Widget> _buildContent(
      BuildContext context, PortfolioController controller, bool isMobile) {
    if (isMobile) {
      return [
        ..._buildTextContent(context, controller, isMobile),
        const SizedBox(height: 32),
        _buildHeroImage(context),
      ];
    }
    return [];
  }

  List<Widget> _buildTextContent(
      BuildContext context, PortfolioController controller, bool isMobile) {
    return [
      // Greeting
      AnimationConfiguration.staggeredList(
        position: 0,
        duration: const Duration(milliseconds: 800),
        child: SlideAnimation(
          verticalOffset: 50.0,
          child: FadeInAnimation(
            child: AutoSizeText(
              'hero.greeting'.translate,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
              maxLines: 1,
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
            ),
          ),
        ),
      ),

      const SizedBox(height: 8),

      // Name with Animation
      AnimationConfiguration.staggeredList(
        position: 1,
        duration: const Duration(milliseconds: 1000),
        child: SlideAnimation(
          verticalOffset: 50.0,
          child: FadeInAnimation(
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                TyperAnimatedText(
                  'hero.name'.translate,
                  textStyle: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                  textAlign: TextAlign.center,
                  speed: const Duration(milliseconds: 100),
                ),
              ],
              totalRepeatCount: 1,
              displayFullTextOnTap: true,
            ),
          ),
        ),
      ),

      const SizedBox(height: 12),

      // Title
      AnimationConfiguration.staggeredList(
        position: 2,
        duration: const Duration(milliseconds: 1200),
        child: SlideAnimation(
          verticalOffset: 50.0,
          child: FadeInAnimation(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: AppColors.secondaryGradient,
                borderRadius: BorderRadius.circular(25),
              ),
              child: AutoSizeText(
                'hero.title'.translate,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),

      const SizedBox(height: 20),

      // Subtitle
      AnimationConfiguration.staggeredList(
        position: 3,
        duration: const Duration(milliseconds: 1400),
        child: SlideAnimation(
          verticalOffset: 50.0,
          child: FadeInAnimation(
            child: AutoSizeText(
              'hero.subtitle'.translate,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    height: 1.6,
                  ),
              maxLines: 3,
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
            ),
          ),
        ),
      ),

      const SizedBox(height: 24),

      // Location
      AnimationConfiguration.staggeredList(
        position: 4,
        duration: const Duration(milliseconds: 1600),
        child: SlideAnimation(
          verticalOffset: 50.0,
          child: FadeInAnimation(
            child: Row(
              mainAxisAlignment:
                  isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                AutoSizeText(
                  'hero.location'.translate,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      ),

      const SizedBox(height: 32),

      // Action Buttons
      AnimationConfiguration.staggeredList(
        position: 5,
        duration: const Duration(milliseconds: 1800),
        child: SlideAnimation(
          verticalOffset: 50.0,
          child: FadeInAnimation(
            child: Wrap(
              alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
              spacing: 16,
              runSpacing: 16,
              children: [
                ElevatedButton(
                  onPressed: () =>
                      controller.scrollToSection(4), // Contact section
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: AutoSizeText(
                    'hero.cta_button'.translate,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                  ),
                ),
                OutlinedButton(
                  onPressed: () => _downloadCV(),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary, width: 2),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.download_outlined, size: 20),
                      const SizedBox(width: 8),
                      AutoSizeText(
                        'hero.download_cv'.translate,
                        style: const TextStyle(
                          fontSize: 16,
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
    ];
  }

  Widget _buildHeroImage(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: 6,
      duration: const Duration(milliseconds: 2000),
      child: ScaleAnimation(
        child: FadeInAnimation(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 400,
              maxHeight: 400,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background Circle
                Container(
                  width: 350,
                  height: 350,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.heroGradient,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                ),

                // Profile Image
                Container(
                  width: 320,
                  height: 320,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 8),
                    image: const DecorationImage(
                      image: AssetImage(AssetsManager.personalImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _downloadCV() {
    final controller = Get.find<PortfolioController>();
    controller.downloadCV();
  }
}

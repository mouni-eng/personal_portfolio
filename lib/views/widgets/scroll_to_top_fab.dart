import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/portfolio_controller.dart';
import '../../core/theme/app_colors.dart';

class ScrollToTopFab extends StatelessWidget {
  const ScrollToTopFab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();

    return Obx(() => AnimatedScale(
          scale: controller.showScrollToTop.value ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: AnimatedOpacity(
            opacity: controller.showScrollToTop.value ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: FloatingActionButton(
              onPressed: controller.scrollToTop,
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 8,
              child: const Icon(
                Icons.keyboard_arrow_up,
                size: 28,
              ),
            ),
          ),
        ));
  }
}

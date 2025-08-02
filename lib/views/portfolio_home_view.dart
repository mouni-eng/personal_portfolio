import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../controllers/portfolio_controller.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/custom_drawer.dart';
import 'widgets/scroll_to_top_fab.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/experience_section.dart';
import 'sections/projects_section.dart';
import 'sections/contact_section.dart';
import 'sections/footer_section.dart';

class PortfolioHomeView extends StatelessWidget {
  const PortfolioHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Scaffold(
      appBar: isMobile ? const CustomAppBar() : null,
      drawer: isMobile ? const CustomDrawer() : null,
      body: Column(
        children: [
          // Desktop Navigation
          if (!isMobile) const CustomAppBar(),

          // Main Content
          Expanded(
            child: ScrollablePositionedList.builder(
              itemScrollController: controller.itemScrollController,
              itemPositionsListener: controller.itemPositionsListener,
              itemCount: _getSections().length,
              itemBuilder: (context, index) => _getSections()[index],
            ),
          ),
        ],
      ),
      floatingActionButton: const ScrollToTopFab(),
    );
  }

  List<Widget> _getSections() {
    return [
      const HeroSection(),
      const AboutSection(),
      const ExperienceSection(),
      const ProjectsSection(),
      const ContactSection(),
      const FooterSection(),
    ];
  }
}

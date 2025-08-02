import 'package:get/get.dart';
import '../controllers/portfolio_controller.dart';
import '../controllers/locale_controller.dart';

class PortfolioBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PortfolioController>(() => PortfolioController());
    Get.lazyPut<LocaleController>(() => LocaleController());
  }
}

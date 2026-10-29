import 'package:get/get.dart';
import '../../../common/constants/app_data.dart';
import '../../../core/utils/launcher_util.dart';
import '../../layout/controller/main_layout_controller.dart';
import '../model/stat_item_model.dart';

class HomeController extends GetxController {
  final List<StatItemModel> statList = const [
    StatItemModel(value: '3+', label: 'Year of\nExperience'),
    StatItemModel(value: '20+', label: 'Total\nProjects'),
    StatItemModel(value: '8+', label: 'Live\nProjects'),
    StatItemModel(value: '3.96', label: 'CGPA out\nof 4.00'),
  ];

  void sendEmail() => LauncherUtil.sendEmail(AppData.email);
  void callPhone() => LauncherUtil.callPhone(AppData.phone);

  void scrollToContact() {
    if (Get.isRegistered<MainLayoutController>()) {
      final layoutController = Get.find<MainLayoutController>();
      layoutController.scrollTo(layoutController.contactKey);
    }
  }

  void scrollToProjects() {
    if (Get.isRegistered<MainLayoutController>()) {
      final layoutController = Get.find<MainLayoutController>();
      layoutController.scrollTo(layoutController.projectsKey);
    }
  }
}

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../common/constants/app_data.dart';
import '../model/skill_category_model.dart';

class SkillsController extends GetxController {
  List<SkillCategoryModel> get categories => AppData.skillCategories;

  dynamic getCategoryIcon(int index) {
    switch (index) {
      case 0:
        return FontAwesomeIcons.mobileScreenButton;
      case 1:
        return FontAwesomeIcons.server;
      case 2:
      default:
        return FontAwesomeIcons.laptopCode;
    }
  }
}

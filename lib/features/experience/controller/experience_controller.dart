import 'package:get/get.dart';
import '../../../common/constants/app_data.dart';
import '../model/experience_model.dart';

class ExperienceController extends GetxController {
  List<ExperienceModel> get experienceList => AppData.experience;
}

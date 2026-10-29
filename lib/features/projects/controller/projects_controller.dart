import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/constants/app_data.dart';
import '../../../core/utils/launcher_util.dart';
import '../model/project_model.dart';
import '../widget/project_details_dialog.dart';

class ProjectsController extends GetxController {
  List<ProjectModel> get projects => AppData.projects;

  void openUrl(String url) => LauncherUtil.openUrl(url);

  void showProjectDetails(BuildContext context, ProjectModel project) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ProjectDetailsDialog(project: project),
    );
  }
}

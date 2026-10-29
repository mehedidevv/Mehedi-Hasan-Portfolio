import 'package:flutter/material.dart';
import '../home/view/home_view.dart';
import '../layout/controller/main_layout_controller.dart';

class AboutView extends StatelessWidget {
  final MainLayoutController controller;
  const AboutView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return HomeView(controller: controller);
  }
}

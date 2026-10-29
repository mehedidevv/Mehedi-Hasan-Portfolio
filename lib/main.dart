import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'common/theme/app_theme.dart';
import 'features/layout/view/main_layout_view.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mehedi Hasan | Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const MainLayoutView(),
    );
  }
}

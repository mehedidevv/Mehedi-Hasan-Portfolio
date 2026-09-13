import 'package:flutter/material.dart';
import 'common/theme/app_theme.dart';
import 'features/layout/main_layout.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mehedi Hasan | Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const MainLayout(),
    );
  }
}

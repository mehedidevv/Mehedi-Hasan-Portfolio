import 'package:flutter/material.dart';
import '../../common/constants/app_data.dart';
import '../../common/widgets/section_container.dart';
import '../../common/widgets/section_title.dart';
import '../layout/controller/main_layout_controller.dart';
import 'widget/education_card.dart';

class EducationView extends StatelessWidget {
  final MainLayoutController controller;
  const EducationView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      sectionKey: controller.educationKey,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(
            tag: 'Education',
            title: 'Academic Background',
          ),
          SizedBox(height: 28),
          EducationCard(edu: AppData.education),
        ],
      ),
    );
  }
}

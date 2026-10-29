import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/widgets/responsive.dart';
import '../../../common/widgets/section_container.dart';
import '../../../common/widgets/section_title.dart';
import '../../layout/controller/main_layout_controller.dart';
import '../controller/faq_controller.dart';
import '../widget/faq_card.dart';
import '../widget/whatsapp_cta_button.dart';

class FaqView extends StatelessWidget {
  final MainLayoutController controller;
  const FaqView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final faqController = Get.put(FaqController());
    final isMobile = Responsive.isMobile(context);

    final leftColCount = (faqController.faqList.length / 2).ceil();

    return SectionContainer(
      sectionKey: controller.faqKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionTitle(
            tag: 'Answers & Details',
            title: 'Frequently Asked Questions',
            subtitle:
                'Everything you need to know about my Flutter & mobile engineering, Clean Architecture, and collaboration process.',
            alignment: CrossAxisAlignment.center,
          ),
          const SizedBox(height: 36),

          // FAQ Responsive Grid / Column
          if (isMobile)
            Obx(
              () => Column(
                children: [
                  for (int i = 0; i < faqController.faqList.length; i++) ...[
                    if (i > 0) const SizedBox(height: 16),
                    FaqCard(
                      faq: faqController.faqList[i],
                      isExpanded: faqController.isExpanded(i),
                      onTap: () => faqController.toggleExpand(i),
                    ),
                  ],
                ],
              ),
            )
          else
            Obx(
              () => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Column
                  Expanded(
                    child: Column(
                      children: [
                        for (int i = 0; i < leftColCount; i++) ...[
                          if (i > 0) const SizedBox(height: 18),
                          FaqCard(
                            faq: faqController.faqList[i],
                            isExpanded: faqController.isExpanded(i),
                            onTap: () => faqController.toggleExpand(i),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Right Column
                  Expanded(
                    child: Column(
                      children: [
                        for (int i = leftColCount; i < faqController.faqList.length; i++) ...[
                          if (i > leftColCount) const SizedBox(height: 18),
                          FaqCard(
                            faq: faqController.faqList[i],
                            isExpanded: faqController.isExpanded(i),
                            onTap: () => faqController.toggleExpand(i),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 32),

          // WhatsApp CTA Button Pinned to the Right
          Align(
            alignment: isMobile ? Alignment.center : Alignment.centerRight,
            child: WhatsAppCtaButton(
              onTap: faqController.openWhatsApp,
            ),
          ),
        ],
      ),
    );
  }
}

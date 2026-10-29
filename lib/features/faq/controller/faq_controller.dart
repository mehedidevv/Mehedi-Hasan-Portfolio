import 'package:get/get.dart';
import '../../../core/utils/launcher_util.dart';
import '../model/faq_model.dart';

class FaqController extends GetxController {
  final RxSet<int> expandedIndices = <int>{0}.obs; // First FAQ expanded by default

  final List<FaqModel> faqList = const [
    FaqModel(
      question: 'What core technologies and services do you specialize in?',
      answer:
          'I specialize in cross-platform mobile development using Flutter & Dart, native Android with Kotlin & Java, Clean Architecture, and GetX/BLoC patterns. I also work with Java Spring Boot backends, Firebase, Socket.io, and REST APIs.',
    ),
    FaqModel(
      question: 'How do you approach Clean Architecture and code maintainability?',
      answer:
          'I structure applications using feature-first MVC/Clean Architecture principles. Business logic, data sources, models, and UI components are strictly separated following SOLID principles, ensuring high scalability and effortless maintenance.',
    ),
    FaqModel(
      question: 'Can you manage end-to-end delivery from wireframe to Store publication?',
      answer:
          'Yes! I handle the full product lifecycle: translating Figma designs into responsive UIs, integrating APIs & databases, optimizing performance, and publishing production builds to Google Play Store & Apple App Store.',
    ),
    FaqModel(
      question: 'How do you collaborate with international teams across different timezones?',
      answer:
          'I am experienced working with distributed global teams using Git/GitHub version control, Agile sprint workflows, Postman API specs, and asynchronous communication tools like Slack, Jira, and WhatsApp.',
    ),
    FaqModel(
      question: 'What are your engagement models (full-time, contract, or MVP)?',
      answer:
          'I am open to full-time engineering opportunities, long-term contract roles, or building MVPs from scratch for startups and businesses.',
    ),
    FaqModel(
      question: 'How quickly can we start, and how can I discuss my project requirements?',
      answer:
          'We can start right away! Feel free to send an email or click the WhatsApp button below to discuss your project requirements in real time.',
    ),
  ];

  void toggleExpand(int index) {
    if (expandedIndices.contains(index)) {
      expandedIndices.remove(index);
    } else {
      expandedIndices.add(index);
    }
  }

  bool isExpanded(int index) => expandedIndices.contains(index);

  void openWhatsApp() {
    LauncherUtil.openUrl('https://wa.me/8801742711184');
  }
}

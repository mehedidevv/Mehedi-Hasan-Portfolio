import '../../core/models/project_model.dart';
import '../../core/models/experience_model.dart';

/// All personal / CV data lives here so views stay dumb & reusable.
/// Update this file to change the whole site's content.
class AppData {
  AppData._();

  static const String name = 'Mehedi Hasan';
  static const String role = 'Software Developer (Flutter + Native Android)';
  static const String tagline =
      'I build fast, clean and scalable mobile applications with Flutter, '
      'and craft delightful, responsive user experiences.';

  static const String summary =
      'Secure a responsible career opportunity to fully utilize my training '
      'and skills, to solve real-life problems in my field of work with '
      'sharp precision while making a significant contribution to the '
      "company's success.";

  static const String email = 'mehedihasancse1181@gmail.com';
  static const String phone = '+8801742711184';
  static const String location = 'Mohakhali, Dhaka';
  static const String github = 'https://github.com/';
  static const String linkedin = 'https://linkedin.com/';

  static const List<String> skills = [
    'Flutter Framework & Dart',
    'Git & GitHub (Version Control)',
    'Clean Architecture',
    'GetX Architecture Pattern',
    'MVVM & MVC Pattern',
    'SOLID Principles & OOP',
    'Postman',
    'Figma',
    'Xcode',
    'Firebase',
    'REST API Integration',
    'Socket.io (Realtime)',
    'Hive & SQLite (Local DB)',
    'Kotlin (Native Android)',
    'Java (Native Android)',
  ];

  static const List<ExperienceModel> experience = [
    ExperienceModel(
      company: 'Betopia Group',
      role: 'Software Engineer (Flutter)',
      duration: 'Jan 2025 - Present',
      points: [
        'Developed high-performance Flutter applications for clients, contributing to efficient UI design, network calling, and optimizing UI animations.',
        'Implemented Clean Architecture principles, structuring apps using SOLID principles to ensure scalability and maintainability.',
        'Integrated RESTful APIs for efficient network communication.',
        'Employed GetX for state management, ensuring a clear separation of business logic and UI components.',
        'Collaborated closely with cross-functional teams, including designers, backend developers, and project managers, to deliver high-quality features on time.',
      ],
    ),
  ];

  static const EducationModel education = EducationModel(
    institute: 'Gono Bishwabidyalay',
    degree: 'B.Sc. in Computer Science & Engineering',
    duration: 'Completed September 2024',
    points: [
      'CGPA: 3.96 out of 4.00',
      'Received Academic Excellency Award from VC for securing an exceptional result.',
    ],
  );

  static const List<ProjectModel> projects = [
    ProjectModel(
      title: 'Prime Pilates',
      description:
          'A user-friendly fitness app that simplifies booking for group and '
          'personal training sessions. Built with GetX state management and '
          'Clean Architecture (OOP & SOLID). Uses Firebase for push '
          'notifications and Socket.io for real-time messaging.',
      tags: ['Flutter', 'GetX', 'Firebase', 'Socket.io', 'Clean Architecture'],
      links: [
        ProjectLink(label: 'Play Store', url: '', type: ProjectLinkType.playStore),
        ProjectLink(label: 'App Store', url: '', type: ProjectLinkType.appStore),
      ],
    ),
    ProjectModel(
      title: 'employEEZone',
      description:
          'An AI-powered employee support app providing HR guidance, '
          'scenario-based assistance, smart tools and AI-driven insights. '
          'Built from Figma designs with full API integration, Stripe '
          'payment gateway and an AI chatbot.',
      tags: ['Flutter', 'GetX', 'Stripe', 'AI Chatbot', 'REST API'],
      links: [
        ProjectLink(label: 'Play Store', url: '', type: ProjectLinkType.playStore),
      ],
    ),
    ProjectModel(
      title: 'Chat Application',
      description:
          'A real-time chat application built with Kotlin & Firebase for '
          'authentication and database-backed messaging.',
      tags: ['Kotlin', 'Firebase', 'Realtime DB'],
      links: [
        ProjectLink(label: 'GitHub', url: '', type: ProjectLinkType.github),
      ],
    ),
    ProjectModel(
      title: 'Node Application',
      description:
          'A notepad application implementing full CRUD operations using '
          'SQLite for local note management.',
      tags: ['Flutter', 'SQLite', 'CRUD'],
      links: [
        ProjectLink(label: 'GitHub', url: '', type: ProjectLinkType.github),
      ],
    ),
  ];
}

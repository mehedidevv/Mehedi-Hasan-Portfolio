import '../../core/models/project_model.dart';
import '../../core/models/experience_model.dart';
import '../../core/models/skill_category_model.dart';
import 'appImage.dart';

/// All personal / CV data lives here so views stay dumb & reusable.
/// Update this file to change the whole site's content.
class AppData {
  AppData._();

  static const String name = 'Mehedi Hasan';
  static const String role = 'Software Developer';
  static const String tagline =
      'I design, develop, and maintain scalable software solutions, '
      'combining software engineering, system administration, and modern technologies '
      'to build reliable, efficient, and innovative digital experiences.';

  static const String summary =
      'Secure a responsible career opportunity to fully utilize my training '
      'and skills, to solve real-life problems in my field of work with '
      'sharp precision while making a significant contribution to the '
      "company's success.";

  static const String email = 'mehedihasancse1181@gmail.com';
  static const String phone = '+8801742711184';
  static const String location = 'Mohakhali, Dhaka';
  static const String github = 'https://github.com/mehedidevv';
  static const String linkedin = 'https://www.linkedin.com/in/mehedi-hasan-5a0b2a224/';
  static const String resumeUrl = 'https://drive.google.com/file/d/1XJ0JP0rO0l42vxM3Yt2DROPwwcSYVdIm/view?usp=drive_link';

  static const List<SkillCategoryModel> skillCategories = [
    SkillCategoryModel(
      title: 'Mobile Development',
      skills: [
        'Flutter Framework & Dart',
        'Kotlin (Native Android)',
        'Java (Native Android)',
        'Xcode & iOS',
        'Clean Architecture',
        'GetX Architecture Pattern',
        'BLock',
        'MVVM & MVC Patterns',
      ],
    ),
    SkillCategoryModel(
      title: 'Backend & Databases (Learning & Building)',
      skills: [
        'Java Spring Boot',
        'SQL Database (MySQL & PostgreSQL)',
        'REST API Integration',
        'Socket.io (Realtime)',
        'Firebase Services',
        'Hive & SQLite (Local DB)',
        'Postman',
      ],
    ),
    SkillCategoryModel(
      title: 'Systems & Computer Science',
      skills: [
        'C++',
        'Competitive Programming',
        'Linux Administration',
        'RHCSA (CSL Academy)',
        'SOLID Principles & OOP',
        'Git & GitHub (Version Control)',
        'Figma UI Design',
      ],
    ),
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
      'Served as Mobile App Development Mentor at Gono Bishwabidyalay Computer Club.',
    ],
  );

  static final List<ProjectModel> projects = [


    ProjectModel(
      title: 'LIKIDY',
      image: AppImages.Likidy,
      description:
          'Likidy is Algeria’s negotiation-first marketplace, designed to make buying, '
          'selling, and offering services easier and more efficient. '
          'Users can negotiate prices through structured offers, '
          'track negotiation history, chat in real time, and receive instant notifications. '
          'With location-based listings, user reviews, social features, '
          'and a dedicated free-items category, Likidy creates a trusted, convenient, '
          'and community-driven marketplace.',
      tags: ['Flutter', 'GetX', 'Firebase', 'Socket.io', 'Clean Architecture'],
      links: const [
        ProjectLink(
            label: 'Play Store', url: 'https://play.google.com/store/apps/details?id=com.likidibuysell.app&hl=en', type: ProjectLinkType.playStore),
        ProjectLink(
            label: 'App Store', url: 'https://apps.apple.com/us/app/likidy-app/id6790383881', type: ProjectLinkType.appStore),
      ],
    ),

    ProjectModel(
      title: 'Prime Pilates',
      image: AppImages.primePalates,
      description:
      'Prime Pilates is a modern, user-friendly mobile application designed to simplify the Pilates and wellness experience.'
          'The app allows users to explore available classes, view detailed session information,'
          ' check instructor profiles, and book classes effortlessly.'
          ' Featuring an elegant interface, personalized schedules, and a seamless booking experience, '
          'Prime Pilates helps users stay organized, motivated, and consistent throughout their fitness journey.',
      tags: ['Flutter', 'GetX', 'Firebase', 'Socket.io', 'Clean Architecture','Solid Principles', 'OOP'],
      links: const [
        ProjectLink(
            label: 'Play Store', url: 'https://play.google.com/store/apps/details?id=com.prime.pilates.app&hl=en', type: ProjectLinkType.playStore),
        ProjectLink(
            label: 'App Store', url: 'https://apps.apple.com/lv/app/prime-pilates/id6741531586', type: ProjectLinkType.appStore),
      ],
    ),


    ProjectModel(
      title: 'Towqi – Vet & Animal Care',
      image: AppImages.towqiVet,
      description:
      'A digital veterinary and animal care platform in Saudi Arabia that helps animal owners and breeders find and access veterinary services nearby. Search for the nearest veterinarian, clinic, animal hospital, or request home veterinary visits.',
      tags: ['Flutter', 'GetX', 'Firebase', 'Socket.io', 'Clean Architecture','Solid Principles', 'Google Maps'],
      links: const [
        ProjectLink(
            label: 'Play Store', url: 'https://play.google.com/store/apps/details?id=com.app.tuqi', type: ProjectLinkType.playStore),
        ProjectLink(
            label: 'App Store', url: 'https://apps.apple.com/us/app/towqi-vet-animal-care/id6751596650', type: ProjectLinkType.appStore),
      ],
    ),

    ProjectModel(
      title: 'Sougk',
      image: AppImages.souag,
      description:
      'A buying and selling app designed to provide users with a fast and easy experience for listing products and services. Connects sellers '
          'and buyers across Sudan with direct communication to buy and sell products such as electronics, cars, and real estate.',

      tags: ['Flutter', 'GetX', 'Firebase', 'Socket.io', 'Clean Architecture','Solid Principles',],
      links: const [
        ProjectLink(
            label: 'Play Store', url: 'https://play.google.com/store/apps/details?id=com.sougk.sd', type: ProjectLinkType.playStore),

      ],
    ),


    ProjectModel(
      title: 'Run BD',
      image: AppImages.runBD,
      description:
      'RunBD is an all-in-one vehicle marketplace and service platform designed to simplify buying and selling cars and motorcycles. The app also offers vehicle rentals, file processing, document services, workshops, accessories, vehicle exchanges, and other automotive solutions through a seamless, user-friendly experience.',

      tags: ['Flutter', 'GetX', 'Firebase', 'Socket.io', 'Clean Architecture','Solid Principles',],
      links: const [
        ProjectLink(
            label: 'Play Store', url: 'https://play.google.com/store/apps/details?id=org.globalrunbd.app&referrer=utm_source%3Dapkpure.com', type: ProjectLinkType.playStore),

      ],
    ),


     ProjectModel(
      title: 'Chat Application',
      image: AppImages.chatApp,
      description:
          'A real-time chat application built with Kotlin & Firebase for '
          'authentication and database-backed messaging.',
      tags: ['Kotlin', 'Firebase', 'Realtime DB'],
      links: const [
        ProjectLink(label: 'GitHub', url: 'https://github.com/mehedidevv/Chat-Application', type: ProjectLinkType.github),
      ],
    ),

  ];
}

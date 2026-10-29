# Folder Structure Explanation

```
lib/
├── main.dart                          # Application entry point using GetMaterialApp
├── common/                            # Shared resources, themes, and global widgets
│   ├── constants/
│   │   ├── app_data.dart              # Portfolio personal CV data & content
│   │   └── app_images.dart            # Asset path definitions
│   ├── theme/
│   │   ├── app_colors.dart            # Central color palette & gradients
│   │   └── app_theme.dart             # ThemeData with GoogleFonts configuration
│   └── widgets/
│       ├── app_footer.dart            # Bottom footer section with social buttons
│       ├── app_nav_bar.dart           # Top glassmorphic navigation bar & drawer
│       ├── responsive.dart            # Responsive breakpoint utilities
│       ├── section_container.dart     # Responsive section wrapper with max-width
│       └── section_title.dart         # Gradient section title & badge component
├── core/
│   └── utils/
│       └── launcher_util.dart         # External URL, phone & email launcher
└── features/                          # Feature-first modularized code
    ├── layout/                        # Global page orchestrator & scroll tracking
    │   ├── controller/
    │   │   └── main_layout_controller.dart
    │   └── view/
    │       └── main_layout_view.dart
    ├── home/                          # Hero header section
    │   ├── controller/
    │   │   └── home_controller.dart
    │   ├── view/
    │   │   └── home_view.dart
    │   └── widget/
    │       ├── badge_widget.dart
    │       ├── contact_chip.dart
    │       ├── hero_avatar.dart
    │       └── hero_button.dart
    ├── about/                         # About me section
    │   ├── controller/
    │   │   └── about_controller.dart
    │   ├── view/
    │   │   └── about_view.dart
    │   └── widget/
    │       └── info_stat_widget.dart
    ├── skills/                        # Technical skills section
    │   ├── model/
    │   │   └── skill_category_model.dart
    │   ├── controller/
    │   │   └── skills_controller.dart
    │   ├── view/
    │   │   └── skills_view.dart
    │   └── widget/
    │       ├── skill_category_card.dart
    │       └── skill_chip.dart
    ├── experience/                    # Work experience timeline
    │   ├── model/
    │   │   └── experience_model.dart
    │   ├── controller/
    │   │   └── experience_controller.dart
    │   ├── view/
    │   │   └── experience_view.dart
    │   └── widget/
    │       └── experience_card.dart
    ├── education/                     # Academic background
    │   ├── model/
    │   │   └── education_model.dart
    │   ├── controller/
    │   │   └── education_controller.dart
    │   ├── view/
    │   │   └── education_view.dart
    │   └── widget/
    │       └── education_card.dart
    ├── projects/                      # Featured showcase projects
    │   ├── model/
    │   │   └── project_model.dart
    │   ├── controller/
    │   │   └── projects_controller.dart
    │   ├── view/
    │   │   └── projects_view.dart
    │   └── widget/
    │       ├── project_card.dart
    │       └── project_details_dialog.dart
    └── contact/                       # Contact details & direct actions
        ├── controller/
        │   └── contact_controller.dart
        ├── view/
        │   └── contact_view.dart
        └── widget/
            ├── action_button.dart
            ├── availability_badge.dart
            └── contact_card.dart
```

# Feature Module Descriptions

## 1. Layout (`/features/layout`)
- **Responsibility:** Top-level layout orchestration, scroll tracking, top cyber scroll progress indicator, desktop side HUD navigation rail, and circular scroll-to-top button.
- **Key Files:** `main_layout_controller.dart`, `main_layout_view.dart`.

## 2. Home (`/features/home`)
- **Responsibility:** Primary landing section combining Hero header (Name, Role, Tagline, CTAs, Contact Chips, Avatar) and the integrated About & Professional Summary card (Summary text & animated Stat highlights: Experience, Total Projects, Live Projects, CGPA).
- **Key Files:** `stat_item_model.dart`, `home_controller.dart`, `home_view.dart`, `about_summary_card.dart`, `info_stat_card.dart`, `hero_avatar.dart`, `contact_chip.dart`, `hero_button.dart`.

## 3. Skills (`/features/skills`)
- **Responsibility:** Categorized technical skill sets (Mobile Development, Backend & Databases, Systems & CS) with animated gradient borders and skill chips.
- **Key Files:** `skills_controller.dart`, `skills_view.dart`, `skill_category_card.dart`, `skill_chip.dart`.

## 4. Experience (`/features/experience`)
- **Responsibility:** Career experience timeline displaying employment role, duration badge, company name, and key achievements.
- **Key Files:** `experience_controller.dart`, `experience_view.dart`, `experience_card.dart`.

## 5. Education (`/features/education`)
- **Responsibility:** Academic history card detailing degree, institute, duration, CGPA, and VC academic awards.
- **Key Files:** `education_controller.dart`, `education_view.dart`, `education_card.dart`.

## 6. Projects (`/features/projects`)
- **Responsibility:** Grid of featured mobile and software projects with image mockups, technology tags, store links, and interactive project details dialog.
- **Key Files:** `projects_controller.dart`, `projects_view.dart`, `project_card.dart`, `project_details_dialog.dart`.

## 7. FAQ (`/features/faq`)
- **Responsibility:** Expandable/collapsible liquid glass FAQ cards addressing key engineering, architecture, and collaboration questions, plus a direct WhatsApp CTA button.
- **Key Files:** `faq_model.dart`, `faq_controller.dart`, `faq_view.dart`, `faq_card.dart`, `whatsapp_cta_button.dart`.

## 8. Contact (`/features/contact`)
- **Responsibility:** Availability badge indicator, contact info cards (Email, Phone, Location), and an interactive liquid glass Contact Form (Name, Email, Subject, Details) with GetX validation and Web3Forms email submission.
- **Key Files:** `contact_controller.dart`, `contact_view.dart`, `contact_form_widget.dart`, `custom_text_field.dart`, `action_button.dart`, `availability_badge.dart`, `contact_card.dart`.

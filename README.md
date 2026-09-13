# Mehedi Hasan — Portfolio (Flutter)

Professional, modern, responsive portfolio website built with Flutter,
following an MVC-style folder structure.

## Folder Structure (MVC)

```
lib/
  main.dart                # App entry point

  common/                  # Shared/reusable pieces used everywhere
    theme/                 # Colors + ThemeData (app_colors.dart, app_theme.dart)
    constants/             # app_data.dart -> ALL your CV content lives here
    widgets/                # Reusable UI: navbar, footer, section wrappers, etc.

  core/                    # App "brains"
    models/                # Model layer (ProjectModel, ExperienceModel, EducationModel)
    controllers/            # Controller layer (NavController -> scroll & nav state)
    utils/                 # Helpers (LauncherUtil for email/phone/links)

  features/                # View layer, one folder per page section
    layout/                 # MainLayout -> composes every section + navbar/footer
    home/                   # Hero section
    about/
    skills/
    experience/
    education/
    projects/
    contact/
```

- **Model** → `core/models`
- **View** → `features/*` (each section's `..._view.dart`) + `common/widgets`
- **Controller** → `core/controllers/nav_controller.dart` (drives scrolling / active nav state)

## How to run

1. Install Flutter SDK (stable channel) if you don't have it: https://docs.flutter.dev/get-started/install
2. Unzip this project, then open a terminal inside the folder.
3. Get packages:
   ```
   flutter pub get
   ```
4. If the `android`, `ios`, `macos`, `windows`, `linux` platform folders are missing
   (only `web` is included in this zip to keep it lightweight), generate them with:
   ```
   flutter create .
   ```
   This is safe — it will NOT overwrite your `lib/` code, it only adds the missing
   native platform scaffolding.
5. Run on web:
   ```
   flutter run -d chrome
   ```
   Run on a connected Android device/emulator:
   ```
   flutter run -d <device_id>
   ```
6. Build for production:
   ```
   flutter build web        # deployable static site -> build/web
   flutter build apk        # Android
   ```

## Editing your content

Everything text-based (name, role, email, phone, skills, experience,
education, projects) is centralized in:

```
lib/common/constants/app_data.dart
```

Update that one file and the whole site updates automatically — no need to
touch the view files. To change colors/branding, edit
`lib/common/theme/app_colors.dart`.

## Responsiveness

The layout uses breakpoints defined in `lib/common/widgets/responsive.dart`
(mobile < 650px, tablet < 1024px, desktop ≥ 1024px) so the same codebase
adapts across web and mobile automatically — hero layout stacks vertically,
navbar becomes a drawer, and the projects grid switches from 2 columns to 1.

## Packages used

- `url_launcher` — opens email/phone/GitHub/LinkedIn links
- `font_awesome_flutter` — brand icons (GitHub, LinkedIn, Play Store, App Store)

# Project Architecture Guide

## Overview
This application follows a **Feature-First Model-View-Controller (MVC)** architectural pattern combined with **GetX** for reactive state management and dependency injection.

## Core Architectural Layers

1. **Model Layer (`/model`)**
   - Pure Dart data classes representing domain objects (e.g., `ProjectModel`, `ExperienceModel`, `EducationModel`, `SkillCategoryModel`).
   - Located inside their respective feature directories to uphold feature isolation.

2. **View Layer (`/view` & `/widget`)**
   - Renders UI elements using declarative Flutter widgets.
   - Built primarily with `StatelessWidget` and `GetView<Controller>`.
   - Free of business logic or navigation handling; delegates user actions directly to GetX Controllers.

3. **Controller Layer (`/controller`)**
   - Extends GetX `GetxController`.
   - Manages feature-specific reactive state using Rx primitives (`RxInt`, `RxBool`, `RxDouble`, `obs`).
   - Encapsulates side effects, URL launching, modal triggers, and section navigation logic.

4. **Shared / Core Layer (`/common` & `/core`)**
   - Houses global theme configuration (`AppTheme`, `AppColors`), app-wide constants (`AppData`, `AppImages`), utility classes (`LauncherUtil`), and reusable common widgets (`SectionContainer`, `SectionTitle`, `Responsive`).

## Design Principles
- **SOLID Principles:** Single responsibility per widget and controller class.
- **Feature Isolation:** Features are modularized into independent folders containing their own models, views, controllers, and widgets.
- **Zero UI Regression:** Architectural refactoring maintains 100% fidelity to original visual aesthetics, colors, typography, animations, and responsive behavior.

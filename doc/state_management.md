# State Management & Dependency Injection

## Framework Choice: GetX
The application leverages **GetX** (`get: ^4.6.6`) for lightweight, reactive state management and dependency injection.

## State Management Patterns Used

1. **Reactive State (`Rx` and `Obx`)**
   - Variables that change dynamically (e.g., active section index, scroll progress, scroll-to-top button visibility) are defined as `Rx` types (`RxInt`, `RxBool`, `RxDouble`).
   - UI widgets observe these reactive values using `Obx(() => ...)` so that only the minimal required widget rebuilds when state changes.

2. **GetxController Lifecycle**
   - Controllers extend `GetxController` and hook into standard lifecycle methods:
     - `onInit()`: Initializes listeners (e.g. scroll listener in `MainLayoutController`).
     - `onClose()`: Disposes resources and listeners.

3. **Dependency Injection (`Get.put` / `GetView`)**
   - Controllers are injected using `Get.put(Controller())`.
   - Views consume injected controllers seamlessly through `GetView<Controller>` or direct controller instance references.

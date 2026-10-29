# API & Data Flow Architecture

## Data Flow Pipeline

```
[AppData / Local Storage] -> [Domain Models] -> [GetX Controllers] -> [UI Views (Obx)] -> [User Interactions]
                                                      |
                                                      v
                                        [Web3Forms API Integration]
```

## Data Layer Architecture

1. **Data Source (`AppData`)**
   - All static CV content, project listings, work experience, skill categories, personal contact details, and Web3Forms Access Key (`web3FormsAccessKey`) are centralized in `lib/common/constants/app_data.dart`.
   - Views do not define hardcoded static Strings directly; they read from `AppData` to maintain clean separation of concerns.

2. **Web3Forms API Integration (`ContactController`)**
   - Direct HTTP POST integration with `https://api.web3forms.com/submit`.
   - Payload includes:
     - `access_key`: `AppData.web3FormsAccessKey`
     - `name`: `nameController.text`
     - `email`: `emailController.text`
     - `subject`: `subjectController.text`
     - `message`: `messageController.text`
     - `from_name`: `${name} (Portfolio Contact Form)`
   - Full exception handling for validation errors, network failures, and Web3Forms response status checking.

3. **External Link Utilities (`LauncherUtil`)**
   - Encapsulates interaction with external systems (opening web URLs, WhatsApp chats, triggering `mailto:` links, initiating phone calls via `url_launcher`).
   - Standardized exception handling prevents unhandled url scheme errors on web and desktop platforms.

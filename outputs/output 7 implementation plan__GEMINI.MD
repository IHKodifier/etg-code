## Project Setup and DevOps
- [ ] Step 1: Initialize Git Repository and Configure Branch Protection
  - **Task**: Initialize a new Git repository and set up the GitFlow branching model as a foundation for the project. Configure branch protection rules to enforce the `main` and `develop` branches as protected. This includes blocking direct commits and requiring pull requests for code integration.
  - **Files**:
    - `.git/config`: Set up repository configuration
    - `.github/workflows/branch-protection.yml`: CI/CD configuration to enforce branch protection rules.
    - `.github/pull_request_template.md`: Standardize pull requests.
  - **Step Dependencies**: None
  - **User Instructions**: Ensure Git is installed. Run `git init` in the project root. Push the initial commit to the remote repository. Configure branch protection settings directly on GitHub or the chosen Git hosting service.

- [ ] Step 2: Set Up Firebase Project and Environments
  - **Task**: Create a new Firebase project. Configure three distinct environments: `dev`, `staging`, and `production`. Initialize Firebase services for Authentication, Firestore, and Cloud Functions.
  - **Files**:
    - `firebase.json`: Configuration for Firebase services and deployments.
    - `.env.dev`, `.env.staging`, `.env.production`: Environment variables for each deployment stage.
  - **Step Dependencies**: Step 1
  - **User Instructions**: Create a new Firebase project via the Firebase Console. Use the Firebase CLI to initialize the project and set up the different environments.

## Backend Core Services
- [ ] Step 3: Implement Authentication and User Management Services
  - **Task**: Develop the FastAPI-based Authentication and User Management microservices within Firebase Functions. Implement the API endpoints for anonymous session initialization, user registration, login, token refresh, and logout. Implement the multi-device management logic, including device fingerprinting and the device limit check (max 3 devices).
  - **Files**:
    - `backend/app/services/device_service.py`: Contains the `DeviceFingerprint` class with `generate_fingerprint` and `calculate_similarity` methods.
    - `backend/app/routers/auth_router.py`: API endpoints for authentication.
    - `backend/app/routers/device_router.py`: API endpoints for device management.
    - `backend/app/models/user.py`: Pydantic models for user and device data.
    - `backend/app/dependencies/auth.py`: JWT token and Firebase Auth integration.
  - **Step Dependencies**: Step 2
  - **User Instructions**: Implement the provided Python code snippets for the `DeviceFingerprint` class and other core logic. Ensure the FastAPI application is correctly configured to run as a Firebase Function.

## Frontend Core Services
- [ ] Step 4: Develop Frontend Authentication and Device Management
  - **Task**: Build the Flutter application's authentication flows and device management screens based on the user flow diagrams and API specifications. Implement anonymous user tracking with device fingerprinting and a seamless upgrade path to a registered account. Use GoRouter for navigation and Riverpod for state management. Adhere to the `general-flutter-rule.mdc` for file structure, widget principles, and error handling.
  - **Files**:
    - `lib/features/auth/presentation/pages/auth_page.dart`: The main authentication page with login/registration options.
    - `lib/features/auth/presentation/pages/device_management_page.dart`: Screen for managing connected devices.
    - `lib/core/services/device_service.dart`: The Flutter device detection service.
    - `lib/features/auth/data/repositories/auth_repository.dart`: Repository for API calls.
    - `lib/features/auth/providers/auth_provider.dart`: Riverpod provider for managing authentication state.
    - `lib/router/app_router.dart`: GoRouter configuration with route guards.
  - **Step Dependencies**: Step 3
  - **User Instructions**: Implement the Dart code snippets for the `DeviceService` class. Follow the `Single Responsibility Widget` principle and use `AsyncNotifier`/`StreamNotifier` for business logic. Use `SelectableText.rich` to gracefully display any errors.

## Content Management System
- [ ] Step 5: Design and Implement the Question Data Model
  - **Task**: Define the data model for questions and content within Firestore. Implement the `Question` Pydantic model in the backend and define the Firestore collection structure with appropriate composite indexes for filtering and searching.
  - **Files**:
    - `backend/app/models/question.py`: The `Question` data model with fields for exam category, subject, topic, ARDE probability, and analytics.
    - `backend/app/services/firestore_service.py`: Service for interacting with Firestore.
    - `firebase/firestore.indexes.json`: File for defining Firestore composite indexes.
  - **Step Dependencies**: Step 2, Step 3
  - **User Instructions**: Create the `Question` model based on the provided example. Configure Firestore security rules and composite indexes to enable efficient querying for filters.

- [ ] Step 6: Implement Content Upload Service
  - **Task**: Develop the backend service to handle bulk question imports from a CSV file. The service must validate the CSV structure and content, then parse and save the questions to Firestore.
  - **Files**:
    - `backend/app/services/content_import_service.py`: The `ContentImportService` class with `validate_csv` and `import_questions` methods.
    - `backend/app/routers/content_router.py`: API endpoint for content upload.
  - **Step Dependencies**: Step 5
  - **User Instructions**: Implement the provided Python code for the content import service. Ensure proper error handling and logging for failed imports.

## Core Practice and Exam Features
- [ ] Step 7: Develop the Practice Session Flow
  - **Task**: Implement the frontend and backend logic for a practice session. The flow includes initializing a session, fetching questions, recording attempts, and sending metrics to the analytics service.
  - **Files**:
    - `lib/features/practice/presentation/pages/practice_page.dart`: The UI for the practice session.
    - `lib/features/practice/data/repositories/practice_repository.dart`: Repository for practice session API calls.
    - `lib/features/practice/providers/practice_session_provider.dart`: Riverpod provider for managing session state.
    - `backend/app/routers/practice_router.py`: Backend API endpoints for practice sessions.
  - **Step Dependencies**: Step 4, Step 5
  - **User Instructions**: Refer to the `Practice Session Flow` diagram for a clear understanding of the data flow and component interactions.

## Analytics and Monitoring
- [ ] Step 8: Set Up Analytics Infrastructure
  - **Task**: Configure BigQuery for analytics data. The system should stream user events, practice sessions, and exam results to BigQuery. Set up Firebase Crashlytics and Google Cloud Monitoring for app and infrastructure health.
  - **Files**:
    - `backend/app/services/analytics_service.py`: Service for sending data to BigQuery.
    - `firebase/cloud_monitoring.json`: Configuration for monitoring dashboards.
  - **Step Dependencies**: Step 2, Step 7
  - **User Instructions**: Configure BigQuery tables and streaming inserts. Integrate Firebase Crashlytics into the Flutter app and Google Cloud Monitoring into the Firebase Functions.

## AI Integration
- [ ] Step 9: Integrate AI Tutoring Service
  - **Task**: Implement the AI tutoring service using OpenAI as the primary provider and Google Gemini as a fallback. The service should provide explanations for questions and be integrated into the practice session flow.
  - **Files**:
    - `backend/app/services/ai_service.py`: Service for interacting with the AI APIs.
    - `backend/app/routers/ai_router.py`: API endpoint for getting explanations.
  - **Step Dependencies**: Step 7, Step 8
  - **User Instructions**: Use the provided `requirements.txt` for the necessary AI libraries. Implement logic for the fallback chain to ensure high availability.

## Monetization and Subscriptions
- [ ] Step 10: Implement Payments and Subscription Management
  - **Task**: Integrate Paddle.com for payment processing and subscription management. Implement the necessary backend endpoints to handle webhooks from Paddle and update user subscription status in Firestore.
  - **Files**:
    - `backend/app/routers/subscription_router.py`: API endpoint for handling Paddle webhooks.
    - `backend/app/services/subscription_service.py`: Service for updating subscription data in Firestore.
    - `lib/features/subscription/presentation/pages/pricing_page.dart`: The UI for subscription tiers.
  - **Step Dependencies**: Step 3
  - **User Instructions**: Configure webhook endpoints in Paddle and ensure they are pointed to the correct Firebase Function URL.
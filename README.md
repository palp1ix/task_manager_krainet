# Task Manager

A simple and efficient Task Manager application designed to help users manage their tasks seamlessly across mobile and web platforms. The app supports local and cloud-based task storage, user authentication, notifications, and a responsive design.

## Features
- Create, update, and delete tasks.
- Local storage with synchronization to the cloud.
- User authentication via Firebase Auth.
- Local notifications with synchronization to remote notifications.
- Responsive design for mobile and web platforms.
- Task persistence using SQFlite for local storage and Firebase Cloud Firestore for remote storage.

## Tech Stack
- **Platforms**: Mobile (Android/iOS) and Web
- **Language**: Dart / Flutter
- **State Management**: BLoC, Provider
- **Local Database**: SQFlite
- **Cloud Storage**: Firebase Cloud Firestore
- **Authentication**: Firebase Auth
- **Notifications**: Local Notifications (Flutter Local Notifications) with cloud sync
- **Architecture**: Clean Architecture
- **Design**: Responsive Design
- **Testing**: Unit and Widget Tests

## Architecture
The project follows the **Clean Architecture** principles to ensure separation of concerns, maintainability, and scalability. While Clean Architecture typically involves splitting the app into features, this app uses a simplified structure without feature-based separation due to its relatively small scope. The core layers are:

- **Presentation Layer**: UI components, BLoC for state management, and Provider for dependency injection.
- **Domain Layer**: Business logic and use cases.
- **Data Layer**: Repositories, data sources (local with SQFlite and remote with Firebase), and models.

## Why No Feature-Based Split?
For this project, a feature-based split (e.g., separating "task creation," "task list," etc.) was considered unnecessary due to the app's modest size and complexity. Instead, a single cohesive structure was adopted to streamline development and maintenance.

## Setup Instructions

### Prerequisites
- Flutter SDK (latest stable version)
- Firebase project setup (for Firestore and Auth)
- Android Studio / VS Code
- Dart (bundled with Flutter)

### Installation
1. **Clone the repository**:
   ```bash
   git clone
   cd taskmanager
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**:
   - Set up a Firebase project in the [Firebase Console](https://console.firebase.google.com/).
   - Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) to the appropriate directories.
   - Enable Firebase Authentication (Email/Password or other providers).
   - Set up Firestore and configure rules.

4. **Run the app**:
   ```bash
   flutter run
   ```

### Running Tests
To execute the unit and widget tests:
```bash
flutter test
```

## Key Components
- **BLoC**: Manages the app's state and business logic (e.g., task CRUD operations, sync status).
- **Provider**: Handles dependency injection for repositories and services.
- **SQFlite**: Stores tasks locally for offline access.
- **Firebase Auth**: Secures user access.
- **Firestore**: Syncs tasks across devices.
- **Local Notifications**: Alerts users about upcoming tasks, with synchronization to remote data.

## Synchronization Logic
- Tasks are stored locally in SQFlite and synced to Firestore when an internet connection is available.
- Local notifications are scheduled based on task deadlines and updated when synced with remote data.

## Responsive Design
The app adapts to different screen sizes and orientations, ensuring a smooth experience on both mobile devices and web browsers.

## Future Enhancements
- Add task categories or tags.
- Implement advanced sync conflict resolution.
- Support for additional authentication providers (e.g., Google, Apple).
- Expand test coverage with integration tests.

## Contributing
Feel free to submit issues or pull requests. Contributions are welcome!

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

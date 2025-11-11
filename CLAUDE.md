# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Flutter Function Modules is a Korean-language modular Flutter project showcasing various UI components, APIs, and functionality demonstrations. The project uses GetX for state management and navigation, though there are plans to migrate away from GetX (see main.dart:42-43).

## Language Preference
**한국어로 답변해주세요.** 이 프로젝트에서 작업할 때는 모든 응답을 한국어로 제공해주시기 바랍니다.

## Development Commands

### Essential Commands
- `flutter run` - Run the app in debug mode
- `flutter build apk` - Build Android APK
- `flutter build ios` - Build iOS app
- `flutter test` - Run unit tests
- `flutter analyze` - Run static analysis (lint checking)
- `flutter pub get` - Install dependencies
- `flutter pub upgrade` - Upgrade dependencies
- `flutter clean` - Clean build files

### Code Generation Commands
The project uses Retrofit and JSON serialization:
- `flutter packages pub run build_runner build` - Generate code once
- `flutter packages pub run build_runner watch` - Watch for changes and generate code
- `flutter packages pub run build_runner build --delete-conflicting-outputs` - Force regenerate all generated files

## Architecture & Code Structure

### Navigation Architecture
The app uses a hybrid navigation approach:
- **GetX routing** for main feature pages (defined in main.dart getPages)
- **Standard Navigator** for sub-pages and dialogs
- **Entry point**: LottiSplashScreen → Lobby (main menu)

### State Management
- **GetX controllers** for complex state (video players, API calls)
- **StatefulWidget** for simple local state
- **Note**: Project plans to migrate away from GetX

### Key Modules & Features

#### Core Components
- `lobby.dart` - Main navigation hub with feature buttons
- `main.dart` - App entry point with GetX route definitions

#### Feature Modules
- **Video Player**: Custom video switching with GetX controllers (`video_player/`)
- **API Integration**: Kakao image search and Retrofit+Dio examples (`kakao_img_search_api/`, `retrofit_dio_json/`)
- **Custom Sliders**: Modified sleek_circular_slider package (`sleekCircularSlider_custom_made/`)
- **UI Demos**: AnimatedContainer, IndexedStack, Radio buttons (`animated_container/`, etc.)
- **Permissions**: Camera/media permission handling (`permission_handler/`)
- **Splash Screens**: Lottie animations (`splash/`)

#### Custom Components
- **Dialogs**: `custom_dialog.dart`, `custom_dialog_two_btn.dart`
- **Intro Slides**: Custom onboarding implementation

### Dependencies & Packages

#### Key Dependencies
- `get: ^4.6.6` - State management & navigation (planned for removal)
- `retrofit/dio` - HTTP client with code generation
- `video_player: ^2.2.7` - Flutter official video player
- `permission_handler: ^9.2.0` - Runtime permissions
- `font_awesome_flutter: ^10.1.0` - Icons (iOS Material icon alternative)
- `lottie: ^3.1.0` - Animations
- `flutter_svg: ^2.0.7` - SVG support

#### Asset Structure
- `assets/image/` - PNG images including pain level faces
- `assets/svg/` - SVG icons, logos, and UI elements  
- `assets/lottie/` - Animation files
- `assets/onboarding_test_img/` - Onboarding screen images

### Code Generation Files
Several files use code generation (`.g.dart` files):
- `kakao_data.g.dart`, `images_rest_client.g.dart` - API models
- `data.g.dart`, `rest_client.g.dart` - Retrofit clients

Always run build_runner after modifying files with `@JsonSerializable()` or `@RestApi()` annotations.

### Testing
- Basic unit tests in `test/` directory
- Example test shows Korean comments explaining test structure
- Note: Test in `simple_test.dart` has intentional failure for demonstration

### Platform Considerations
- Custom app icons for both platforms (`app_icon_ffm.png`)
- iOS-specific configurations in Runner project
- Android Gradle setup with custom package name (`kr.co.sprint.flutter_function_modules`)

### Known Issues & TODO Items
- GetX migration planned (main.dart:42-43)
- Video functionality requires separate management (lobby.dart:46)
- Some overflow issues resolved in recent commits
- Gradle and Manifest icon configurations updated in recent commits
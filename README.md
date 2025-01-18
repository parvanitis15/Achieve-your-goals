# Achieve Your Goals

## Overview
The Achieve Your Goals is designed to inspire users to embrace new habits through daily quotes, goal setting, and action logging. This application provides a user-friendly interface to help individuals stay motivated and track their progress towards personal goals.

## Features
- **Daily Quote Generator**: Fetches and displays a new quote about building new habits each day.
- **Goal Input Prompt**: Allows users to input and save their personal goal.
- **Daily Action Logging**: Users can log their daily actions towards achieving their goals and view a history of their logged actions.

## Project Structure
```
new_beginnings_app
├── lib
│   ├── main.dart
│   ├── screens
│   │   ├── home_screen.dart
│   │   ├── goal_screen.dart
│   │   └── log_screen.dart
│   ├── widgets
│   │   ├── quote_widget.dart
│   │   ├── goal_input_widget.dart
│   │   └── action_log_widget.dart
│   └── models
│       ├── quote.dart
│       ├── goal.dart
│       └── action_log.dart
├── quote_generation
│   ├── README.md
├── test
├── pubspec.yaml
└── README.md
```

## Setup Instructions
1. Clone the repository to your local machine.
2. Navigate to the project directory.
3. Run `flutter pub get` to install the necessary dependencies.
4. Use `flutter run` to start the application on your preferred device.

## Usage
- (Optionally) Set up the quote generation feature by following the instructions in the [quote_generation](quote_generation) README.
- Launch the app to view the daily quote on the home screen.
- Navigate to the goal screen to set and save your personal goal.
- Use the log screen to document daily actions taken towards your goals.

## Testing
This project uses the `flutter_test` package for unit testing. To run the tests, use the following command:
```
flutter test
```

## Contributing
Contributions are welcome! Please feel free to submit a pull request or open an issue for any suggestions or improvements.

## License
This project is open-source and available under the MIT License.
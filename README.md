# New Beginnings App

## Overview
The New Beginnings App is designed to inspire users to embrace new beginnings through daily quotes, goal setting, and action logging. This application provides a user-friendly interface to help individuals stay motivated and track their progress towards personal goals.

## Features
- **Daily Quote Generator**: Fetches and displays a new quote about new beginnings each day.
- **Goal Input Prompt**: Allows users to input and save their personal goals for future reference.
- **Daily Action Logging**: Users can log their daily actions towards achieving their goals and view a history of their logged actions.

## Project Structure
```
new_beginnings_app
├── lib
│   ├── main.dart
│   ├── screens
│   │   ├── home_screen.dart
│   │   ├── quote_screen.dart
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
├── pubspec.yaml
└── README.md
```

## Setup Instructions
1. Clone the repository to your local machine.
2. Navigate to the project directory.
3. Run `flutter pub get` to install the necessary dependencies.
4. Use `flutter run` to start the application on your preferred device.

## Usage
- Launch the app to view the daily quote on the home screen.
- Navigate to the goal screen to set and save your personal goals.
- Use the log screen to document daily actions taken towards your goals.

## Contributing
Contributions are welcome! Please feel free to submit a pull request or open an issue for any suggestions or improvements.

## License
This project is open-source and available under the MIT License.
# Cyclical Value Notifier

![Pub Version](https://img.shields.io/pub/v/cyclical_value_notifier)
![GitHub](https://img.shields.io/github/license/your-username/cyclical_value_notifier)

**Cyclical Value Notifier** is a Flutter package that provides a customizable `ValueNotifier` implementation capable of periodic value updates from asynchronous sources. It allows you to effortlessly manage and display real-time data in your Flutter applications by periodically fetching and updating values.

## Key Features

- **Periodic Value Updates**: Fetch and update values from asynchronous sources at specified intervals.
- **Customizable Fetch Function**: Define your own asynchronous fetch function to retrieve the latest data.
- **Effortless Real-Time Data**: Keep your UI up-to-date with minimal code and maximum flexibility.
- **Easy Integration**: Seamlessly integrate with your existing Flutter projects.

## Getting Started

1. **Installation**: Add the `cyclical_value_notifier` package to your `pubspec.yaml`:
   
```yaml
  dependencies:
    cyclical_value_notifier: ^1.0.0  # Replace with the latest version
```

2. **Import**: Import the package in your Dart code:

```dart
import 'package:cyclical_value_notifier/cyclical_value_notifier.dart';
```

3. **Usage**: Import the package in your Dart code:

```dart
final notifier = CyclicalValueNotifier<int>(
  0,
  interval: Duration(seconds: 1),
  fetch: () async {
    // Fetch the latest value from an asynchronous source
    // For example, an API call to get the current count
    final response = await apiService.getCount();
    return response.count;
  },
);

// Access the latest data from the notifier
final currentValue = notifier.value;
```

## Example
Here's a simple example demonstrating how to use CyclicalValueNotifier to fetch and update a value periodically:
```dart
import 'package:flutter/material.dart';
import 'package:cyclical_value_notifier/cyclical_value_notifier.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final apiService = ApiService(); // Replace with your own service

  @override
  Widget build(BuildContext context) {
    final notifier = CyclicalValueNotifier<int>(
      0,
      interval: Duration(seconds: 5),
      fetch: () async {
        // Fetch the latest value from an asynchronous source
        final response = await apiService.getCount();
        return response.count;
      },
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cyclical Value Notifier Example'),
        ),
        body: Center(
          child: ValueListenableBuilder<int>(
            valueListenable: notifier,
            builder: (context, value, child) {
              return Text('Current Value: $value');
            },
          ),
        ),
      ),
    );
  }
}
```



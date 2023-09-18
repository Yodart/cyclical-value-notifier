library cyclical_value_notifier;

import 'dart:async';
import 'package:flutter/foundation.dart';

/// A ValueNotifier implementation that periodically updates its value by fetching
/// a new value from an asynchronous source.
///
/// The [CyclicalValueNotifier] periodically invokes the provided [fetch] function
/// after every [interval] duration. It then compares the fetched result with the
/// current value and updates the value if it's different.
///
/// Example usage:
/// ```dart
/// final notifier = CyclicalValueNotifier<int>(
///   0,
///   interval: Duration(seconds: 1),
///   fetch: () async {
///     // Fetch the latest value from an asynchronous source
///     // For example, an API call to get the current count
///     final response = await apiService.getCount();
///     return response.count;
///   },
/// );
/// ```
class CyclicalValueNotifier<T> extends ValueNotifier<T> {
  /// Creates a [CyclicalValueNotifier] with the specified [initialValue],
  /// [interval], and [fetch] function.
  ///
  /// The [interval] determines the frequency at which the [fetch] function is called.
  /// The [fetch] function should return a [T] value wrapped in a [Future] or [null].
  ///
  /// The [initialValue] sets the initial value for the notifier.
  CyclicalValueNotifier(
    super.value, {
    bool updateOnInit = true,
    required this.interval,
    required this.fetch,
  }) {
    if (updateOnInit) updateValue();
    _initializeTimer();
  }

  /// The duration between each periodic update.
  final Duration interval;

  /// An asynchronous function that fetches the latest value.
  final AsyncValueGetter<T?> fetch;
  late final Timer _timer;

  void _initializeTimer() {
    _timer = Timer.periodic(interval, (_) => updateValue());
  }

  /// Updates the internal value of the notifier based on the result of
  /// the provided fetch method.
  Future<void> updateValue() async {
    final result = await fetch();
    if (result != null && result != value) value = result;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

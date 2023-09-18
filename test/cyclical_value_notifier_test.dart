import 'package:cyclical_value_notifier/cyclical_value_notifier.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CyclicalValueNotifier<int> notifier;
  late int fetchCallCount;

  setUp(() {
    fetchCallCount = 0;
    notifier = CyclicalValueNotifier<int>(
      0,
      interval: const Duration(seconds: 1),
      fetch: () async {
        fetchCallCount++;
        return fetchCallCount;
      },
    );
  });

  tearDown(() {
    notifier.dispose();
  });

  test('Value is updated after interval duration', () async {
    await Future.delayed(const Duration(seconds: 2));
    expect(notifier.value, equals(2));
  });

  test('Value is not updated if fetch returns null', () async {
    notifier = CyclicalValueNotifier<int>(
      0,
      interval: const Duration(seconds: 1),
      fetch: () async {
        return null;
      },
    );
    await Future.delayed(const Duration(seconds: 2));
    expect(notifier.value, equals(0));
  });

  test('Value is not updated if fetch returns the same value', () async {
    notifier = CyclicalValueNotifier<int>(
      0,
      interval: const Duration(seconds: 1),
      fetch: () async {
        return notifier.value;
      },
    );
    await Future.delayed(const Duration(seconds: 2));
    expect(notifier.value, equals(0));
  });

  test('Fetch function is called at least twice', () async {
    await Future.delayed(const Duration(seconds: 3));
    expect(fetchCallCount, greaterThanOrEqualTo(2));
  });
}

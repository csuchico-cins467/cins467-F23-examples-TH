import 'package:counter_test/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Counter Class", () {
    test('Counter value should start at 0', () {
      expect(Counter().count, 0);
    });

    test('Counter value should be incremented', () {
      final counter = Counter();
      counter.increment();
      expect(counter.count, 1);
    });

    test('Counter value should be decremented', () {
      final counter = Counter();
      counter.decrement();
      expect(counter.count, -1);
    });

    test('Counter value should be added by more than one', () {
      final counter = Counter();
      counter.add(2);
      expect(counter.count, 2);
    });

    test('Counter value should be subtracted by more than one', () {
      final counter = Counter();
      counter.add(-2);
      expect(counter.count, -2);
    });

    test('Counter value should be reset', () {
      final counter = Counter();
      counter.add(-2);
      expect(counter.count, -2);
      counter.reset();
      expect(counter.count, 0);
    });
  });
}

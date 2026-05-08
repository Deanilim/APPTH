import 'package:appth/models/lesson_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('LessonItem conserva sus valores', () {
    const item = LessonItem(
      label: 'A',
      emoji: '🍎',
      description: 'A de Manzana',
    );

    expect(item.label, 'A');
    expect(item.emoji, '🍎');
    expect(item.description, 'A de Manzana');
  });
}

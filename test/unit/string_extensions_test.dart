import 'package:flutter_test/flutter_test.dart';
import 'package:herotome/extensions/string_extension.dart';

void main() {
  group('CasingStringExtension space separated tests', () {
    test('Base book title', () {
      String title = 'Base book title';
      String titleCorrect = 'Base Book Title';
      expect(title.toTitleCase(), equals(titleCorrect));
    });
    
    test('base book title', () {
      String title = 'base book title';
      String titleCorrect = 'Base Book Title';
      expect(title.toTitleCase(), equals(titleCorrect));
    });
    test('Base book title', () {
      String title = 'Base book title';
      String titleCorrect = 'Base Book Title';
      expect(title.toTitleCase(), equals(titleCorrect));
    });
    test('Base  book  title - double space', () {
      String title = 'Base  book  title';
      String titleCorrect = 'Base  Book  Title';
      expect(title.toTitleCase(), equals(titleCorrect));
    });
  });

  group('CasingStringExtension underscore separated tests', () {
    test('Base_book_title', () {
      String title = 'Base_book_title';
      String titleCorrect = 'Base Book Title';
      expect(title.toTitleCase(), equals(titleCorrect));
    });
    
    test('_base_book_title', () {
      String title = '_base_book_title';
      String titleCorrect = ' Base Book Title';
      expect(title.toTitleCase(), equals(titleCorrect));
    });
    test('Base book title_', () {
      String title = 'Base book title_';
      String titleCorrect = 'Base Book Title ';
      expect(title.toTitleCase(), equals(titleCorrect));
    });
    test('Base  _book  _title - space and underscore', () {
      String title = 'Base _book _title';
      String titleCorrect = 'Base Book Title';
      expect(title.toTitleCase(), equals(titleCorrect));
    });
  });
}

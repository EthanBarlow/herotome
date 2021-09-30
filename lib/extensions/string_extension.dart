/*
Almost an exact copy from https://coflutter.com/dart-flutter-how-to-capitalize-first-letter-of-each-word-in-a-string/
Why reinvent the wheel?
*/

extension CasingStringExtension on String {
  String toTitleCase() {
    return convertToTitleCase(this);
  }
}

String convertToTitleCase(String text) {
  if (text.length == 1) {
    return text.toUpperCase();
  }

  List<String> words = text.split(' ');
  Iterable<String> capitalizedWords = words.map((word) {
    if (word.trim().isNotEmpty) {
      final String firstLetter = word.trim().substring(0, 1).toUpperCase();
      final String remainingLetters = word.trim().substring(1);

      return firstLetter + remainingLetters;
    }
    return '';
  });

  words = capitalizedWords.join(' ').split('_');
  capitalizedWords = words.map((word) {
    if (word.trim().isNotEmpty) {
      final String firstLetter = word.trim().substring(0, 1).toUpperCase();
      final String remainingLetters = word.trim().substring(1);

      return firstLetter + remainingLetters;
    }
    return '';
  });

  return capitalizedWords.join(' ');
}

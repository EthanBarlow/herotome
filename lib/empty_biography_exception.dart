import 'package:herotome/constants.dart';

class EmptyBiographyException implements Exception {
  final String errorMessage;
  const EmptyBiographyException(this.errorMessage);
  @override
  String toString() {
    return MyConstants.emptyBiographyException + errorMessage;
  }
}
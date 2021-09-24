class EmptyBiographyException implements Exception {
  final String errorMessage;
  const EmptyBiographyException(this.errorMessage);
  @override
  String toString() {
    return 'EmptyBiographyException thrown. Must not have a biography saved in firestore.\n$errorMessage';
  }
}
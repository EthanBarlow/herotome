import 'package:flutter_riverpod/all.dart';
import 'package:herotome/application/hero_bio_notifier.dart';
import 'package:herotome/infrastructure/repositories/hero_bio_repository.dart';

final _heroBiographyRepositoryProvider = Provider<HeroBiographyRepository>(
  (ref) => FakeHeroBiographyRepository(),
);

final heroBiographyNotifierProvider = StateNotifierProvider<HeroBioNotifier, HeroBioState>(
    (ref) => HeroBioNotifier(ref.watch(_heroBiographyRepositoryProvider)));

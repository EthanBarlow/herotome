import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herotome/application/hero_bio_notifier.dart';
import 'package:herotome/infrastructure/repositories/hero_bio_repository.dart';

final _heroBiographyRepositoryProvider = Provider<HeroBiographyRepository>(
  (ref) => RealHeroBiographyRepository(),
);

final heroBiographyNotifierProvider =
    StateNotifierProvider<HeroBioNotifier, HeroBioState>(
        (ref) => HeroBioNotifier(ref.watch(_heroBiographyRepositoryProvider)));

final imageLinkPrefixProvider =
    Provider((ref) => 'https://terrigen-cdn-dev.marvel.com/content/prod/1x/');

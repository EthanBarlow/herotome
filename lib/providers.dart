import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herotome/application/hero_bio_notifier.dart';
import 'package:herotome/application/hero_profile_notifier.dart';
import 'package:herotome/infrastructure/repositories/hero_bio_repository.dart';
import 'package:herotome/infrastructure/repositories/hero_profile_repository.dart';
import 'package:herotome/mocks/hero_mock.dart';

final _heroBiographyRepositoryProvider = Provider<HeroBiographyRepository>(
  (ref) => FakeHeroBiographyRepository(),
);

final heroBiographyNotifierProvider =
    StateNotifierProvider<BioNotifier, BioState>(
        (ref) => BioNotifier(ref.watch(_heroBiographyRepositoryProvider)));

final imageLinkPrefixProvider =
    Provider((ref) => 'https://terrigen-cdn-dev.marvel.com/content/prod/1x/');

final _profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => FakeProfileRepository(),
);

final profileNotifierProvider = StateNotifierProvider<ProfileNotifier, ProfileState>(
  (ref) => ProfileNotifier(ref.watch(_profileRepositoryProvider))
);

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herotome/constants.dart';
import 'package:herotome/infrastructure/models/hero_bio.dart';
import 'package:herotome/infrastructure/models/my_hero.dart';
import 'package:herotome/infrastructure/repositories/hero_bio_repository.dart';

abstract class BioState {
  const BioState();
}

class BioInitial extends BioState {
  const BioInitial();
}

class BioLoading extends BioState {
  const BioLoading();
}

class BioLoaded extends BioState {
  final HeroBio biography;
  const BioLoaded(this.biography);
}

class BioError extends BioState {
  final String message;
  const BioError(this.message);
}

class BioNotifier extends StateNotifier<BioState> {
  final HeroBiographyRepository _heroBiographyRepository;
  BioNotifier(this._heroBiographyRepository) : super(BioInitial());

  Future<void> getBiography(HeroProfile hero) async {
    try {
      state = BioLoading();
      final bio = await _heroBiographyRepository.fetchHeroBiography(hero);
      state = BioLoaded(bio);
    } on Exception {
      state = BioError(MyConstants.heroBioErrorMessage);
    }
  }
}

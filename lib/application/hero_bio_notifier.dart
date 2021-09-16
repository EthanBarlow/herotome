import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herotome/infrastructure/models/my_hero.dart';
import 'package:herotome/infrastructure/repositories/hero_bio_repository.dart';

abstract class HeroBioState {
  const HeroBioState();
}

class HeroBioInitial extends HeroBioState {
  const HeroBioInitial();
}

class HeroBioLoading extends HeroBioState {
  const HeroBioLoading();
}

class HeroBioLoaded extends HeroBioState {
  final HeroBio biography;
  const HeroBioLoaded(this.biography);
}

class HeroBioError extends HeroBioState {
  final String message;
  const HeroBioError(this.message);
}

class HeroBioNotifier extends StateNotifier<HeroBioState> {
  final HeroBiographyRepository _heroBiographyRepository;
  HeroBioNotifier(this._heroBiographyRepository) : super(HeroBioInitial());

  Future<void> getBiography(MyHero hero) async {
    try {
      state = HeroBioLoading();
      final bio = await _heroBiographyRepository.fetchHeroBiography(MyHero(link: '', name: ''));
      state = HeroBioLoaded(bio);
    } on Exception {
      state = HeroBioError("Couldn't get a hold of this hero's secretary. Leave a message...");
    }
  }
}

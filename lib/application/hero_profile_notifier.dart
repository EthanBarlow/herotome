import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herotome/infrastructure/models/my_hero.dart';
import 'package:herotome/infrastructure/repositories/hero_profile_repository.dart';

abstract class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  final List<HeroProfile> profiles;
  const ProfileLoaded(this.profiles);
}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);
}

class ProfileNotifier extends StateNotifier<ProfileState> {
  final ProfileRepository _profileRepository;
  ProfileNotifier(this._profileRepository) : super(ProfileInitial());

  Future<void> getProfileList() async {
    try {
      state = ProfileLoading();
      final profiles = await _profileRepository.fetchHeroProfileList();
      state = ProfileLoaded(profiles);
    } on Exception {
      state = ProfileError("The directory is not working at the moment");
    }
  }
}

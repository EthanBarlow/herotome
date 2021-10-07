import 'dart:convert';

import 'package:herotome/infrastructure/models/my_hero.dart';
import 'package:test/test.dart';

void main() {
  group('MyHero and HeroProfile object instantiation', () {
    test('Basic test of MyHero constructor and accessing fields', () {
      MyHero myHero = new MyHero(name: 'name', link: 'link');
      expect(myHero.name, equals('name'));
      expect(myHero.link, equals('link'));
    });
    test('Basic test of HeroProfile constructor and accessing fields', () {
      HeroProfile heroProfile = new HeroProfile(
        name: 'name',
        link: 'link',
        imgLink: 'imgLink',
        context: 'context',
      );
      expect(heroProfile.name, equals('name'));
      expect(heroProfile.link, equals('link'));
      expect(heroProfile.imgLink, equals('imgLink'));
      expect(heroProfile.context, equals('context'));
    });
  });

  group('HeroProfile.fromJson tests', () {
    test('basic', () {
      String jsonString =
          '{"context": "comic", "headline": "Thor", "image": "thorult01.jpg", "link": "/characters/thor-ultimate"}';
      HeroProfile profile = HeroProfile.fromJson(jsonDecode(jsonString));

      expect(profile.context, equals('comic'));
      expect(profile.imgLink, equals('thorult01.jpg'));
      expect(profile.name, equals('Thor'));
      expect(profile.link, equals('/characters/thor-ultimate'));
    });

    test('extra data', () {
      String jsonString =
          '{"context": "comic", "headline": "Thor", "image": "thorult01.jpg", "link": "/characters/thor-ultimate", "extra": "data"}';
      HeroProfile profile = HeroProfile.fromJson(jsonDecode(jsonString));

      expect(profile.context, equals('comic'));
      expect(profile.imgLink, equals('thorult01.jpg'));
      expect(profile.name, equals('Thor'));
      expect(profile.link, equals('/characters/thor-ultimate'));
    });

    test('empty field', () {
      String jsonString =
          '{"context": "comic", "image": "thorult01.jpg", "link": "/characters/thor-ultimate"}';
      HeroProfile profile = HeroProfile.fromJson(jsonDecode(jsonString));

      expect(profile.context, equals('comic'));
      expect(profile.imgLink, equals('thorult01.jpg'));
      expect(profile.link, equals('/characters/thor-ultimate'));
    });

    test('null field', () {
      String jsonString =
          '{"context": "comic", "headline": "Thor", "image": null, "link": "/characters/thor-ultimate", "extra": "data"}';
      HeroProfile profile = HeroProfile.fromJson(jsonDecode(jsonString));

      expect(profile.context, equals('comic'));
      expect(profile.imgLink, equals('null'));
      expect(profile.name, equals('Thor'));
      expect(profile.link, equals('/characters/thor-ultimate'));
    });
  });
}

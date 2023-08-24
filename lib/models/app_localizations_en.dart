import 'dart:ui';

import 'package:gercetur07/models/app_localizations.dart';

class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn() : super(const Locale('en'));

  @override
  String? getTranslatedValue(String key) {
    switch (key) {
      case 'welcome':
        return 'Welcome';
      case 'discoverDestinations':
        return 'Discover incredible destinations and plan your trips easily.';
      case 'exploreAndChoose':
        return 'Explore a wide variety of destinations and choose the perfect place for your vacation.';
      case 'enjoyExperience':
        return 'Enjoy unique experiences and create unforgettable memories on every trip.';
      default:
        return null;
    }
  }
}

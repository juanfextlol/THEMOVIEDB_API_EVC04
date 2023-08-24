import 'dart:ui';

import 'package:gercetur07/models/app_localizations.dart';

class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs() : super(const Locale('es'));

  @override
  String? getTranslatedValue(String key) {
    switch (key) {
      case 'welcome':
        return 'Bienvenido';
      case 'discoverDestinations':
        return 'Descubre destinos increíbles y planifica tus viajes de manera sencilla.';
      case 'exploreAndChoose':
        return 'Explora una amplia variedad de destinos y elige el lugar perfecto para tus vacaciones.';
      case 'enjoyExperience':
        return 'Vive experiencias únicas y crea recuerdos inolvidables en cada viaje que realices.';
      default:
        return null;
    }
  }
}

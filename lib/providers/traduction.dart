import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TraductionAPI {
  static String getPlaceType(String nameType, AppLocalizations lang) {
    switch(nameType){
      case 'ClassRoom':
        return lang.nameTypeClass;
      case 'Building':
        return lang.nameTypeBuilding;
      case 'ComputerLab':
        return lang.nameTypePc;
      default:
        return lang.nameTypeVertex;
    }
  }
}

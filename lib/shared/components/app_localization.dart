import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalization {
  final Locale? local;
  AppLocalization({this.local});

  static AppLocalization? of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  static const LocalizationsDelegate<AppLocalization> delegate =
      _AppLocalizationsDelegate();

  late Map<String, String> _localizedString;

  Future loadJsonLanguage() async {
    String jsonString =
        await rootBundle.loadString('assets/lang/${local?.languageCode}.json');

    Map<String, dynamic> jsonMap = await json.decode(jsonString);

    _localizedString = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

  }
  String translate(String key) => _localizedString[key] ?? "";
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization> {

  const _AppLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization localization = AppLocalization(local: locale);
    await localization.loadJsonLanguage();
    return localization;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) => false;


}

extension TranslateX on String{
  String tr(BuildContext context){
    return AppLocalization.of(context)!.translate(this);
  }
}


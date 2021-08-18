import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile_authentication/localization/app_localization.dart';

/// Localization delegate that builds an [AppLocalization] instance
class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  /// Localization delegte of the app
  const AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'it'].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) =>
      SynchronousFuture<AppLocalization>(AppLocalization(locale));

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) =>
      false;
}

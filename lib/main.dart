import 'package:easy_localization/easy_localization.dart' show EasyLocalization;
import 'package:flutter/material.dart' show Locale, runApp;

import 'app/app.dart' show App;
import 'app/core/utils/assets/index.dart';
import 'app/core/utils/constants/index.dart';
import 'app/injector.dart' show initDependencies;
import 'config.dart' show Config;

@pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)
// async {
//   debugPrint('Handling a background message ${message.messageId}');
// }

void main() async {
  await initDependencies();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // // await FirebaseMessaging.instance.subscribeToTopic("all");
  // await inject<FirebaseNotificationService>().initialize();

  runApp(
    EasyLocalization(
      useOnlyLangCode: true,
      startLocale: const Locale(Config.locale),
      supportedLocales: supportLocales,
      path: Assets.translations,
      child: const App(),
    ),
  );
}

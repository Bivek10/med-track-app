import 'package:easy_localization/easy_localization.dart' show EasyLocalization;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'app/app.dart' show App;
import 'app/core/utils/assets/index.dart';
import 'app/core/utils/constants/index.dart';
import 'app/core/utils/fcm_service.dart';
import 'app/injector.dart' show initDependencies, inject;
import 'config.dart' show Config;
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initDependencies();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await FirebaseMessaging.instance.subscribeToTopic("all");
  await inject<FirebaseNotificationService>().initialize();

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

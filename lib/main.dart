import 'dart:io';
import 'package:NearMii/firebase_options.dart';
import 'package:NearMii/notification/notification_service.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'config/helper.dart';
import 'config/provider_logs.dart';
import 'core/helpers/app_injector.dart';
import 'core/utils/routing/routes.dart';
import 'core/utils/routing/routes_generator.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  if (Platform.isAndroid) {
    MobileAds.instance.initialize();
    await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform, name: "Nearmii")
        .then((value) async {
      final NotificationService service = NotificationService();
      await service.init();
      // await service.initNotification();
      // await service.initPushNotificationListeners();
    });
  }
  // else {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   ).then((value) async {
  //     final NotificationService service = NotificationService();
  //     await service.init();

  //     // await service.initNotification();
  //     // await service.initPushNotificationListeners();
  //   });
  // }

  await AppInjector.init(
    appRunner: () =>
        runApp(ProviderScope(observers: [MyObserver()], child: const MyApp())),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        navigatorObservers: [BotToastNavigatorObserver()],
        navigatorKey: navigatorKey,
        title: AppString.appName,
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          child = botToastBuilder(context, child);
          return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.0)),
              child: child);
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: false,
        ),
        initialRoute: Routes.splash,
        onGenerateRoute: RouteGenerator.generateRoute,
        onGenerateInitialRoutes: (String initialRouteName) {
          return [
            RouteGenerator.generateRoute(const RouteSettings(
              name: Routes.splash,
            )),
          ];
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

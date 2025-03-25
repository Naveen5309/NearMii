import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:NearMii/core/helpers/all_getter.dart';
import 'package:NearMii/core/utils/routing/routes.dart';
import 'package:NearMii/notification/notification_entity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import '../../../config/helper.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();
  static const JsonDecoder _decoder = JsonDecoder();
  static const JsonEncoder _encoder = JsonEncoder.withIndent('  ');

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  /// Create a [AndroidNotificationChannel] for heads up notifications
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    // description
    importance: Importance.max,
  );

  final BehaviorSubject<String?> _selectNotificationSubject =
      BehaviorSubject<String?>();

  //instance of FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    _configureSelectNotificationSubject();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher_round');
    DarwinInitializationSettings initializationSettingsDarwin =
        const DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,

      //  onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: null,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        if (notificationResponse.notificationResponseType ==
            NotificationResponseType.selectedNotification) {
          _selectNotificationSubject.add(notificationResponse.payload);
        }
      },
    );

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    _initFirebaseListeners();
  }

  void _configureSelectNotificationSubject() {
    _selectNotificationSubject.stream.listen((String? payload) async {
      if (Getters.authToken?.isEmpty ?? true) {
        return;
      }
      NotificationEntity? entity = convertStringToNotificationEntity(payload);
      printLog(
          "notification _configureSelectNotificationSubject ${entity.toString()}");
      if (entity != null) {
        _pushNextScreenFromForeground(entity);
      }
    });
  }

/*  Future? _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    if (Getters.authToken?.isEmpty ?? true) {
      return null;
    }
    NotificationEntity? entity = convertStringToNotificationEntity(payload);

    printLog("notification onDidReceiveLocalNotification ${entity.toString()}");
    if (entity != null) {
      _pushNextScreenFromForeground(entity);
    }
    return null;
  }*/

  void _initFirebaseListeners() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (Getters.authToken?.isEmpty ?? true) {
        printLog("userToken is Null");
        return;
      }
      printLog("IOS Foreground notification opened: ${message.data}");
      NotificationEntity notificationEntity =
          NotificationEntity.fromJson(message.data);
      _pushNextScreenFromForeground(notificationEntity);
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (Platform.isIOS || (Getters.authToken?.isEmpty ?? true)) {
        return;
      }

      printLog("🔔 Foreground notification received:");
      printLog("🔹 Message ID: ${message.messageId}");
      printLog("🔹 Data: ${message.data}");
      printLog("🔹 Notification: ${message.notification}");

      NotificationEntity notificationEntity = NotificationEntity();
      notificationEntity.title = message.notification?.title ?? "NearMii";
      notificationEntity.body = message.notification?.body ?? '';

      _showNotifications(notificationEntity);
    });
  }

  /* Future? _onSelectNotification(String? payload) {
    if (Getters.authToken?.isEmpty??true) {
      return null;
    }
    NotificationEntity? entity = convertStringToNotificationEntity(payload);
    printLog("notification onSelectNotification ${entity.toString()}");
    if (entity != null) {
      _pushNextScreenFromForeground(entity);
    }
    return null;
  }*/

  Future<void> _showNotifications(NotificationEntity notificationEntity) async {
    Random random = Random();
    int id = random.nextInt(900) + 10;
    await _flutterLocalNotificationsPlugin.show(
        id,
        notificationEntity.title,
        notificationEntity.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: "@mipmap/ic_launcher_round",
            channelShowBadge: true,
            playSound: true,
            priority: Priority.high,
            importance: Importance.high,
            styleInformation:
                BigTextStyleInformation(notificationEntity.body ?? ''),
          ),
        ),
        payload: convertNotificationEntityToString(notificationEntity));
  }

  void _pushNextScreenFromForeground(
      NotificationEntity notificationEntity) async {
    final tuple2 = await callApi(notificationEntity);

    if (tuple2 != null) {
      // if (myRouteObserver.currentRoute == Routes.notification && Getters.getContext!.mounted) {
      //
      // }else {
      toNamed(Getters.getContext!, Routes.notification);
      // }
    }
  }

  Future<(String, Object?)?> callApi(NotificationEntity entity) async {
    return (Routes.notification, null);
  }

  Future<(String, Object?)?> getPushNotificationRoute() async {
    RemoteMessage? remoteMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    const NotificationAppLaunchDetails? notificationAppLaunchDetails = null;
    if (remoteMessage != null && remoteMessage.data.isNotEmpty) {
      printLog("RemoteMessage data ${remoteMessage.data}");
      NotificationEntity notificationEntity =
          NotificationEntity.fromJson(remoteMessage.data);
      notificationEntity.title = remoteMessage.data['title'];
      notificationEntity.body = remoteMessage.data['body'];
      notificationEntity.type = remoteMessage.data['type'];
      return callApi(notificationEntity);
    }
    if (notificationAppLaunchDetails?.didNotificationLaunchApp == true) {
      NotificationEntity? entity = convertStringToNotificationEntity(
          notificationAppLaunchDetails?.notificationResponse?.payload);
      if (entity != null) {
        printLog("RemoteMessage data ${entity.toJson()}");
        return callApi(entity);
      }
    }

    return null;
  }

  String convertNotificationEntityToString(
      NotificationEntity? notificationEntity) {
    String value = _encoder.convert(notificationEntity);
    return value;
  }

  NotificationEntity? convertStringToNotificationEntity(String? value) {
    if (value == null) {
      return null;
    }

    Map<String, dynamic> map = _decoder.convert(value);
    return NotificationEntity.fromJson(map);
  }

  /// used for clear the badges.
  static Future<void> clearBadge() async {
    try {
      /// method channel.
      MethodChannel channel =
          const MethodChannel('com.example.app/notifications');

      await channel.invokeMethod('clearBadge');
    } on PlatformException catch (e) {
      printLog("Failed to clear badge: '${e.message}'.");
    }
  }
}

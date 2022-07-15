import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lajmi.net/constant/constant.dart';
import 'package:lajmi.net/navbar.dart';
import 'package:lajmi.net/navbar_items/njoftitmet.dart';

import 'package:lajmi.net/providers/notification_provider.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  bool isReceived = false;
  bool isOpen = false;

  @override
  void initState() {
    super.initState();

    configOneSignel();
    initOneSignal(context);
    OneSignal.shared.setNotificationOpenedHandler(
        (OSNotificationOpenedResult result) async {
      setState(() {
        isOpen = true;
      });
      try {} catch (e) {}
    });

    permissionStatusFuture = getCheckNotificationPermStatus();
    WidgetsBinding.instance.addObserver(this);
  }

  late Future<String> permissionStatusFuture;

  var permGranted = "granted";
  var permDenied = "denied";
  var permUnknown = "unknown";
  var permProvisional = "provisional";

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
        permissionStatusFuture = getCheckNotificationPermStatus();
      });
    }
  }

  Future<String> getCheckNotificationPermStatus() {
    return NotificationPermissions.getNotificationPermissionStatus()
        .then((status) {
      switch (status) {
        case PermissionStatus.denied:
          return permDenied;
        case PermissionStatus.granted:
          return permGranted;
        case PermissionStatus.unknown:
          return permUnknown;
        case PermissionStatus.provisional:
          return permProvisional;
        default:
          return '';
      }
    });
  }

  Future<void> initOneSignal(BuildContext context) async {
    /// Set App Id.
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('osUserID') == null) {
      await OneSignal.shared.setAppId(oneSignalAppId);

      /// Get the Onesignal userId and update that into the firebase.
      /// So, that it can be used to send Notifications to users later.̥
      final status1 = await OneSignal.shared.getDeviceState();
      final status = await OneSignal.shared.getDeviceState();
      final osUserID = status!;

      final String osUserID1 = status.userId!;
      // We will update this once he logged in and goes to dashboard.
      ////updateUserProfile(osUserID);
      // Store it into shared prefs, So that later we can use it.
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('osUserID', osUserID1);


      // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
      await OneSignal.shared.promptUserForPushNotificationPermission(
        fallbackToSettings: true,
      );
      await FirebaseFirestore.instance.collection('users').doc(osUserID1).set({
        'userId': osUserID1,
        'favorites': [],
      });
    }

    /// Calls when foreground notification arrives.
    // OneSignal.shared.setNotificationWillShowInForegroundHandler(
    //   handleForegroundNotifications,
    // );

    // /// Calls when the notification opens the app.
    // OneSignal.shared.setNotificationOpenedHandler(handleBackgroundNotification);
  }

  void configOneSignel() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    await OneSignal.shared.setAppId(
        oneSignalAppId); //this ‘oneSignalAppId’ is imported from constant.dart file
  }

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotificationProvider(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Path Provider',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: isOpen
              ? Njoftimet(
                  isOpen,
                )
              : NavBar(
                  false,
                )
                ),
    );
  }
}

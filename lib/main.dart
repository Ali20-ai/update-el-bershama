import 'package:el_bershama/core/notifications/notification_service.dart';
import 'package:el_bershama/features/auth/cubit/home/home_cubit.dart';
import 'package:el_bershama/features/auth/login/login.dart';
import 'package:el_bershama/features/auth/signUp/sign_up.dart';
import 'package:el_bershama/features/home/home_screen.dart';
import 'package:el_bershama/features/newMdeicien/add_medic.dart';
import 'package:el_bershama/features/splash/splash.dart';
import 'package:el_bershama/features/Onboarding/Onboarding_Screen.dart';
import 'package:el_bershama/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } on FirebaseException catch (e) {
    if (e.code != 'duplicate-app') {
      rethrow; // إعادة رمي أي خطأ آخر غير التطبيق المكرر
    }
    // إذا كان duplicate-app، نستمر بصمت
  }

  const AndroidInitializationSettings androidInit =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initSettings =
      InitializationSettings(android: androidInit);

  await notificationsPlugin.initialize(initSettings);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Splash(),
      routes: {
        'start': (context) => const OnboardingScreen(),
        'login': (context) => BlocProvider(
              create: (context) => HomeCubit(),
              child: const Login(),
            ),
        'singUp': (context) => BlocProvider(
              create: (context) => HomeCubit(),
              child: const SignUp(),
            ),
        'Home': (context) => BlocProvider(
              create: (context) => HomeCubit(),
              child: const HomeScreen(),
        ),
        'addMedicine': (context) => const AddMedicineScreen()
      },
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasetesting/firebase_options.dart';
import 'package:get_it/get_it.dart';
import 'package:firebasetesting/router/app_router.dart';
import '../repositories/auth_repository.dart';

final GetIt getIt = GetIt.instance;


Future<void> setupServiceLocator() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
  );
  // Corrected registration: removed the () after AppRouter
  getIt.registerLazySingleton<AppRouter>(() => AppRouter());
  getIt.registerLazySingleton<FirebaseFirestore>(
          () => FirebaseFirestore.instance);
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository()); //Added () => for AuthRepository
}

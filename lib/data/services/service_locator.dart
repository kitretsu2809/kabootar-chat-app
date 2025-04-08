import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasetesting/firebase_options.dart';
import 'package:firebasetesting/logic/cubits/auth/auth_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:firebasetesting/router/app_router.dart';
import '../repositories/auth_repository.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.playIntegrity,
    );
  } catch (e) {
    print('Error during Firebase initialization or App Check activation: $e');
  }
  getIt.registerLazySingleton<AppRouter>(() => AppRouter());
  getIt.registerLazySingleton<FirebaseFirestore>(
          () => FirebaseFirestore.instance);
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository(getIt<FirebaseAuth>())); // Pass FirebaseAuth instance
  getIt.registerFactory<AuthCubit>(() => AuthCubit(authRepository: getIt<AuthRepository>())); // Register AuthCubit
}
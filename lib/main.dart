import 'package:firebasetesting/config/theme/app_theme.dart';
import 'package:firebasetesting/data/services/service_locator.dart';
import 'package:firebasetesting/presentation/screens/auth/login_screen.dart';
import 'package:firebasetesting/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.instance.reset();
  await setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final appRouter = GetIt.instance<AppRouter>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: appRouter.navigatorKey,
      debugShowCheckedModeBanner: false,
    theme: AppTheme.lightTheme,
    title: 'Kabootar',
      home: LoginScreen(),
    );
  }
}
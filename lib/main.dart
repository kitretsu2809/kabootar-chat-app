import 'package:firebasetesting/config/theme/app_theme.dart';
import 'package:firebasetesting/data/services/service_locator.dart';
import 'package:firebasetesting/logic/cubits/auth/auth_cubit.dart';
import 'package:firebasetesting/logic/cubits/auth/auth_state.dart';
import 'package:firebasetesting/presentation/screens/auth/login_screen.dart';
import 'package:firebasetesting/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // GetIt.instance.reset();
  await setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRouter appRouter = GetIt.instance<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => getIt<AuthCubit>(),
      child: MaterialApp(
        navigatorKey: appRouter.navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        title: 'Kabootar',
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state.status == AuthStatus.authenticated) {
              return Scaffold(
                 appBar: AppBar(
                  title: Text('Home',
                  style: TextStyle(color: Colors.black),),
                ),
                body: Text("Hello"),
              );
            } else {
              return const LoginScreen();
            }
          },
        ),
      ),
    );
  }
}

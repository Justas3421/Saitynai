import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:landlords_web_app/backend/auth_repository/auth_repository.dart';
import 'package:landlords_web_app/backend/landlords_repository/landlords_repository.dart';
import 'package:landlords_web_app/constants/nav_bar.dart';
import 'package:landlords_web_app/frontend/auth_screen/cubit/auth_cubit.dart';
import 'package:landlords_web_app/frontend/landlords_screen/cubit/landlords_cubit.dart';
import 'package:landlords_web_app/frontend/login_screen/login_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  final AuthRepository authRepository = AuthRepository();
  final LandlordsRepository landlordsRepository = LandlordsRepository();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => AuthCubit(authRepository)),
    BlocProvider(create: (_) => LandlordsCubit(landlordsRepository)),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
        ],
      ),
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
        useMaterial3: true,
      ),
      home: NavBar(
        child: const LoginPage(),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Page'),
      ),
      body: const Center(
        child: Text('Settings Page Content'),
      ),
    );
  }
}

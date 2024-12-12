import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:landlords_web_app/backend/auth_repository/auth_repository.dart';
import 'package:landlords_web_app/backend/buildings_repository/building_repository.dart';
import 'package:landlords_web_app/backend/flats_repository/flat_repository.dart';
import 'package:landlords_web_app/backend/landlords_repository/landlords_repository.dart';
import 'package:landlords_web_app/constants/nav_bar.dart';
import 'package:landlords_web_app/frontend/auth_screen/cubit/auth_cubit.dart';
import 'package:landlords_web_app/frontend/landlords_screen/cubit/landlords_cubit.dart';
import 'package:landlords_web_app/frontend/landlords_screen/landlords_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  final AuthRepository authRepository = AuthRepository();
  final LandlordsRepository landlordsRepository = LandlordsRepository();
  final BuildingRepository buildingRepository = BuildingRepository();
  final FlatRepository flatRepository = FlatRepository();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>.value(value: authRepository),
        RepositoryProvider<LandlordsRepository>.value(
            value: landlordsRepository),
        RepositoryProvider<BuildingRepository>.value(value: buildingRepository),
        RepositoryProvider<FlatRepository>.value(value: flatRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthCubit(authRepository)),
          BlocProvider(create: (_) => LandlordsCubit(landlordsRepository)),
        ],
        child: const MyApp(),
      ),
    ),
  );
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
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black, // Default AppBar color
          iconTheme:
              IconThemeData(color: Colors.white), // Default back arrow color
        ),
        useMaterial3: true,
      ),
      home: const NavBar(
        child: LandlordsScreen(),
      ),
    );
  }
}

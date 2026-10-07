import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasteway/core/theme/app_theme.dart';
import 'package:tasteway/presentation/bloc/auth/auth_bloc.dart';
import 'package:tasteway/presentation/bloc/places/places_bloc.dart';
import 'package:tasteway/presentation/bloc/recommendations/recommendation_bloc.dart';
import 'package:tasteway/presentation/screens/home/home_screen.dart';
import 'package:tasteway/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:tasteway/presentation/screens/place/place_screen.dart';
import 'package:tasteway/presentation/screens/profile/profile_screen.dart';
import 'package:tasteway/presentation/screens/auth/login_screen.dart';
import 'package:tasteway/services/location_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TasteWayApp());
}

class TasteWayApp extends StatelessWidget {
  const TasteWayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => PlacesBloc()),
        BlocProvider(create: (_) => RecommendationBloc()),
      ],
      child: MaterialApp(
        title: 'TasteWay',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        initialRoute: '/onboarding',
        routes: {
          '/onboarding': (context) => const OnboardingScreen(),
          '/home': (context) => const HomeScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/login': (context) => const LoginScreen(),
        },
      ),
    );
  }
}

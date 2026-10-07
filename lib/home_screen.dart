import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasteway/core/theme/app_theme.dart';
import 'package:tasteway/presentation/bloc/places/places_bloc.dart';
import 'package:tasteway/presentation/screens/home/map_tab.dart';
import 'package:tasteway/presentation/screens/home/list_tab.dart';
import 'package:tasteway/presentation/screens/profile/profile_screen.dart';
import 'package:tasteway/presentation/widgets/common/ai_chat_fab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const MapTab(),
    const ListTab(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // Load places around Saint Petersburg center
    context.read<PlacesBloc>().add(const PlacesLoadRequested(
      latitude: 59.9343,
      longitude: 30.3351,
      radiusKm: 10.0,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs,
      ),
      floatingActionButton: _currentIndex == 0 ? const AIChatFAB() : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            activeIcon: Icon(Icons.map),
            label: 'Карта',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_outlined),
            activeIcon: Icon(Icons.list),
            label: 'Список',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}

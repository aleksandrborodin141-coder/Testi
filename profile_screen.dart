import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasteway/core/theme/app_theme.dart';
import 'package:tasteway/presentation/bloc/auth/auth_bloc.dart';
import 'package:tasteway/presentation/screens/profile/favorites_screen.dart';
import 'package:tasteway/presentation/screens/profile/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            return _buildAuthenticatedProfile(context, state);
          }
          return _buildGuestProfile(context);
        },
      ),
    );
  }

  Widget _buildAuthenticatedProfile(BuildContext context, AuthAuthenticated state) {
    final user = state.user;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: AppTheme.primaryLight,
                backgroundImage: user.avatarUrl != null
                    ? NetworkImage(user.avatarUrl!)
                    : null,
                child: user.avatarUrl == null
                    ? Text(
                        user.name?.substring(0, 1).toUpperCase() ?? 'U',
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      )
                    : null,
              ),
              const SizedBox(height: 16),
              Text(
                user.name ?? 'Пользователь',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 4),
              Text(
                user.email,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStat('0', 'Избранное'),
            _buildStat('0', 'Отзывы'),
            _buildStat('0', 'Посещено'),
          ],
        ),
        const SizedBox(height: 32),
        _buildMenuCard(context, [
          _MenuItem(
            icon: Icons.favorite,
            title: 'Избранное',
            color: AppTheme.accentColor,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FavoritesScreen()),
            ),
          ),
          _MenuItem(
            icon: Icons.history,
            title: 'История',
            onTap: () {},
          ),
          _MenuItem(
            icon: Icons.reviews_outlined,
            title: 'Мои отзывы',
            onTap: () {},
          ),
        ]),
        const SizedBox(height: 16),
        _buildMenuCard(context, [
          _MenuItem(
            icon: Icons.settings_outlined,
            title: 'Настройки',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
          _MenuItem(
            icon: Icons.help_outline,
            title: 'Помощь',
            onTap: () {},
          ),
        ]),
      ],
    );
  }

  Widget _buildGuestProfile(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Center(
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppTheme.primaryLight,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppTheme.primaryColor, width: 3),
                ),
                child: const Icon(
                  Icons.person,
                  size: 48,
                  color: AppTheme.primaryColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Гость',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 4),
              Text(
                'Войдите, чтобы сохранять избранное',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/login'),
                  child: const Text('Войти'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStat('0', 'Избранное'),
            _buildStat('0', 'Отзывы'),
            _buildStat('0', 'Посещено'),
          ],
        ),
        const SizedBox(height: 32),
        _buildMenuCard(context, [
          _MenuItem(
            icon: Icons.settings_outlined,
            title: 'Настройки',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
          _MenuItem(
            icon: Icons.help_outline,
            title: 'Помощь',
            onTap: () {},
          ),
        ]),
      ],
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuCard(BuildContext context, List<_MenuItem> items) {
    return Card(
      child: Column(
        children: items.asMap().entries.map((entry) {
          final item = entry.value;
          final isLast = entry.key == items.length - 1;
          return Column(
            children: [
              ListTile(
                leading: Icon(item.icon, color: item.color ?? AppTheme.primaryColor),
                title: Text(item.title),
                trailing: const Icon(Icons.chevron_right, color: AppTheme.textTertiary),
                onTap: item.onTap,
              ),
              if (!isLast) const Divider(height: 1, indent: 56),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final Color? color;
  final VoidCallback? onTap;

  _MenuItem({required this.icon, required this.title, this.color, this.onTap});
}

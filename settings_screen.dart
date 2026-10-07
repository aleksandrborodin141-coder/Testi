import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasteway/core/theme/app_theme.dart';
import 'package:tasteway/presentation/bloc/auth/auth_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: ListView(
        children: [
          _buildSectionHeader('Аккаунт'),
          _buildListTile(
            icon: Icons.person_outline,
            title: 'Профиль',
            subtitle: 'Изменить имя и фото',
            onTap: () {},
          ),
          _buildListTile(
            icon: Icons.lock_outline,
            title: 'Безопасность',
            subtitle: 'Изменить пароль',
            onTap: () {},
          ),
          const Divider(),
          _buildSectionHeader('Приложение'),
          _buildListTile(
            icon: Icons.notifications_outlined,
            title: 'Уведомления',
            subtitle: 'Push, email уведомления',
            onTap: () {},
          ),
          _buildListTile(
            icon: Icons.language_outlined,
            title: 'Язык',
            subtitle: 'Русский',
            onTap: () {},
          ),
          _buildListTile(
            icon: Icons.dark_mode_outlined,
            title: 'Тема',
            subtitle: 'Системная',
            onTap: () {},
          ),
          _buildListTile(
            icon: Icons.location_on_outlined,
            title: 'Геолокация',
            subtitle: 'Использовать текущее местоположение',
            trailing: Switch(
              value: true,
              onChanged: (value) {},
            ),
          ),
          const Divider(),
          _buildSectionHeader('О приложении'),
          _buildListTile(
            icon: Icons.info_outline,
            title: 'Версия',
            subtitle: 'Beta 0.1',
            onTap: null,
          ),
          _buildListTile(
            icon: Icons.description_outlined,
            title: 'Политика конфиденциальности',
            onTap: () {},
          ),
          _buildListTile(
            icon: Icons.help_outline,
            title: 'Помощь и поддержка',
            onTap: () {},
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthAuthenticated) {
                  return SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        context.read<AuthBloc>().add(AuthLogoutRequested());
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.logout, color: AppTheme.accentColor),
                      label: const Text(
                        'Выйти',
                        style: TextStyle(color: AppTheme.accentColor),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppTheme.accentColor),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppTheme.textTertiary,
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryColor),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: trailing ?? (onTap != null ? const Icon(Icons.chevron_right) : null),
      onTap: onTap,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tasteway/core/theme/app_theme.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppTheme.primaryColor),
          SizedBox(height: 16),
          Text(
            'Загрузка...',
            style: TextStyle(color: AppTheme.textTertiary),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tasteway/core/theme/app_theme.dart';

class PlaceMarker extends StatelessWidget {
  final String? label;
  final bool isSelected;

  const PlaceMarker({
    super.key,
    this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isSelected ? 48 : 36,
      height: isSelected ? 48 : 36,
      decoration: BoxDecoration(
        color: isSelected ? AppTheme.mapPinSelected : AppTheme.mapPinColor,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Icon(
        Icons.restaurant,
        color: Colors.white,
        size: 18,
      ),
    );
  }
}

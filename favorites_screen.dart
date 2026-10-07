import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasteway/core/theme/app_theme.dart';
import 'package:tasteway/presentation/bloc/auth/auth_bloc.dart';
import 'package:tasteway/presentation/bloc/places/places_bloc.dart';
import 'package:tasteway/presentation/screens/place/place_screen.dart';
import 'package:tasteway/presentation/widgets/cards/place_card.dart';
import 'package:tasteway/presentation/widgets/common/loading_indicator.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          if (authState is! AuthAuthenticated) {
            return _buildLoginPrompt(context);
          }

          return BlocBuilder<PlacesBloc, PlacesState>(
            builder: (context, state) {
              if (state is PlacesLoading) {
                return const LoadingIndicator();
              }

              if (state is PlacesLoaded) {
                final favorites = state.places.where((p) => p.isFavorite).toList();

                if (favorites.isEmpty) {
                  return _buildEmptyState();
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final place = favorites[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: PlaceCard(
                        place: place,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PlaceScreen(place: place),
                          ),
                        ),
                        onFavoriteTap: () {
                          context.read<PlacesBloc>().add(
                            PlaceToggleFavorite(placeId: place.id),
                          );
                        },
                      ),
                    );
                  },
                );
              }

              return const LoadingIndicator();
            },
          );
        },
      ),
    );
  }

  Widget _buildLoginPrompt(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 80,
              color: AppTheme.textTertiary.withOpacity(0.5),
            ),
            const SizedBox(height: 24),
            Text(
              'Войдите, чтобы сохранять избранное',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/login'),
              child: const Text('Войти'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 80,
            color: AppTheme.textTertiary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          const Text(
            'Пока ничего не добавлено',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Нажмите на сердечко на карточке заведения',
            style: TextStyle(color: AppTheme.textTertiary),
          ),
        ],
      ),
    );
  }
}

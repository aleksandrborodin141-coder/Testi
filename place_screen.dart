import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasteway/core/theme/app_theme.dart';
import 'package:tasteway/domain/entities/place.dart';
import 'package:tasteway/presentation/bloc/places/places_bloc.dart';
import 'package:tasteway/presentation/bloc/recommendations/recommendation_bloc.dart';
import 'package:tasteway/presentation/widgets/cards/review_card.dart';

class PlaceScreen extends StatelessWidget {
  final Place place;

  const PlaceScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with image
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  place.images.isNotEmpty
                      ? Image.network(
                          place.images.first,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _buildPlaceholder(),
                        )
                      : _buildPlaceholder(),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.4),
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  place.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: place.isFavorite ? AppTheme.accentColor : Colors.white,
                ),
                onPressed: () {
                  context.read<PlacesBloc>().add(PlaceToggleFavorite(placeId: place.id));
                },
              ),
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and rating
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          place.name,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppTheme.successColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star, size: 16, color: AppTheme.successColor),
                            const SizedBox(width: 4),
                            Text(
                              place.rating.toStringAsFixed(1),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Category and price
                  Row(
                    children: [
                      _buildChip(_getCategoryName(place.category)),
                      if (place.cuisine != null) ...[
                        const SizedBox(width: 8),
                        _buildChip(place.cuisine!),
                      ],
                      const SizedBox(width: 8),
                      _buildChip('₽' * (place.priceRange ?? 1)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Address
                  _buildInfoRow(
                    icon: Icons.location_on_outlined,
                    text: place.address ?? 'Адрес не указан',
                  ),
                  if (place.phone != null)
                    _buildInfoRow(
                      icon: Icons.phone_outlined,
                      text: place.phone!,
                    ),
                  if (place.website != null)
                    _buildInfoRow(
                      icon: Icons.language_outlined,
                      text: place.website!,
                    ),
                  const SizedBox(height: 20),
                  // Description
                  if (place.description != null) ...[
                    Text(
                      'О заведении',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      place.description!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                  // Opening hours
                  if (place.openingHours != null) ...[
                    Text(
                      'Часы работы',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    _buildOpeningHours(place.openingHours!),
                    const SizedBox(height: 20),
                  ],
                  // Reviews section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Отзывы (${place.reviewCount})',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Все отзывы'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildMockReviews(),
                  const SizedBox(height: 20),
                  // Similar places (AI)
                  BlocBuilder<RecommendationBloc, RecommendationState>(
                    builder: (context, state) {
                      if (state is RecommendationLoaded && state.recommendations.isNotEmpty) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Похожие места (AI)',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            ...state.recommendations.map((rec) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: RecommendationCard(
                                title: rec['title'] as String,
                                description: rec['description'] as String,
                              ),
                            )).toList(),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.directions),
                  label: const Text('Маршрут'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.bookmark_border),
                  label: const Text('В избранное'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppTheme.divider,
      child: const Center(
        child: Icon(Icons.image, size: 48, color: AppTheme.textTertiary),
      ),
    );
  }

  Widget _buildChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.primaryLight,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppTheme.primaryColor,
        ),
      ),
    );
  }

  Widget _buildInfoRow({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppTheme.textTertiary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOpeningHours(Map<String, dynamic> hours) {
    final days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'];
    final dayNames = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];

    return Column(
      children: List.generate(days.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dayNames[index],
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondary,
                ),
              ),
              Text(
                hours[days[index]] ?? 'Закрыто',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildMockReviews() {
    final mockReviews = [
      {
        'name': 'Анна К.',
        'rating': 5,
        'text': 'Потрясающее место! Обслуживание на высшем уровне, еда просто волшебная. Обязательно вернусь снова.',
        'date': '2 дня назад',
      },
      {
        'name': 'Михаил Д.',
        'rating': 4,
        'text': 'Очень понравилась атмосфера и интерьер. Цены немного выше среднего, но качество того стоит.',
        'date': 'неделю назад',
      },
      {
        'name': 'Елена В.',
        'rating': 5,
        'text': 'Лучшее место для романтического ужина. Вид из окна просто сказочный!',
        'date': '2 недели назад',
      },
    ];

    return Column(
      children: mockReviews.map((review) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: ReviewCard(
          name: review['name'] as String,
          rating: review['rating'] as int,
          text: review['text'] as String,
          date: review['date'] as String,
        ),
      )).toList(),
    );
  }

  String _getCategoryName(String? category) {
    switch (category) {
      case 'restaurant': return 'Ресторан';
      case 'cafe': return 'Кафе';
      case 'bar': return 'Бар';
      default: return 'Заведение';
    }
  }
}

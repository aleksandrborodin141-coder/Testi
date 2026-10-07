import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasteway/core/theme/app_theme.dart';
import 'package:tasteway/domain/entities/place.dart';
import 'package:tasteway/presentation/bloc/places/places_bloc.dart';
import 'package:tasteway/presentation/screens/place/place_screen.dart';
import 'package:tasteway/presentation/widgets/cards/place_card.dart';
import 'package:tasteway/presentation/widgets/common/loading_indicator.dart';

class ListTab extends StatelessWidget {
  const ListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Заведения'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearch(context),
          ),
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () => _showFilters(context),
          ),
        ],
      ),
      body: BlocBuilder<PlacesBloc, PlacesState>(
        builder: (context, state) {
          if (state is PlacesLoading) {
            return const Center(child: LoadingIndicator());
          }

          if (state is PlacesLoaded) {
            return _buildPlaceList(context, state.places);
          }

          if (state is PlacesError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: AppTheme.accentColor),
                  const SizedBox(height: 16),
                  Text(
                    'Не удалось загрузить заведения',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      context.read<PlacesBloc>().add(const PlacesLoadRequested(
                        latitude: 59.9343,
                        longitude: 30.3351,
                      ));
                    },
                    child: const Text('Повторить'),
                  ),
                ],
              ),
            );
          }

          return const Center(child: LoadingIndicator());
        },
      ),
    );
  }

  Widget _buildPlaceList(BuildContext context, List<Place> places) {
    if (places.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: AppTheme.textTertiary),
            const SizedBox(height: 16),
            Text(
              'Ничего не найдено',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Попробуйте изменить параметры поиска',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: places.length,
      itemBuilder: (context, index) {
        final place = places[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: PlaceCard(
            place: place,
            onTap: () => _openPlaceDetail(context, place),
            onFavoriteTap: () {
              context.read<PlacesBloc>().add(PlaceToggleFavorite(placeId: place.id));
            },
          ),
        );
      },
    );
  }

  void _showSearch(BuildContext context) {
    showSearch(
      context: context,
      delegate: PlaceSearchDelegate(),
    );
  }

  void _showFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => const FilterBottomSheet(),
    );
  }

  void _openPlaceDetail(BuildContext context, Place place) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PlaceScreen(place: place)),
    );
  }
}

class PlaceSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, ''),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    context.read<PlacesBloc>().add(PlacesSearchRequested(query: query));
    return BlocBuilder<PlacesBloc, PlacesState>(
      builder: (context, state) {
        if (state is PlacesLoaded) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.places.length,
            itemBuilder: (context, index) {
              return PlaceCard(
                place: state.places[index],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PlaceScreen(place: state.places[index]),
                  ),
                ),
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = ['пицца', 'кофе', 'бар', 'веган', 'грузинская'];
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Популярные запросы',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: suggestions.map((s) => ActionChip(
            label: Text(s),
            onPressed: () {
              query = s;
              showResults(context);
            },
          )).toList(),
        ),
      ],
    );
  }
}

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? _selectedCategory;
  double _minRating = 0;
  int? _maxPrice;

  final List<Map<String, dynamic>> _categories = [
    {'id': 'restaurant', 'name': 'Ресторан', 'icon': Icons.restaurant},
    {'id': 'cafe', 'name': 'Кафе', 'icon': Icons.coffee},
    {'id': 'bar', 'name': 'Бар', 'icon': Icons.local_bar},
  ];

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppTheme.divider,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Фильтры',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 24),
              Text(
                'Категория',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: _categories.map((cat) {
                  final isSelected = _selectedCategory == cat['id'];
                  return FilterChip(
                    selected: isSelected,
                    label: Text(cat['name'] as String),
                    avatar: Icon(cat['icon'] as IconData, size: 18),
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = selected ? cat['id'] as String : null;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              Text(
                'Минимальный рейтинг: ${_minRating.toStringAsFixed(1)}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Slider(
                value: _minRating,
                min: 0,
                max: 5,
                divisions: 10,
                label: _minRating.toStringAsFixed(1),
                onChanged: (value) => setState(() => _minRating = value),
              ),
              const SizedBox(height: 24),
              Text(
                'Максимальная цена',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: [1, 2, 3, 4, 5].map((price) => ChoiceChip(
                  selected: _maxPrice == price,
                  label: Text('₽' * price),
                  onSelected: (selected) {
                    setState(() {
                      _maxPrice = selected ? price : null;
                    });
                  },
                )).toList(),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<PlacesBloc>().add(PlacesFilterRequested(
                      category: _selectedCategory,
                      minRating: _minRating > 0 ? _minRating : null,
                      maxPrice: _maxPrice,
                    ));
                    Navigator.pop(context);
                  },
                  child: const Text('Применить'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

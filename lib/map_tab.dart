import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:tasteway/core/constants/map_constants.dart';
import 'package:tasteway/core/theme/app_theme.dart';
import 'package:tasteway/domain/entities/place.dart';
import 'package:tasteway/presentation/bloc/places/places_bloc.dart';
import 'package:tasteway/presentation/screens/place/place_screen.dart';
import 'package:tasteway/services/location_service.dart';
import 'package:tasteway/services/yandex_map_service.dart';

class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  late YandexMapService _mapService;
  YandexMapController? _mapController;
  final List<MapObject> _mapObjects = [];
  Point? _userLocation;

  @override
  void initState() {
    super.initState();
    _mapService = YandexMapService();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    final position = await LocationService.getCurrentPosition();
    if (position != null && mounted) {
      setState(() {
        _userLocation = Point(
          latitude: position.latitude,
          longitude: position.longitude,
        );
      });
      _mapService.moveToLocation(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    }
  }

  void _onMapCreated(YandexMapController controller) {
    _mapController = controller;
    _mapService.setController(controller);

    // Move to default location (St. Petersburg center)
    _mapService.moveToLocation(
      latitude: MapConstants.defaultLatitude,
      longitude: MapConstants.defaultLongitude,
      zoom: MapConstants.defaultZoom,
    );
  }

  void _updateMarkers(List<Place> places) {
    setState(() {
      _mapObjects.clear();

      for (int i = 0; i < places.length; i++) {
        final place = places[i];
        _mapObjects.add(
          PlacemarkMapObject(
            mapId: MapObjectId('place_$i'),
            point: Point(
              latitude: place.latitude,
              longitude: place.longitude,
            ),
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromAssetImage('assets/images/pin.png'),
                scale: 2.0,
              ),
            ),
            opacity: 1.0,
            onTap: (_, __) => _onPlaceTap(place),
          ),
        );
      }

      // Add user location marker
      if (_userLocation != null) {
        _mapObjects.add(
          PlacemarkMapObject(
            mapId: const MapObjectId('user_location'),
            point: _userLocation!,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromAssetImage('assets/images/user_pin.png'),
                scale: 2.0,
              ),
            ),
          ),
        );
      }
    });
  }

  void _onPlaceTap(Place place) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PlaceBottomSheet(place: place),
    );
  }

  void _onSearchTap() {
    showSearch(
      context: context,
      delegate: MapSearchDelegate(
        onPlaceSelected: (place) {
          _mapService.moveToLocation(
            latitude: place.latitude,
            longitude: place.longitude,
            zoom: 16,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TasteWay'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _onSearchTap,
          ),
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () => _showFilters(context),
          ),
        ],
      ),
      body: BlocConsumer<PlacesBloc, PlacesState>(
        listener: (context, state) {
          if (state is PlacesLoaded) {
            _updateMarkers(state.places);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              YandexMap(
                onMapCreated: _onMapCreated,
                mapObjects: _mapObjects,
                mapType: MapType.map,
                logoAlignment: const MapLogoAlignment(
                  horizontal: HorizontalAlignment.right,
                  vertical: VerticalAlignment.top,
                ),
              ),
              // Loading overlay
              if (state is PlacesLoading)
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),
              // Floating action buttons
              Positioned(
                right: 16,
                bottom: 100,
                child: Column(
                  children: [
                    FloatingActionButton.small(
                      heroTag: 'zoom_in',
                      onPressed: () async {
                        if (_mapController != null) {
                          await _mapController!.moveCamera(
                            CameraUpdate.zoomIn(),
                            animation: const MapAnimation(
                              type: MapAnimationType.smooth,
                              duration: 0.3,
                            ),
                          );
                        }
                      },
                      backgroundColor: AppTheme.surface,
                      child: const Icon(Icons.add, color: AppTheme.textPrimary),
                    ),
                    const SizedBox(height: 8),
                    FloatingActionButton.small(
                      heroTag: 'zoom_out',
                      onPressed: () async {
                        if (_mapController != null) {
                          await _mapController!.moveCamera(
                            CameraUpdate.zoomOut(),
                            animation: const MapAnimation(
                              type: MapAnimationType.smooth,
                              duration: 0.3,
                            ),
                          );
                        }
                      },
                      backgroundColor: AppTheme.surface,
                      child: const Icon(Icons.remove, color: AppTheme.textPrimary),
                    ),
                    const SizedBox(height: 8),
                    FloatingActionButton.small(
                      heroTag: 'location',
                      onPressed: () async {
                        final position = await LocationService.getCurrentPosition();
                        if (position != null && _mapController != null) {
                          await _mapController!.moveCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: Point(
                                  latitude: position.latitude,
                                  longitude: position.longitude,
                                ),
                                zoom: 16,
                              ),
                            ),
                            animation: const MapAnimation(
                              type: MapAnimationType.smooth,
                              duration: 0.5,
                            ),
                          );
                        }
                      },
                      backgroundColor: AppTheme.surface,
                      child: const Icon(Icons.my_location, color: AppTheme.primaryColor),
                    ),
                  ],
                ),
              ),
              // Place count badge
              if (state is PlacesLoaded)
                Positioned(
                  left: 16,
                  top: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.surface,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Text(
                      '${state.places.length} заведений',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
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

  @override
  void dispose() {
    _mapService.dispose();
    _mapController?.dispose();
    super.dispose();
  }
}

class PlaceBottomSheet extends StatelessWidget {
  final Place place;

  const PlaceBottomSheet({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        place.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.successColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star, size: 14, color: AppTheme.successColor),
                          const SizedBox(width: 4),
                          Text(
                            place.rating.toStringAsFixed(1),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.successColor,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  place.address ?? '',
                  style: const TextStyle(color: AppTheme.textSecondary),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildChip(_getCategoryName(place.category)),
                    if (place.cuisine != null) ...[
                      const SizedBox(width: 8),
                      _buildChip(place.cuisine!),
                    ],
                    const Spacer(),
                    Text('₽' * (place.priceRange ?? 1)),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PlaceScreen(place: place),
                        ),
                      );
                    },
                    child: const Text('Подробнее'),
                  ),
                ),
              ],
            ),
          ),
        ],
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

  String _getCategoryName(String? category) {
    switch (category) {
      case 'restaurant': return 'Ресторан';
      case 'cafe': return 'Кафе';
      case 'bar': return 'Бар';
      default: return 'Заведение';
    }
  }
}

class MapSearchDelegate extends SearchDelegate<String> {
  final Function(Place)? onPlaceSelected;

  MapSearchDelegate({this.onPlaceSelected});

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
              final place = state.places[index];
              return ListTile(
                leading: const Icon(Icons.place, color: AppTheme.primaryColor),
                title: Text(place.name),
                subtitle: Text(place.address ?? ''),
                onTap: () {
                  onPlaceSelected?.call(place);
                  close(context, '');
                },
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

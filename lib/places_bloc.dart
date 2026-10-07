import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasteway/data/spb_places.dart';
import 'package:tasteway/domain/entities/place.dart';

part 'places_event.dart';
part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  PlacesBloc() : super(PlacesInitial()) {
    on<PlacesLoadRequested>(_onLoadRequested);
    on<PlacesSearchRequested>(_onSearchRequested);
    on<PlacesFilterRequested>(_onFilterRequested);
    on<PlaceToggleFavorite>(_onToggleFavorite);
  }

  void _onLoadRequested(PlacesLoadRequested event, Emitter<PlacesState> emit) {
    emit(PlacesLoading());
    try {
      final places = getNearbyPlaces(event.latitude, event.longitude, radiusKm: event.radiusKm);
      emit(PlacesLoaded(places: places));
    } catch (e) {
      emit(PlacesError(message: e.toString()));
    }
  }

  void _onSearchRequested(PlacesSearchRequested event, Emitter<PlacesState> emit) {
    emit(PlacesLoading());
    try {
      final places = searchPlaces(event.query);
      emit(PlacesLoaded(places: places));
    } catch (e) {
      emit(PlacesError(message: e.toString()));
    }
  }

  void _onFilterRequested(PlacesFilterRequested event, Emitter<PlacesState> emit) {
    emit(PlacesLoading());
    try {
      final places = filterPlaces(
        category: event.category,
        cuisine: event.cuisine,
        minPrice: event.minPrice,
        maxPrice: event.maxPrice,
        minRating: event.minRating,
      );
      emit(PlacesLoaded(places: places));
    } catch (e) {
      emit(PlacesError(message: e.toString()));
    }
  }

  void _onToggleFavorite(PlaceToggleFavorite event, Emitter<PlacesState> emit) {
    if (state is PlacesLoaded) {
      final currentState = state as PlacesLoaded;
      final updatedPlaces = currentState.places.map((place) {
        if (place.id == event.placeId) {
          return place.copyWith(isFavorite: !place.isFavorite);
        }
        return place;
      }).toList();
      emit(PlacesLoaded(places: updatedPlaces));
    }
  }
}

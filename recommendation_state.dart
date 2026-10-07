part of 'recommendation_bloc.dart';

abstract class RecommendationState extends Equatable {
  const RecommendationState();

  @override
  List<Object?> get props => [];
}

class RecommendationInitial extends RecommendationState {}

class RecommendationLoading extends RecommendationState {}

class RecommendationLoaded extends RecommendationState {
  final List<Map<String, dynamic>> recommendations;

  const RecommendationLoaded({required this.recommendations});

  @override
  List<Object?> get props => [recommendations];
}

class RecommendationError extends RecommendationState {
  final String message;

  const RecommendationError({required this.message});

  @override
  List<Object?> get props => [message];
}

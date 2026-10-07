import 'package:equatable/equatable.dart';

class Recommendation extends Equatable {
  final String id;
  final String title;
  final String description;
  final List<String> placeIds;
  final String? reason;
  final DateTime createdAt;

  const Recommendation({
    required this.id,
    required this.title,
    required this.description,
    required this.placeIds,
    this.reason,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, title, description, placeIds, reason, createdAt];
}

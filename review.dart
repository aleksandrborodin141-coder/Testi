import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final String id;
  final String placeId;
  final String userId;
  final String? userName;
  final String? userAvatar;
  final int rating;
  final String? text;
  final List<String> images;
  final DateTime createdAt;

  const Review({
    required this.id,
    required this.placeId,
    required this.userId,
    this.userName,
    this.userAvatar,
    required this.rating,
    this.text,
    this.images = const [],
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, placeId, userId, rating, text, createdAt];
}

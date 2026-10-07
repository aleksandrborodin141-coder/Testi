import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String? name;
  final String? avatarUrl;
  final Map<String, dynamic> preferences;

  const User({
    required this.id,
    required this.email,
    this.name,
    this.avatarUrl,
    this.preferences = const {},
  });

  @override
  List<Object?> get props => [id, email, name, avatarUrl, preferences];
}

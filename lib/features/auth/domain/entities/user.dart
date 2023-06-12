import 'package:flutter/foundation.dart';

@immutable
class User {
  final String id;
  final String? displayName;
  final String? email;
  final String? photoUrl;
  final bool isAdmin;
  final List<dynamic>? feedback;

  const User({
    required this.id,
    required this.displayName,
    required this.email,
    required this.photoUrl,
    this.isAdmin = false,
    this.feedback,
  });

  @override
  bool operator ==(covariant User other) =>
      identical(this, other) ||
      (id == other.id &&
          displayName == other.displayName &&
          email == other.email &&
          photoUrl == other.photoUrl);

  @override
  int get hashCode => Object.hash(
        id,
        displayName,
        email,
        photoUrl,
      );

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['uid'],
      displayName: json['displayName'],
      email: json['email'],
      photoUrl: json['photoUrl'],
      isAdmin: json['isAdmin'] ?? false,
      feedback: json['feedback'],
    );
  }
}

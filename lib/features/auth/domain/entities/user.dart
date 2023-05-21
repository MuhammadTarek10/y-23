import 'package:flutter/foundation.dart';

@immutable
class User {
  final String id;
  final String? displayName;
  final String? email;

  const User({
    required this.id,
    required this.displayName,
    required this.email,
  });

  @override
  bool operator ==(covariant User other) =>
      identical(this, other) ||
      (id == other.id &&
          displayName == other.displayName &&
          email == other.email);

  @override
  int get hashCode => Object.hash(
        id,
        displayName,
        email,
      );
}

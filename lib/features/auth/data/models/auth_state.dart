import 'package:flutter/foundation.dart';
import 'package:y23/features/auth/data/models/auth_result.dart';

@immutable
class AuthState {
  final AuthResults? result;
  final bool isLoading;
  final String? userId;
  final String? displayName;

  const AuthState({
    required this.result,
    required this.isLoading,
    required this.userId,
    required this.displayName,
  });

  const AuthState.unknown()
      : result = null,
        isLoading = false,
        userId = null,
        displayName = null;

  AuthState copiedWithIsLoading(bool isLoading) => AuthState(
        result: result,
        isLoading: isLoading,
        userId: userId,
        displayName: displayName,
      );

  @override
  bool operator ==(covariant AuthState other) =>
      identical(this, other) ||
      (result == other.result &&
          isLoading == other.isLoading &&
          userId == other.userId);

  @override
  int get hashCode => Object.hash(
        result,
        isLoading,
        userId,
      );
}

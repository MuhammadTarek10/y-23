import 'package:y23/features/auth/data/models/auth_result.dart';

class AuthState {
  final AuthResults? result;
  final bool isLoading;
  final String? userId;
  final String? displayName;
  final String? photoUrl;
  final bool isAdmin;

  AuthState({
    required this.result,
    required this.isLoading,
    required this.userId,
    required this.displayName,
    this.photoUrl,
    this.isAdmin = false,
  });

  AuthState.unknown()
      : result = null,
        isLoading = false,
        userId = null,
        displayName = null,
        photoUrl = null,
        isAdmin = false;

  AuthState copiedWithIsLoading(bool isLoading) => AuthState(
        result: result,
        isLoading: isLoading,
        userId: userId,
        displayName: displayName,
        photoUrl: photoUrl,
      );

  AuthState copiedWithDisplayName(String? displayName) => AuthState(
        result: result,
        isLoading: isLoading,
        userId: userId,
        displayName: displayName,
        photoUrl: photoUrl,
      );

  AuthState copiedWithPhotoUrl(String? photoUrl) => AuthState(
        result: result,
        isLoading: isLoading,
        userId: userId,
        displayName: displayName,
        photoUrl: photoUrl,
      );

  AuthState copiedWithIsAdmin(bool isAdmin) => AuthState(
        result: result,
        isLoading: isLoading,
        userId: userId,
        displayName: displayName,
        photoUrl: photoUrl,
        isAdmin: isAdmin,
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

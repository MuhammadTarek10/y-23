import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/features/auth/data/backend/authenticator.dart';
import 'package:y23/features/auth/data/backend/user_info_storage.dart';
import 'package:y23/features/auth/data/models/auth_result.dart';
import 'package:y23/features/auth/data/models/auth_state.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  final _userInfoStorage = const UserInfoStorage();

  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
        result: AuthResults.success,
        isLoading: false,
        userId: _authenticator.userId,
        displayName: _authenticator.displayName,
      );
    }
  }

  Future<void> logOut() async {
    state = state.copiedWithIsLoading(true);
    await _authenticator.logOut();
    state = const AuthState.unknown();
  }

  Future<void> loginWithGoogle() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;
    final displayName = _authenticator.displayName;
    if (result == AuthResults.success && userId != null) {
      await saveUserInfo(userId: userId);
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
      displayName: displayName,
    );
  }

  Future<void> saveUserInfo({
    required String userId,
  }) =>
      _userInfoStorage.saveUserInfo(
        userId: userId,
        displayName: _authenticator.displayName,
        email: _authenticator.email,
      );
}

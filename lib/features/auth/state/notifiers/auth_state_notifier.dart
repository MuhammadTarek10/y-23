import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/features/auth/data/datasources/backend/authenticator.dart';
import 'package:y23/features/auth/data/datasources/backend/user_info_storage.dart';
import 'package:y23/features/auth/data/models/auth_result.dart';
import 'package:y23/features/auth/data/models/auth_state.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  final _userInfoStorage = const UserInfoStorage();

  AuthStateNotifier() : super(AuthState.unknown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
        result: AuthResults.success,
        isLoading: false,
        userId: _authenticator.userId,
        displayName: _authenticator.displayName,
      );
      setPhoto();
      setName();
      setAdmin();
    }
  }

  Future<void> setName() async {
    final name = await _userInfoStorage.getDisplayName(_authenticator.userId);
    state = state.copiedWithDisplayName(name ?? _authenticator.displayName);
  }

  Future<void> setPhoto() async {
    final url = await _userInfoStorage.getPhotoUrl(_authenticator.userId);
    state = state.copiedWithPhotoUrl(url ?? _authenticator.photoUrl);
  }

  Future<void> setAdmin() async {
    final isAdmin = await _userInfoStorage.isAdmin(_authenticator.userId);
    state = state.copiedWithIsAdmin(isAdmin);
  }

  Future<void> logOut() async {
    state = state.copiedWithIsLoading(true);
    await _authenticator.logOut();
    state = AuthState.unknown();
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

  Future<void> loginWithEmailAndPassword(
    String email,
    String password,
    String? displayName,
  ) async {
    state = state.copiedWithIsLoading(true);
    final result =
        await _authenticator.loginWithEmailAndPassword(email, password);
    final userId = _authenticator.userId;
    if (result == AuthResults.success && userId != null) {
      await saveUserInfo(
        userId: userId,
        displayName: displayName,
      );
    }

    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
      displayName: displayName,
      isAdmin: displayName != null && displayName.contains("-admin-"),
    );
  }

  Future<void> saveUserInfo({
    required String userId,
    String? displayName,
  }) async {
    await _userInfoStorage.saveUserInfo(
      userId: userId,
      displayName: displayName ?? _authenticator.displayName,
      email: _authenticator.email,
      photoUrl: _authenticator.photoUrl,
    );
  }

  Future<void> uploadProfilePicture({
    required String userId,
    required File photo,
  }) async {
    final url = await _userInfoStorage.uploadProfilePicture(
      userId: userId,
      photo: photo,
    );
    state = state.copiedWithPhotoUrl(url ?? _authenticator.photoUrl);
  }
}

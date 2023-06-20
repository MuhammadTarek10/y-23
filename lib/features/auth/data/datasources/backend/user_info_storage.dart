import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:y23/config/utils/firebase_names.dart';
import 'package:y23/features/auth/data/models/user_info_payload.dart';

@immutable
class UserInfoStorage {
  const UserInfoStorage();

  Future<bool> saveUserInfo({
    required String userId,
    required String? displayName,
    required String? email,
    required String? photoUrl,
    bool isAdmin = false,
    List<String>? feedback,
  }) async {
    try {
      final userInfo = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.users)
          .where(FirebaseFieldName.userId, isEqualTo: userId)
          .limit(1)
          .get();

      if (userInfo.docs.isNotEmpty) {
        final name = displayName ?? userInfo.docs.first.get("displayName");
        await userInfo.docs.first.reference.update({
          FirebaseFieldName.displayName: name,
          FirebaseFieldName.email: email ?? "",
        });
        return true;
      }

      final payload = UserInfoPayload(
        userId: userId,
        displayName: displayName,
        email: email,
        photoUrl: photoUrl,
        isAdmin: isAdmin,
        feedback: feedback,
      );
      await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.users,
          )
          .add(payload);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<String?> getDisplayName(String? userId) async {
    try {
      final userInfo = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.users)
          .where(FirebaseFieldName.userId, isEqualTo: userId)
          .limit(1)
          .get();

      if (userInfo.docs.isEmpty) return null;

      return userInfo.docs.first.get(FirebaseFieldName.displayName);
    } catch (_) {
      return null;
    }
  }

  Future<String?> uploadProfilePicture({
    required String userId,
    required File photo,
  }) async {
    try {
      final userInfo = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.users)
          .where(FirebaseFieldName.userId, isEqualTo: userId)
          .limit(1)
          .get();

      if (userInfo.docs.isEmpty) return null;

      final name = photo.path.split("/").last;
      final path = "profile-pics/$userId/$name";

      final ref = FirebaseStorage.instance.ref().child(path);
      await ref.putFile(photo);
      final url = await ref.getDownloadURL();

      await userInfo.docs.first.reference.update({
        FirebaseFieldName.photoUrl: url,
      });

      return url;
    } catch (_) {
      return null;
    }
  }

  Future<String?> getPhotoUrl(String? userId) async {
    try {
      final userInfo = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.users)
          .where(FirebaseFieldName.userId, isEqualTo: userId)
          .limit(1)
          .get();

      if (userInfo.docs.isEmpty) return null;

      return userInfo.docs.first.get(FirebaseFieldName.photoUrl);
    } catch (_) {
      return null;
    }
  }

  Future<bool> isAdmin(String? userId) async {
    try {
      final userInfo = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.users)
          .where(FirebaseFieldName.userId, isEqualTo: userId)
          .limit(1)
          .get();

      if (userInfo.docs.isEmpty) return false;

      return userInfo.docs.first.get(FirebaseFieldName.isAdmin);
    } catch (_) {
      return false;
    }
  }

  Future<bool> sendFeedback(String id, String feedback) async {
    try {
      final userInfo = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.users)
          .where(FirebaseFieldName.userId, isEqualTo: id)
          .limit(1)
          .get();

      if (userInfo.docs.isEmpty) return false;

      final user = userInfo.docs.first;
      final feedbacks = user.get(FirebaseFieldName.feedback) as List<dynamic>;
      feedbacks.add(feedback);
      await user.reference.update({
        FirebaseFieldName.feedback: feedbacks,
      });

      return true;
    } catch (_) {
      return false;
    }
  }
}

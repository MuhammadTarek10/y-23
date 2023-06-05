import 'dart:collection' show MapView;

import 'package:flutter/foundation.dart';
import 'package:y23/config/utils/firebase_names.dart';

@immutable
class UserInfoPayload extends MapView<String, String> {
  UserInfoPayload({
    required String userId,
    required String? displayName,
    required String? email,
    required String? photoUrl,
  }) : super({
          FirebaseFieldName.userId: userId,
          FirebaseFieldName.displayName: displayName ?? '',
          FirebaseFieldName.email: email ?? '',
          FirebaseFieldName.photoUrl: photoUrl ?? '',
        });
}

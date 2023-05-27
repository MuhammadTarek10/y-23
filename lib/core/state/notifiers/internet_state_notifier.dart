import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/core/di.dart';
import 'package:y23/core/network_info.dart';

class InternetStateNotifier extends StateNotifier<bool?> {
  final network = instance<NetworkInfoImp>();

  InternetStateNotifier() : super(null) {
    checkConnection();
  }

  Future<void> checkConnection() async {
    if (await network.isConnected) {
      state = true;
    } else {
      state = false;
    }
  }
}

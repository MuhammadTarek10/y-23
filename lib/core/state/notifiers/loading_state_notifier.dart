import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingStateNotifier extends StateNotifier<bool> {
  LoadingStateNotifier() : super(false);

  void loading() {
    state = true;
  }

  void doneLoading() {
    state = false;
  }
}

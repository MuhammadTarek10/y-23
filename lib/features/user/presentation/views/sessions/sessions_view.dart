import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/core/widgets/lottie.dart';
import 'package:y23/features/user/presentation/views/sessions/state/providers/session_provider.dart';
import 'package:y23/features/user/presentation/views/sessions/widgets/sessions_list_widget.dart';

class SessionsView extends ConsumerWidget {
  const SessionsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessions = ref.watch(sessionProvider);
    return Center(
      child: sessions.when(
        data: (data) {
          if (data == null || data.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LottieEmpty(message: AppStrings.noSessionsFound.tr()),
              ],
            );
          }
          return SessionsListWidget(
            sessions: data,
          );
        },
        error: (error, _) => const LottieError(),
        loading: () => const LottieLoading(),
      ),
    );
  }
}

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
    final sessions = ref.watch(sessionsProvider);
    return sessions == null
        ? const LottieLoading()
        : sessions.isEmpty
            ? LottieEmpty(message: AppStrings.noSessionsFound.tr())
            : SessionsListWidget(
                sessions: sessions,
                onRefresh: () =>
                    ref.read(sessionsProvider.notifier).getSessions(),
              );
  }
}

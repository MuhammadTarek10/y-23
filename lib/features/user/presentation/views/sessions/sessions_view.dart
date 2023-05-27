import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/routes.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/core/widgets/lottie.dart';
import 'package:y23/features/user/presentation/views/sessions/state/providers/session_provider.dart';

class SessionsView extends ConsumerWidget {
  const SessionsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessions = ref.watch(sessionsProvider);
    if (sessions != null) {
      sessions.sort((a, b) => a.title.compareTo(b.title));
    }
    return sessions == null
        ? const LottieLoading()
        : sessions.isEmpty
            ? LottieEmpty(message: AppStrings.noSessionsFound.tr())
            : GridView.builder(
                itemCount: sessions.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                ),
                itemBuilder: (context, index) {
                  final session = sessions[index];
                  return Card(
                    child: InkWell(
                      onTap: () => Navigator.of(context).pushNamed(
                        Routes.sessionRoute,
                        arguments: session,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            session.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
  }
}

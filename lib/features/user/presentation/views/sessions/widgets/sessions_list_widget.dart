import 'package:flutter/material.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/features/user/domain/entities/sessions/session.dart';
import 'package:y23/features/user/presentation/views/sessions/widgets/session_widget.dart';

class SessionsListWidget extends StatelessWidget {
  const SessionsListWidget({
    super.key,
    required this.sessions,
  });

  final List<Session> sessions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSizes.s40),
      child: ListView.builder(
        itemCount: sessions.length,
        itemBuilder: (context, index) =>
            SessionWidget(session: sessions[index]),
      ),
    );
  }
}

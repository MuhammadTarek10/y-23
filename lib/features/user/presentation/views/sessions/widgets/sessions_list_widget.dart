import 'package:flutter/material.dart';
import 'package:y23/features/user/domain/entities/sessions/session.dart';
import 'package:y23/features/user/presentation/views/sessions/widgets/session_widget.dart';

class SessionsListWidget extends StatelessWidget {
  const SessionsListWidget({
    super.key,
    required this.sessions,
    required this.onRefresh,
  });

  final List<Session> sessions;
  final Function onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => onRefresh(),
      child: ListView.builder(
        itemCount: sessions.length,
        itemBuilder: (context, index) =>
            SessionWidget(session: sessions[index]),
      ),
    );
  }
}

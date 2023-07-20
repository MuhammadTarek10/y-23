import 'package:flutter/material.dart';
import 'package:y23/config/routes.dart';

class AttendanceView extends StatelessWidget {
  const AttendanceView({
    super.key,
    required this.attendance,
  });

  final Map<String, dynamic> attendance;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.onSecondary,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(attendance.keys.first),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(
            context,
            Routes.registerAttendanceRoute,
            arguments: attendance.keys.first,
          ),
          backgroundColor: Colors.green, // ),
          child: const Icon(Icons.add),
        ),
        body: ListView.separated(
          itemCount: attendance[attendance.keys.first].length,
          separatorBuilder: (context, index) => const Divider(
            color: Colors.white,
            thickness: 0.2,
          ),
          itemBuilder: (context, index) {
            final item = attendance[attendance.keys.first][index];
            return ListTile(
              title: Text(item),
            );
          },
        ),
      ),
    );
  }
}

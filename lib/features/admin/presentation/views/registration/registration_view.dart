import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/routes.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/features/admin/presentation/views/registration/state/providers/registration_provider.dart';

class RegistrationView extends StatelessWidget {
  const RegistrationView({super.key});

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
          title: Text(AppStrings.registration.tr()),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(
            context,
            Routes.registerAttendanceRoute,
          ),
          child: const Icon(Icons.add),
        ),
        body: Consumer(
          builder: (context, ref, child) {
            final attendance = ref.watch(attendanceProvider);
            return attendance.when(
              data: (attendance) {
                return ListView.builder(
                  itemCount: attendance.length,
                  itemBuilder: (context, index) {
                    final item = attendance[index].attendance;
                    return _buildItem(context, item);
                  },
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) => Center(
                child: Text(error.toString()),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, Map<String, dynamic>? item) {
    if (item != null) {
      return ListTile(
        title: Text(item.keys.first),
        trailing: Text(item[item.keys.first].length.toString()),
        onTap: () => Navigator.pushNamed(
          context,
          Routes.attendanceRoute,
          arguments: item,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

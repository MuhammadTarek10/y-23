import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/features/user/presentation/views/tasks/state/providers/task_submissions_provider.dart';

class MyTasksView extends ConsumerWidget {
  const MyTasksView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final submissions = ref.watch(taskSubmissionsProvider);
    return Scaffold(
      appBar: AppBar(),
    );
  }
}

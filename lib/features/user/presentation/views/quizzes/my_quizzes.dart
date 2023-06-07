import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/features/user/presentation/views/quizzes/state/providers/quiz_result_provider.dart';

class MyQuizzesView extends ConsumerWidget {
  const MyQuizzesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(quizResultProvider);
    log(results.toString());
    return Scaffold(
      appBar: AppBar(),
    );
  }
}

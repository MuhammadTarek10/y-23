import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:y23/config/utils/assets.dart';

class LottieLoading extends StatelessWidget {
  const LottieLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(AppAssets.loading);
  }
}

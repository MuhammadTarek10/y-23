import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:y23/config/utils/assets.dart';
import 'package:y23/config/utils/strings.dart';

class LottieLoading extends StatelessWidget {
  const LottieLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(AppAssets.loading);
  }
}

class LottieEmpty extends StatelessWidget {
  const LottieEmpty({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset(
          AppAssets.empty,
          repeat: true,
          reverse: true,
        ),
        Text(
          message,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }
}

class LottieNoInternet extends StatelessWidget {
  const LottieNoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Lottie.asset(
              AppAssets.noInternet,
              repeat: true,
              reverse: true,
            ),
          ),
          Text(
            AppStrings.noInternet.tr(),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
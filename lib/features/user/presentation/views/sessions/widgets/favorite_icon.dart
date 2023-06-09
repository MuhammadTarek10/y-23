import 'package:flutter/material.dart';
import 'package:y23/config/extensions.dart';
import 'package:y23/config/utils/colors.dart';

class FavoriteIcon extends StatelessWidget {
  const FavoriteIcon({
    super.key,
    required this.animationController,
    required this.onPressed,
  });

  final AnimationController? animationController;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: (context.width / 1.2) - 24.0 - 35,
      right: 35,
      child: ScaleTransition(
        alignment: Alignment.center,
        scale: CurvedAnimation(
            parent: animationController!, curve: Curves.fastOutSlowIn),
        child: Card(
          color: Theme.of(context).colorScheme.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
          elevation: 10.0,
          child: SizedBox(
            width: 60,
            height: 60,
            child: InkWell(
              onTap: onPressed,
              child: const Center(
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.fakeWhite,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

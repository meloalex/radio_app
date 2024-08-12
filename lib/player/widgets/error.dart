import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RadioPlayerError extends StatelessWidget {
  const RadioPlayerError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Error\n\n coudn't load the stream",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 400,
                height: 400,
                child: RiveAnimation.asset(
                  "assets/animations/error.riv",
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

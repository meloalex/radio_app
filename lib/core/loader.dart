import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class GenericLoader extends StatelessWidget {
  const GenericLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 235,
        height: 235,
        child: RiveAnimation.asset("assets/animations/loader.riv"),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TopBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const TopBackButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40.0,
      left: 10.0,
      child: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }
}

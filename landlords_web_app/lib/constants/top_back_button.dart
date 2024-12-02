import 'package:flutter/material.dart';

class TopBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const TopBackButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40.0,
      left: 10.0,
      child: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }
}

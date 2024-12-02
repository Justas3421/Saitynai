import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final bool isValid;
  final double opacity;
  const GradientButton(
      {super.key,
      this.onPressed,
      required this.label,
      this.isValid = true,
      this.opacity = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isValid
              ? [
                  Colors.purple.withOpacity(opacity),
                  Colors.blue.withOpacity(opacity)
                ]
              : [
                  Colors.grey.withOpacity(opacity),
                  Colors.grey.withOpacity(opacity)
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: InkWell(
        onTap: isValid ? onPressed : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: Center(
            child: AutoSizeText(
              label,
              maxLines: 1,
              minFontSize: 11,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class LetterCard extends StatelessWidget {
  const LetterCard({
    super.key,
    required this.letter,
    required this.emoji,
    required this.color,
    this.onTap,
  });

  final String letter;
  final String emoji;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                letter,
                style: const TextStyle(
                  fontSize: 44,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(emoji, style: const TextStyle(fontSize: 34)),
            ],
          ),
        ),
      ),
    );
  }
}

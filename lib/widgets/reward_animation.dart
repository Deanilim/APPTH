import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class RewardAnimation extends StatefulWidget {
  const RewardAnimation({super.key, required this.play});

  final bool play;

  @override
  State<RewardAnimation> createState() => _RewardAnimationState();
}

class _RewardAnimationState extends State<RewardAnimation> {
  late final ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void didUpdateWidget(covariant RewardAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.play && widget.play) {
      _controller.play();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        confettiController: _controller,
        shouldLoop: false,
        blastDirectionality: BlastDirectionality.explosive,
        colors: const [
          Color(0xFF6C63FF),
          Color(0xFFFF6584),
          Color(0xFF43D98E),
          Color(0xFFFFD93D),
        ],
      ),
    );
  }
}

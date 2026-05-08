import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../models/lesson_item.dart';
import '../services/audio_service.dart';
import '../services/firebase_service.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/letter_card.dart';
import 'colores_screen.dart';
import 'home_screen.dart';
import 'numeros_screen.dart';
import 'vocales_screen.dart';

class AbecedarioScreen extends StatefulWidget {
  const AbecedarioScreen({super.key});

  @override
  State<AbecedarioScreen> createState() => _AbecedarioScreenState();
}

class _AbecedarioScreenState extends State<AbecedarioScreen> {
  final AudioService _audio = AudioService();
  final Set<String> _vistos = {};
  String? _ultimoTocado;

  static const _letters = <LessonItem>[
    LessonItem(label: 'A', emoji: '🍎', description: 'A de Manzana'),
    LessonItem(label: 'B', emoji: '🐝', description: 'B de Abeja'),
    LessonItem(label: 'C', emoji: '🐱', description: 'C de Gato'),
    LessonItem(label: 'D', emoji: '🐶', description: 'D de Perro'),
    LessonItem(label: 'E', emoji: '⭐', description: 'E de Estrella'),
    LessonItem(label: 'F', emoji: '🌸', description: 'F de Flor'),
    LessonItem(label: 'G', emoji: '🐸', description: 'G de Rana'),
    LessonItem(label: 'H', emoji: '🏠', description: 'H de Hogar'),
    LessonItem(label: 'I', emoji: '🦋', description: 'I de Insecto'),
    LessonItem(label: 'J', emoji: '🦁', description: 'J de Jaguar'),
    LessonItem(label: 'K', emoji: '🥝', description: 'K de Kiwi'),
    LessonItem(label: 'L', emoji: '🍋', description: 'L de Limón'),
    LessonItem(label: 'M', emoji: '🌙', description: 'M de Luna'),
    LessonItem(label: 'N', emoji: '⛵', description: 'N de Nave'),
    LessonItem(label: 'Ñ', emoji: '🍩', description: 'Ñ de Ñoño'),
    LessonItem(label: 'O', emoji: '🐙', description: 'O de Pulpo'),
    LessonItem(label: 'P', emoji: '🐧', description: 'P de Pingüino'),
    LessonItem(label: 'Q', emoji: '🧀', description: 'Q de Queso'),
    LessonItem(label: 'R', emoji: '🌹', description: 'R de Rosa'),
    LessonItem(label: 'S', emoji: '🐍', description: 'S de Serpiente'),
    LessonItem(label: 'T', emoji: '🐢', description: 'T de Tortuga'),
    LessonItem(label: 'U', emoji: '🍇', description: 'U de Uvas'),
    LessonItem(label: 'V', emoji: '🎻', description: 'V de Violín'),
    LessonItem(label: 'W', emoji: '🍉', description: 'W de Sandía'),
    LessonItem(label: 'X', emoji: '🎅', description: 'X de X-Más'),
    LessonItem(label: 'Y', emoji: '🌻', description: 'Y de Yema'),
    LessonItem(label: 'Z', emoji: '🦓', description: 'Z de Zebra'),
  ];

  @override
  void dispose() {
    _audio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🔤 El Abecedario')),
      bottomNavigationBar: BottomNav(
        currentIndex: 1,
        onTap: (index) => _goTo(context, index),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Text(
            'Letras vistas: ${_vistos.length}/${_letters.length}',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _letters.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                final item = _letters[index];
                return AnimatedScale(
                  duration: const Duration(milliseconds: 220),
                  scale: _ultimoTocado == item.label ? 1.08 : 1.0,
                  child: LetterCard(
                    letter: item.label,
                    emoji: item.emoji,
                    color: const Color(0xFF6C63FF),
                    onTap: () => _tapLetter(item),
                  )
                      .animate(target: _ultimoTocado == item.label ? 1 : 0)
                      .shake(duration: 280.ms),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _tapLetter(LessonItem item) async {
    setState(() {
      _ultimoTocado = item.label;
      _vistos.add(item.label);
    });

    await _audio.speak(item.label);

    final firebase = context.read<FirebaseService>();
    if (firebase.userId != null) {
      await firebase.saveProgress(firebase.userId!, 'abecedario', _vistos.length * 4);
    }

    if (!mounted) return;
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(item.label, style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold)),
              Text(item.emoji, style: const TextStyle(fontSize: 56)),
              const SizedBox(height: 8),
              Text(item.description, style: const TextStyle(fontSize: 28), textAlign: TextAlign.center),
            ],
          ),
        );
      },
    );

    if (mounted) {
      setState(() => _ultimoTocado = null);
    }
  }

  void _goTo(BuildContext context, int index) {
    final pages = const [
      HomeScreen(),
      AbecedarioScreen(),
      VocalesScreen(),
      NumerosScreen(),
      ColoresScreen(),
    ];
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => pages[index]));
  }
}

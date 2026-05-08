import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/audio_service.dart';
import '../services/firebase_service.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/reward_animation.dart';
import 'abecedario_screen.dart';
import 'colores_screen.dart';
import 'home_screen.dart';
import 'numeros_screen.dart';

class VocalesScreen extends StatefulWidget {
  const VocalesScreen({super.key});

  @override
  State<VocalesScreen> createState() => _VocalesScreenState();
}

class _VocalesScreenState extends State<VocalesScreen> {
  final AudioService _audio = AudioService();
  bool _confeti = false;

  final List<(String, Color, String)> _vocales = const [
    ('A', Color(0xFFE53935), '🍎'),
    ('E', Color(0xFF1E88E5), '⭐'),
    ('I', Color(0xFFFDD835), '🌟'),
    ('O', Color(0xFF43A047), '🍊'),
    ('U', Color(0xFF8E24AA), '🍇'),
  ];

  late String _pregunta;
  late List<String> _opciones;

  @override
  void initState() {
    super.initState();
    _crearPregunta();
  }

  @override
  void dispose() {
    _audio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🗣️ Las Vocales')),
      bottomNavigationBar: BottomNav(
        currentIndex: 2,
        onTap: (index) => _goTo(context, index),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Toca cada vocal para escucharla',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ..._vocales.map((item) {
                final (vocal, color, emoji) = item;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: SizedBox(
                    height: 120,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: color),
                      onPressed: () => _tapVocal(vocal),
                      child: Text(
                        '$vocal   $emoji',
                        style: const TextStyle(fontSize: 54, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 24),
              const Text(
                '¿Cuál es esta vocal?',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                _pregunta,
                style: const TextStyle(fontSize: 70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: _opciones.map((opcion) {
                  return SizedBox(
                    width: 110,
                    height: 90,
                    child: ElevatedButton(
                      onPressed: () => _responder(opcion),
                      child: Text(opcion, style: const TextStyle(fontSize: 38)),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          RewardAnimation(play: _confeti),
        ],
      ),
    );
  }

  Future<void> _tapVocal(String vocal) async {
    await _audio.speak(vocal);
    setState(() => _confeti = !_confeti);
  }

  Future<void> _responder(String opcion) async {
    final esCorrecta = opcion == _pregunta;
    final mensaje = esCorrecta ? '¡Muy bien! ⭐' : '¡Intentemos otra vez!';
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mensaje)));

    if (esCorrecta) {
      final firebase = context.read<FirebaseService>();
      if (firebase.userId != null) {
        await firebase.saveCompletedLesson(firebase.userId!, 'vocales');
      }
      setState(() => _confeti = !_confeti);
      _crearPregunta();
    }
  }

  void _crearPregunta() {
    final random = Random();
    _pregunta = _vocales[random.nextInt(_vocales.length)].$1;

    final opciones = {_pregunta};
    while (opciones.length < 3) {
      opciones.add(_vocales[random.nextInt(_vocales.length)].$1);
    }

    _opciones = opciones.toList()..shuffle();
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

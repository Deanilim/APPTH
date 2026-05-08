import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/audio_service.dart';
import '../services/firebase_service.dart';
import '../widgets/bottom_nav.dart';
import 'abecedario_screen.dart';
import 'home_screen.dart';
import 'numeros_screen.dart';
import 'vocales_screen.dart';

class ColoresScreen extends StatefulWidget {
  const ColoresScreen({super.key});

  @override
  State<ColoresScreen> createState() => _ColoresScreenState();
}

class _ColoresScreenState extends State<ColoresScreen> {
  final AudioService _audio = AudioService();
  Color? _splashColor;

  final List<(String, Color)> _colores = const [
    ('Rojo', Colors.red),
    ('Azul', Colors.blue),
    ('Amarillo', Colors.yellow),
    ('Verde', Colors.green),
    ('Naranja', Colors.orange),
    ('Morado', Colors.purple),
    ('Rosa', Colors.pink),
    ('Negro', Colors.black),
  ];

  late String _emojiPregunta;
  late String _respuestaColor;
  late List<String> _opciones;

  @override
  void initState() {
    super.initState();
    _nuevaPregunta();
  }

  @override
  void dispose() {
    _audio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🎨 Los Colores')),
      bottomNavigationBar: BottomNav(
        currentIndex: 4,
        onTap: (index) => _goTo(context, index),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: _colores.map((item) {
                  final (nombre, color) = item;
                  return SizedBox(
                    width: 170,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () => _tapColor(nombre, color),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Container(
                                width: 86,
                                height: 86,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(nombre, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              const Text(
                '¿De qué color es esto?',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(_emojiPregunta, style: const TextStyle(fontSize: 70), textAlign: TextAlign.center),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: _opciones.map((opcion) {
                  return ElevatedButton(
                    onPressed: () => _responderJuego(opcion),
                    child: Text(opcion, style: const TextStyle(fontSize: 24)),
                  );
                }).toList(),
              ),
            ],
          ),
          IgnorePointer(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: _splashColor == null ? 0 : 0.18,
              child: Container(color: _splashColor ?? Colors.transparent),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _tapColor(String nombre, Color color) async {
    await _audio.speak(nombre);
    setState(() => _splashColor = color);
    await Future<void>.delayed(const Duration(milliseconds: 450));
    if (mounted) {
      setState(() => _splashColor = null);
    }
  }

  Future<void> _responderJuego(String opcion) async {
    final correcta = opcion == _respuestaColor;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(correcta ? '¡Correcto! 🌈' : 'Casi, intenta de nuevo')),
    );

    if (correcta) {
      final firebase = context.read<FirebaseService>();
      if (firebase.userId != null) {
        await firebase.saveCompletedLesson(firebase.userId!, 'colores');
      }
      _nuevaPregunta();
    }
  }

  void _nuevaPregunta() {
    final random = Random();
    const preguntas = <(String, String)>[
      ('🍌', 'Amarillo'),
      ('🍓', 'Rojo'),
      ('🌿', 'Verde'),
      ('🫐', 'Azul'),
      ('🖤', 'Negro'),
    ];

    final elegida = preguntas[random.nextInt(preguntas.length)];
    _emojiPregunta = elegida.$1;
    _respuestaColor = elegida.$2;

    final opciones = {_respuestaColor};
    while (opciones.length < 4) {
      opciones.add(_colores[random.nextInt(_colores.length)].$1);
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

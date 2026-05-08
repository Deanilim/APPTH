import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/audio_service.dart';
import '../services/firebase_service.dart';
import '../widgets/bottom_nav.dart';
import 'abecedario_screen.dart';
import 'colores_screen.dart';
import 'home_screen.dart';
import 'vocales_screen.dart';

class NumerosScreen extends StatefulWidget {
  const NumerosScreen({super.key});

  @override
  State<NumerosScreen> createState() => _NumerosScreenState();
}

class _NumerosScreenState extends State<NumerosScreen> {
  final AudioService _audio = AudioService();
  final Set<int> _vistos = {};

  static const List<String> _nombres = [
    'uno',
    'dos',
    'tres',
    'cuatro',
    'cinco',
    'seis',
    'siete',
    'ocho',
    'nueve',
    'diez',
  ];

  @override
  void dispose() {
    _audio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🔢 Los Números')),
      bottomNavigationBar: BottomNav(
        currentIndex: 3,
        onTap: (index) => _goTo(context, index),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 10,
        itemBuilder: (context, index) {
          final number = index + 1;
          final nombre = _nombres[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Card(
              color: const Color(0xFF66BB6A),
              child: InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () => _tapNumero(number, nombre),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                  child: Row(
                    children: [
                      Text('$number', style: const TextStyle(fontSize: 56, color: Colors.white, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 18),
                      Expanded(
                        child: Text(
                          nombre,
                          style: const TextStyle(fontSize: 34, color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text('🍎' * number, style: const TextStyle(fontSize: 24)),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _tapNumero(int numero, String nombre) async {
    _vistos.add(numero);
    await _audio.speak('$numero, $nombre');

    final firebase = context.read<FirebaseService>();
    if (firebase.userId != null) {
      await firebase.saveProgress(firebase.userId!, 'numeros', _vistos.length * 10);
    }

    if (!mounted) return;
    await showDialog<void>(
      context: context,
      builder: (context) {
        int visibles = 0;
        Timer? timer;
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            timer ??= Timer.periodic(const Duration(milliseconds: 250), (t) {
              if (visibles >= numero) {
                t.cancel();
                return;
              }
              setStateDialog(() => visibles++);
            });

            return AlertDialog(
              title: Text('Número $numero'),
              content: Text('🍎' * visibles, style: const TextStyle(fontSize: 48)),
            );
          },
        );
      },
    );
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

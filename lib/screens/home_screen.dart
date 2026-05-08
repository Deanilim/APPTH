import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../widgets/bottom_nav.dart';
import 'abecedario_screen.dart';
import 'colores_screen.dart';
import 'numeros_screen.dart';
import 'vocales_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('🔤', 'Abecedario', const Color(0xFF4A90E2), const AbecedarioScreen()),
      ('🗣️', 'Vocales', const Color(0xFFFFA726), const VocalesScreen()),
      ('🔢', 'Números', const Color(0xFF66BB6A), const NumerosScreen()),
      ('🎨', 'Colores', const Color(0xFF9C6ADE), const ColoresScreen()),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('APPTH')),
      bottomNavigationBar: BottomNav(
        currentIndex: 0,
        onTap: (index) => _goTo(context, index),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('🦄', style: TextStyle(fontSize: 64))
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .scale(duration: 1000.ms, begin: const Offset(1, 1), end: const Offset(1.1, 1.1)),
            const SizedBox(height: 8),
            const Text(
              '¡Vamos a Aprender! 🌟',
              style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final (emoji, title, color, destination) = items[index];
                  return Card(
                    color: color,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => destination),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(emoji, style: const TextStyle(fontSize: 52)),
                          const SizedBox(height: 10),
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                      .animate(delay: (120 * index).ms)
                      .fadeIn(duration: 420.ms)
                      .slide(begin: const Offset(0, 0.2), end: Offset.zero, duration: 420.ms);
                },
              ),
            ),
          ],
        ),
      ),
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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => pages[index]),
    );
  }
}

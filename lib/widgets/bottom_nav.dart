import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      height: 84,
      onDestinationSelected: onTap,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home, size: 32), label: 'Inicio'),
        NavigationDestination(icon: Icon(Icons.sort_by_alpha, size: 32), label: 'Abc'),
        NavigationDestination(icon: Icon(Icons.record_voice_over, size: 32), label: 'Vocales'),
        NavigationDestination(icon: Icon(Icons.pin, size: 32), label: 'Números'),
        NavigationDestination(icon: Icon(Icons.palette, size: 32), label: 'Colores'),
      ],
    );
  }
}

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

class AudioService {
  AudioService() {
    _tts.setLanguage('es-ES');
    _tts.setSpeechRate(0.45);
    _tts.setPitch(1.0);
  }

  final FlutterTts _tts = FlutterTts();
  final AudioPlayer _player = AudioPlayer();

  Future<void> speak(String text) async {
    try {
      await _tts.stop();
      await _tts.speak(text);
    } catch (e) {
      debugPrint('Error al pronunciar texto: $e');
    }
  }

  Future<void> playAsset(String path) async {
    try {
      await _player.play(AssetSource(path));
    } catch (e) {
      debugPrint('Error al reproducir audio: $e');
    }
  }

  Future<void> stopAll() async {
    try {
      await _tts.stop();
      await _player.stop();
    } catch (e) {
      debugPrint('Error al detener audio: $e');
    }
  }

  Future<void> dispose() async {
    await stopAll();
    await _player.dispose();
  }
}

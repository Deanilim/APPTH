import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _userId;
  bool _isLoading = false;
  Map<String, dynamic> _progress = {};

  String? get userId => _userId;
  bool get isLoading => _isLoading;
  Map<String, dynamic> get progress => _progress;

  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();
    try {
      await signInAnonymously();
      if (_userId != null) {
        _progress = await getProgress(_userId!);
      }
    } catch (e) {
      debugPrint('Error al inicializar FirebaseService: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<User?> signInAnonymously() async {
    try {
      final credential = await _auth.signInAnonymously();
      _userId = credential.user?.uid;
      notifyListeners();
      return credential.user;
    } catch (e) {
      debugPrint('Error al iniciar sesión anónima: $e');
      return null;
    }
  }

  Future<void> saveProgress(String userId, String section, int score) async {
    try {
      final stars = _calculateStars(score);
      final data = {
        'score': score,
        'completedAt': FieldValue.serverTimestamp(),
        'stars': stars,
      };

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('progress')
          .doc(section)
          .set(data, SetOptions(merge: true));

      _progress[section] = {'score': score, 'stars': stars};
      notifyListeners();
    } catch (e) {
      debugPrint('Error al guardar progreso: $e');
    }
  }

  Future<Map<String, dynamic>> getProgress(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('progress')
          .get();

      return {
        for (final doc in snapshot.docs) doc.id: doc.data(),
      };
    } catch (e) {
      debugPrint('Error al obtener progreso: $e');
      return {};
    }
  }

  Future<void> saveCompletedLesson(String userId, String lesson) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('progress')
          .doc(lesson)
          .set({
        'score': 100,
        'completedAt': FieldValue.serverTimestamp(),
        'stars': 3,
      }, SetOptions(merge: true));

      _progress[lesson] = {'score': 100, 'stars': 3};
      notifyListeners();
    } catch (e) {
      debugPrint('Error al marcar lección completada: $e');
    }
  }

  int _calculateStars(int score) {
    if (score >= 90) return 3;
    if (score >= 60) return 2;
    return 1;
  }
}

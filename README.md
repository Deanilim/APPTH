# APPTH 🌟

APPTH es una aplicación educativa en Flutter para enseñar español a niños con autismo y TDAH de manera visual, divertida y simple.

## Propósito

La app está diseñada para reducir ruido visual, usar botones grandes, colores contrastados y reforzar el aprendizaje con animaciones suaves, voz en español y recompensas.

## Instalación paso a paso

1. Instala Flutter (canal estable) y verifica con:
   ```bash
   flutter doctor
   ```
2. Clona el repositorio:
   ```bash
   git clone https://github.com/Deanilim/APPTH.git
   cd APPTH
   ```
3. Instala dependencias:
   ```bash
   flutter pub get
   ```
4. Ejecuta la app:
   ```bash
   flutter run
   ```

## Configuración de Firebase (detallada)

1. Ve a [Firebase Console](https://console.firebase.google.com/) y crea el proyecto **APPTH**.
2. Activa **Authentication > Sign-in method > Anonymous**.
3. Activa **Firestore Database** en modo de desarrollo.
4. Registra app Android:
   - Package sugerido: `com.example.appth`
   - Descarga `google-services.json` y colócalo en `android/app/`.
5. Registra app iOS:
   - Bundle ID sugerido: `com.example.appth`
   - Descarga `GoogleService-Info.plist` y colócalo en `ios/Runner/`.
6. Abre `lib/firebase_options.dart` y reemplaza placeholders:
   - `YOUR_API_KEY`
   - `YOUR_APP_ID`
   - `YOUR_MESSAGING_SENDER_ID`
   - `YOUR_PROJECT_ID`
7. Ejecuta de nuevo:
   ```bash
   flutter run
   ```

## Características Fase 1

- Splash animado de 2 segundos
- Inicio con tarjetas grandes y navegación inferior por íconos
- Módulo de Abecedario (A-Z + Ñ) con emoji, voz y popup
- Módulo de Vocales con confeti y mini ejercicio visual
- Módulo de Números del 1 al 10 con representación visual
- Módulo de Colores con mini juego
- Progreso guardado en Firebase Firestore por sección

## Tecnologías usadas

- Flutter
- Firebase Core + Auth + Firestore
- Provider
- Flutter Animate
- Flutter TTS
- Audioplayers
- Confetti
- Google Fonts

## Fase 2 (pendiente)

- Objetos del hogar
- Cocina
- Baño

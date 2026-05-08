# 🌟 APPTH — App Educativa para Niños con Autismo y TDAH

> Aprende español de forma visual, divertida y sencilla 🎨🔤🔢

---

## 📖 ¿Qué es APPTH?

APPTH es una aplicación móvil hecha con **Flutter** que enseña español básico a niños con autismo y TDAH. Usa colores brillantes, animaciones suaves, voz en español y recompensas visuales para hacer el aprendizaje entretenido y accesible.

### 🎯 Módulos disponibles (Fase 1)
| Módulo | Contenido |
|--------|-----------|
| 🔤 Abecedario | Letras A-Z + Ñ con emojis y pronunciación |
| 🗣️ Vocales | A, E, I, O, U con colores y ejercicios |
| 🔢 Números | Del 1 al 10 con representación visual |
| 🎨 Colores | 8 colores básicos con mini juego |

---

## 🖥️ Requisitos del sistema

Antes de instalar, asegúrate de tener lo siguiente:

| Herramienta | Versión recomendada | Enlace de descarga |
|-------------|--------------------|--------------------|
| Flutter SDK | **3.19.x o superior** (canal stable) | [flutter.dev](https://flutter.dev/docs/get-started/install) |
| Dart SDK | Incluido con Flutter (**3.3.x+**) | — |
| Android Studio | **Hedgehog (2023.1.1)** o superior | [developer.android.com](https://developer.android.com/studio) |
| Xcode (solo iOS/Mac) | **15.x** o superior | Mac App Store |
| Git | **2.x** o superior | [git-scm.com](https://git-scm.com) |
| VS Code (opcional) | Cualquier versión reciente | [code.visualstudio.com](https://code.visualstudio.com) |

---

## 📦 Dependencias del proyecto

Estas son las librerías que usa la app (ya están en `pubspec.yaml`):

| Paquete | Versión | ¿Para qué sirve? |
|---------|---------|-----------------|
| `firebase_core` | ^2.24.2 | Inicializar Firebase |
| `firebase_auth` | ^4.15.3 | Login anónimo para niños |
| `cloud_firestore` | ^4.13.6 | Guardar el progreso |
| `flutter_animate` | ^4.3.0 | Animaciones suaves |
| `audioplayers` | ^5.2.1 | Reproducción de audio |
| `lottie` | ^2.7.0 | Animaciones Lottie (JSON) |
| `google_fonts` | ^6.1.0 | Fuente Fredoka One |
| `confetti` | ^0.7.0 | Efecto confeti al lograr algo |
| `flutter_tts` | ^3.8.5 | Voz en español (TTS) |
| `shared_preferences` | ^2.2.2 | Guardar datos locales |
| `provider` | ^6.1.1 | Manejo de estado |

> ✅ No necesitas instalar estas librerías manualmente. Se instalan solas con `flutter pub get`.

---

## 🚀 Instalación paso a paso

### Paso 1 — Instalar Flutter

1. Ve a 👉 [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
2. Selecciona tu sistema operativo (Windows / macOS / Linux)
3. Descarga el archivo ZIP y extráelo en una carpeta (ej: `C:\flutter` en Windows)
4. Agrega Flutter al PATH del sistema:
   - **Windows:** Busca "Variables de entorno" → agrega `C:\flutter\bin`
   - **Mac/Linux:** Agrega al final de tu `.bashrc` o `.zshrc`:
     ```bash
     export PATH="$PATH:/ruta/a/flutter/bin"
     ```
5. Verifica la instalación abriendo una terminal y ejecutando:
   ```bash
   flutter doctor
   ```
   Deberías ver algo así (✓ en verde en los items principales):
   ```
   [✓] Flutter (Channel stable, 3.19.x)
   [✓] Android toolchain
   [✓] Android Studio
   [✓] Connected device
   ```

---

### Paso 2 — Instalar Android Studio

1. Descarga desde 👉 [https://developer.android.com/studio](https://developer.android.com/studio)
2. Instala y abre Android Studio
3. Ve a **SDK Manager** → **SDK Tools** → instala:
   - ✅ Android SDK Build-Tools
   - ✅ Android Emulator
   - ✅ Android SDK Platform-Tools
4. Acepta las licencias ejecutando:
   ```bash
   flutter doctor --android-licenses
   ```
   Escribe `y` en todo lo que pregunte.

---

### Paso 3 — Clonar el proyecto

```bash
git clone https://github.com/Deanilim/APPTH.git
cd APPTH
```

---

### Paso 4 — Instalar las dependencias de Flutter

```bash
flutter pub get
```

Verás que descarga todos los paquetes automáticamente. Espera a que termine.

---

### Paso 5 — Configurar Firebase 🔥

> ⚠️ **Este paso es obligatorio.** Sin Firebase, la app no arrancará.

#### 5.1 — Crear el proyecto en Firebase Console

1. Ve a 👉 [https://console.firebase.google.com](https://console.firebase.google.com)
2. Haz clic en **"Agregar proyecto"**
3. Nombre del proyecto: `APPTH`
4. Desactiva Google Analytics (opcional para este proyecto)
5. Haz clic en **"Crear proyecto"** y espera

---

#### 5.2 — Activar Authentication (Login anónimo)

1. En el menú izquierdo de Firebase, haz clic en **Authentication**
2. Haz clic en **"Comenzar"**
3. Ve a la pestaña **"Sign-in method"**
4. Haz clic en **"Anónimo"**
5. Activa el interruptor y guarda ✅

---

#### 5.3 — Activar Firestore Database

1. En el menú izquierdo, haz clic en **Firestore Database**
2. Haz clic en **"Crear base de datos"**
3. Selecciona **"Comenzar en modo de prueba"** (permite lectura/escritura por 30 días)
4. Selecciona la región más cercana (ej: `us-central1`)
5. Haz clic en **"Listo"** ✅

---

#### 5.4 — Registrar la app Android en Firebase

1. En la pantalla principal de Firebase, haz clic en el ícono **Android** `</>`
2. Llena el formulario:
   - **Nombre del paquete Android:** `com.example.appth`
   - Alias de la app: `APPTH` (opcional)
   - SHA-1: déjalo vacío por ahora
3. Haz clic en **"Registrar app"**
4. Descarga el archivo **`google-services.json`**
5. Copia ese archivo aquí dentro del proyecto:
   ```
   APPTH/
   └── android/
       └── app/
           └── google-services.json   ← AQUÍ
   ```
6. Haz clic en "Siguiente" hasta terminar el asistente

---

#### 5.5 — Registrar la app iOS en Firebase (solo si usas Mac)

1. En Firebase, haz clic en **"Agregar app"** → ícono **iOS**
2. Llena el formulario:
   - **Bundle ID:** `com.example.appth`
3. Descarga el archivo **`GoogleService-Info.plist`**
4. Abre Xcode, arrastra el archivo al proyecto dentro de la carpeta `Runner`:
   ```
   APPTH/
   └── ios/
       └── Runner/
           └── GoogleService-Info.plist   ← AQUÍ
   ```

---

#### 5.6 — Obtener los datos de `firebase_options.dart`

1. En Firebase Console, ve a ⚙️ **Configuración del proyecto** (engranaje arriba a la izquierda)
2. Baja hasta **"Tus apps"** y haz clic en tu app Android
3. Verás los siguientes datos — **cópialos**:

| Campo en Firebase | Dónde pegarlo en `firebase_options.dart` |
|-------------------|------------------------------------------|
| `apiKey` | `YOUR_API_KEY` |
| `appId` | `YOUR_APP_ID` |
| `messagingSenderId` | `YOUR_MESSAGING_SENDER_ID` |
| `projectId` | `YOUR_PROJECT_ID` |
| `storageBucket` | `YOUR_STORAGE_BUCKET` |

4. Abre el archivo `lib/firebase_options.dart` y reemplaza cada placeholder con el valor real:

```dart
// ANTES (plantilla):
apiKey: 'YOUR_API_KEY',

// DESPUÉS (con tu valor real):
apiKey: 'AIzaSyABCD1234efgh5678...',
```

---

### Paso 6 — Correr la app 🎉

#### En emulador Android:
1. Abre Android Studio → **Device Manager** → crea un emulador (Pixel 6, API 33)
2. Inícialo
3. En la terminal del proyecto ejecuta:
   ```bash
   flutter run
   ```

#### En un celular Android físico:
1. Activa las **Opciones de desarrollador** en tu celular:
   - Ve a **Configuración → Acerca del teléfono → Número de compilación**
   - Toca 7 veces seguidas hasta ver "¡Eres desarrollador!"
2. Activa **Depuración USB**
3. Conecta el celular a la computadora con cable USB
4. Ejecuta:
   ```bash
   flutter devices   # Verifica que aparezca tu celular
   flutter run
   ```

---

## 🔧 Comandos útiles

```bash
# Ver todos los dispositivos disponibles
flutter devices

# Instalar/actualizar dependencias
flutter pub get

# Limpiar caché de compilación
flutter clean

# Compilar APK para Android
flutter build apk

# Ver logs en tiempo real
flutter logs
```

---

## 📁 Estructura del proyecto

```
APPTH/
├── lib/
│   ├── main.dart                    # Punto de entrada + splash
│   ├── firebase_options.dart        # ⚠️ Configura aquí tus credenciales
│   ├── screens/
│   │   ├── home_screen.dart         # Pantalla de inicio
│   │   ├── abecedario_screen.dart   # Módulo abecedario A-Z+Ñ
│   │   ├── vocales_screen.dart      # Módulo vocales
│   │   ├── numeros_screen.dart      # Módulo números 1-10
│   │   └── colores_screen.dart      # Módulo colores
│   ├── widgets/
│   │   ├── letter_card.dart         # Tarjeta reutilizable de letra
│   │   ├── reward_animation.dart    # Animación de recompensa ⭐
│   │   └── bottom_nav.dart          # Barra de navegación inferior
│   ├── models/
│   │   └── lesson_item.dart         # Modelo de lección
│   ├── services/
│   │   ├── firebase_service.dart    # Conexión con Firebase
│   │   └── audio_service.dart       # TTS + audio
│   └── theme/
│       └── app_theme.dart           # Colores y tipografía
├── assets/
│   ├── images/                      # Imágenes (agregar aquí)
│   ├── audio/                       # Audios (agregar aquí)
│   └── animations/                  # Animaciones Lottie (agregar aquí)
├── android/
│   └── app/
│       └── google-services.json     # ⚠️ Descargar de Firebase Console
├── ios/
│   └── Runner/
│       └── GoogleService-Info.plist # ⚠️ Solo si usas iOS/Mac
└── pubspec.yaml                     # Dependencias del proyecto
```

---

## ❗ Problemas frecuentes

### ❌ `google-services.json not found`
→ No pusiste el archivo en `android/app/`. Revisa el **Paso 5.4**.

### ❌ `flutter_tts` no habla en Android
→ Asegúrate de que el celular/emulador tenga el idioma **Español** instalado en Text-to-Speech. Ve a Configuración → Accesibilidad → TTS.

### ❌ `PlatformException: network_error` en Firebase
→ Verifica que los datos en `firebase_options.dart` sean correctos y que el emulador tenga conexión a internet.

### ❌ `flutter doctor` muestra errores en Xcode
→ Solo necesitas Xcode si vas a correr en iOS o Mac. Para Android solo es obligatorio Android Studio.

---

## 🗺️ Fases del proyecto

| Fase | Estado | Contenido |
|------|--------|-----------|
| Fase 1 | ✅ Completada | Abecedario, Vocales, Números, Colores |
| Fase 2 | 🔜 Pendiente | Objetos del hogar, Cocina, Baño |
| Fase 3 | 🔜 Pendiente | Animales, Ropa, Alimentos |

---

## 🛠️ Tecnologías

- [Flutter](https://flutter.dev) — Framework móvil
- [Firebase](https://firebase.google.com) — Backend y base de datos
- [Provider](https://pub.dev/packages/provider) — Manejo de estado
- [Flutter TTS](https://pub.dev/packages/flutter_tts) — Voz en español
- [Confetti](https://pub.dev/packages/confetti) — Animación de celebración
- [Google Fonts](https://pub.dev/packages/google_fonts) — Fuente Fredoka One

---

## 👩‍💻 Autora

Proyecto creado con ❤️ por **Deanira Chambi** — para hacer el aprendizaje más accesible y divertido para todos los niños.

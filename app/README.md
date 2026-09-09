# ConceTour 3D · App

App móvil de **realidad aumentada** para crear, compartir y recorrer rutas turísticas a pie por Concepción, Chile. Flutter + módulo AR nativo (por etapas, ver [docs/stack.md](../docs/stack.md)).

## Estado

Scaffold inicial: tema con la paleta Estándar (claro/oscuro), tipografías del sistema de diseño, navegación y las pantallas de las **fases 1 y 2** funcionales. Fases 3–7 y el módulo AR están en el roadmap.

## Requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) estable reciente (3.3x+)
- Para iOS: Xcode con CocoaPods · Para Android: Android Studio con SDK

> Este Mac aún no tiene Flutter instalado: la primera vez, sigue el enlace anterior e instala la versión estable para macOS.

## Puesta en marcha

```bash
cd app
flutter pub get
flutter run            # elige el dispositivo conectado o emulador
```

## Qué incluye este scaffold

| Pieza | Detalle |
|-------|---------|
| `lib/theme/` | Tokens semánticos del mockup (`AppColors`) y `ThemeData` claro/oscuro con Plus Jakarta Sans e IBM Plex Mono (`google_fonts`) |
| `lib/models/ruta.dart` | `RutaDraft`, `Tramo`, `Parada`, `Destacado` y `TipoContenido` (📝 info · 🖼️ imágenes · 🏛️ edificio histórico) |
| `lib/screens/inicio/` | Fase 1 · bienvenida con menú de usuario y acceso a crear/unirse |
| `lib/screens/crear_ruta/` | Fase 2 · formulario completo con switches de visibilidad/horarios, tramos dinámicos y **panel de destacado** (bottom sheet con los 3 tipos de contenido) |
| `lib/router.dart` | Rutas con `go_router` |

## Convenciones

- Los colores nunca se escriben a mano en las pantallas: siempre `AppColors.of(context)` (equivalente a las variables CSS del mockup).
- La tipografía de interfaz viene del tema; los datos/códigos usan `AppTheme.mono(context)`.
- Datos de ejemplo en `RutaDraft` — se reemplazará por el backend (Firebase/Supabase) en la etapa de servicios.

## Roadmap del código

- [ ] Fases 3–6 (ruta creada, perfil, ver ruta) con el mismo lenguaje visual
- [ ] Backend: auth, base de datos con georutas (PostGIS), storage de imágenes
- [ ] Fase 7 · Recorrido AR «lite»: cámara + flechas GPS/brújula (paquetes `camera`, `geolocator`, `flutter_compass`)
- [ ] Módulo nativo ARKit/ARCore para el modo «ayer ⇄ hoy» (reconocimiento de fachadas)
- [ ] Decisión de gestión de estado a escala (Riverpod) cuando crezca el árbol de pantallas

## Diseño

El sistema de diseño completo (7 fases prototipadas, paletas, especificación AR) vive en la raíz del repositorio: [`README.md`](../README.md) y [`docs/`](../docs).

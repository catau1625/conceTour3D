# Decisión de stack técnico

Documento de decisión de arquitectura (ADR) para la implementación de ConceTour 3D. Estado: **propuesta para revisión** — define criterios, compara opciones y recomienda un camino por etapas.

---

## 1. Requisitos que condicionan el stack

| # | Requisito del producto | Implicancia técnica |
|---|------------------------|---------------------|
| R1 | Vista de cámara en vivo con flechas de navegación (GPS + brújula) | Cámara + sensores (heading, giroscopio); viable en casi cualquier stack |
| R2 | Reconocimiento de fachadas para el modo «ayer ⇄ hoy» | **Image tracking** de grado producción (ARKit Image Tracking / ARCore Augmented Images) |
| R3 | World tracking y anclaje al suelo (mejora evolutiva) | ARKit/ARCore nativos vía framework multiplataforma maduro |
| R4 | Geolocalización precisa, geocercas y mapas | SDK de mapas (Google Maps / Mapbox / OSM) + GPS en segundo plano |
| R5 | ~80% de la app es UI convencional (formularios, listas, perfiles, chat de compartir) | Framework de UI productivo, una sola base de código |
| R6 | Cuentas, enlaces públicos, códigos de ruta, subida de imágenes | Backend convencional (BaaS o API propia) — independiente del stack móvil |
| R7 | Mantenimiento por equipo pequeño (posiblemente 1 persona) | Una base de código, ecosistema maduro, baja ceremonia |
| R8 | iOS y Android desde el día uno | Multiplataforma real, no dos apps nativas duplicadas |

**Conclusión de requisitos:** el AR exigente (R2–R3) convive con una app mayoritariamente convencional (R5). El stack ideal separa bien ambas capas.

## 2. Opciones evaluadas

### A. Nativo puro — SwiftUI + ARKit · Kotlin + ARCore

| | |
|---|---|
| Calidad AR | Excelente (acceso directo a todo ARKit/ARCore, incl. Geospatial API) |
| UI convencional | Excelente por plataforma, pero **dos codebases** |
| Velocidad de desarrollo | Baja para R5 (duplicar 7 fases de UI en dos lenguajes) |
| Costo de mantenimiento | Alto (duplicar cada feature) |
| Riesgo para equipo pequeño | **Alto** |

Descartado como estrategia principal: viola R7/R8 salvo equipo móvil dedicado por plataforma.

### B. Unity 6 + AR Foundation

| | |
|---|---|
| Calidad AR | Muy buena: una sola API sobre ARKit y ARCore; image tracking soportado en ambas plataformas; AR Foundation 6.x añadió tracking de marcadores/QR |
| UI convencional | Posible pero **lenta**: formularios, listas y mapas con UX pulida se iteran peor que en frameworks de UI nativos |
| Velocidad de desarrollo | Alta para la parte AR; media-baja para el 80% restante |
| Peso de la app | Alto (+20–30 MB por el runtime) |
| Costo | Unity Personal gratis (< USD 200k/año de ingresos) |
| Curva | C# + editor Unity; contexto distinto al desarrollo móvil típico |

Atractivo si el AR fuera el 80% de la app. En ConceTour el AR es la pantalla estrella, pero no el grueso.

### C. Flutter + plugins AR

| | |
|---|---|
| UI convencional | **Excelente**: una base de código, iteración rápida, buenos paquetes de mapas, formularios y cámara |
| Calidad AR | **El punto débil**: los plugins AR de la comunidad (`arkit_plugin`, `arcore_flutter_plugin`) cubren planos y objetos, pero el image tracking y el world tracking están menos maduros que los SDK nativos |
| Velocidad de desarrollo | Muy alta para R5; media para R2–R3 |
| Mantenimiento | Bajo; riesgo de depender de plugins de terceros para el AR serio |

Ideal para el MVP (R1) pero insuficiente, sin trabajo adicional, para el modo «ayer ⇄ hoy» de producción (R2).

### D. Flutter (shell) + módulos AR nativos (Swift/Kotlin) vía platform channels

| | |
|---|---|
| UI convencional | Excelente (Flutter) |
| Calidad AR | **Nativa al 100%** en ambas plataformas: ARKit Image Tracking / ARCore Augmented Images disponibles sin límites de plugins |
| Velocidad de desarrollo | Alta en UI; el módulo AR nativo se escribe una vez por plataforma pero **acotado** (una pantalla: vista cámara + overlays) |
| Mantenimiento | Medio-bajo: la superficie nativa es pequeña y estable |
| Riesgo | Requiere algo de Swift y Kotlin (mitigable: el módulo AR es delimitado y prototipable con asistencia de IA) |

### E. React Native + Viro (Community) / WebView + WebXR

WebXR aún no da image tracking de grado producción en móviles; Viro Community tiene actividad irregular. Descartado para R2.

## 3. Recomendación

**Opción D — Flutter como aplicación principal, con un módulo AR nativo embebido por plataforma**, ejecutada por etapas que coinciden con el roadmap de anclaje AR ([realidad-aumentada.md](realidad-aumentada.md) §4):

### Etapa 1 — MVP (solo Flutter, sin código nativo) *(scaffold inicial creado en `app/`)*

- Shell completo de la app: fases 1–6 (cuentas, crear ruta con panel de contenido, compartir, perfil, mapas). **Iniciado:** fases 1–2 con tema, tokens y navegación.
- **Recorrido AR «lite» (R1):** vista de cámara con `camera`, flechas con `geolocator` + `flutter_compass`, geocercas, bottom sheet de información y degradación a mapa.
- **Backend:** Firebase (Auth, Firestore, Storage) o Supabase — decisión independiente, documentada aparte.

### Etapa 2 — «Ayer ⇄ hoy» con anclaje real (R2)

- Módulo nativo delimitado `ARView`: **Swift + ARKit** (Image Tracking) e **Kotlin + ARCore** (Augmented Images), expuesto a Flutter vía platform channel con una interfaz única (`loadReferenceImage`, `setHistoricalOverlay`, `mixOpacity`).
- Registro de fachadas: foto de referencia subida en la fase 2 → genera el marcador de imagen de cada plataforma.
- Si el alcance nativo se dispara, plan B: **Unity AR Foundation embebido como librería** (Unity as a Library) dentro del shell Flutter.

### Etapa 3 — Mejora evolutiva (R3)

- World tracking para flechas ancladas al suelo y anclaje geoespacial (ARCore Geospatial / ARKit Location Anchor) según soporte del dispositivo.

## 4. Backend y servicios (independiente del cliente)

| Servicio | Recomendación MVP |
|----------|-------------------|
| Auth | Firebase Auth o Supabase Auth (correo + Google/Apple) |
| Base de datos | Firestore / Supabase (PostGIS para rutas y geocercas) |
| Archivos (imágenes históricas, referencias) | Firebase Storage / Supabase Storage + CDN |
| Mapas | **Mapbox** o Google Maps; considerar OSM/MapLibre para reducir costos en Chile |
| Códigos de ruta | Cloud Function: hash corto tipo `CT-4F7K` |

## 5. Riesgos y mitigaciones

| Riesgo | Mitigación |
|--------|------------|
| El módulo nativo AR crece en complejidad | Acotar la interfaz AR desde el día 1; todo lo que no sea cámara+overlay vive en Flutter |
| Precisión GPS insuficiente en el centro (edificios altos) | El reconocimiento de fachada (R2) es el anclaje confiable; GPS solo dispara la geocerca |
| Plugins Flutter de mapas/cámara con lagunas en iOS/Android antiguos | Mínimo soportado: iOS 15 / Android 9 (cobertura ARCore/ARKit amplia) |
| Costos de mapas con uso masivo | Capa de abstracción sobre el proveedor de mapas para migrar a MapLibre |
| Derechos de imágenes históricas | Declaración de fuente/licencia obligatoria en rutas públicas (ya diseñado en fase 2) |

## 6. Métricas para revisitar la decisión

Reevaluar la elección si ocurre alguno de estos hitos:

- El módulo AR nativo supera ~30% del esfuerzo de desarrollo → considerar Unity AR Foundation completo (Opción B).
- Apple lanza funciones AR geoespaciales de nivel consumo que Flutter exponga de primera clase.
- El equipo crece a 2+ desarrolladores móviles por plataforma → reabrir nativo puro.

## 7. Referencias

- Unity 6 + AR Foundation 6.x: una API sobre ARKit/ARCore, tracking de imágenes y marcadores; tier gratuito Personal (< USD 200k/año) — [buildmvpfast.com, feb 2026](https://www.buildmvpfast.com/blog/best-ar-spatial-computing-tools-2026)
- AR Foundation vs ARCore nativo: AR Foundation logra ~80–90% del rendimiento nativo con mucha más velocidad de desarrollo; nativo gana en features de vanguardia y rendimiento puro — [Angry Shark Studio, feb 2025](https://www.angry-shark-studio.com/blog/ar-foundation-vs-arcore-comparison/)
- ARCore: gratis, Geospatial API, Quick Plane Detection; consumo alto de batería — comparativa SDKs [Stack Overflow](https://stackoverflow.com/questions/50811770/are-there-any-limitations-in-vuforia-compared-to-arcore-and-arkit)

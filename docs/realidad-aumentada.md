# Realidad aumentada en ConceTour 3D

La experiencia central de la app **no es un mapa: es la cámara en vivo**. Al iniciar un recorrido, la pantalla se convierte en una interfaz tipo cámara fotográfica donde la ruta y el contenido se dibujan sobre el mundo real. Este documento define los requisitos de AR acordados para el proyecto.

---

## 1. La pantalla de recorrido AR

Al tocar **«Iniciar recorrido»** (desde la fase 6 · Ver ruta) se abre la vista de cámara a pantalla completa:

- **Fondo:** imagen en vivo de la cámara trasera.
- **HUD mínimo:** distancia y tiempo restante, botón de salida, y control para alternar entre **vista AR** y **vista mapa** (respaldo para interiores o dispositivos sin soporte AR).
- **Sin modo retrato:** el recorrido se vive con la cámara mirando hacia adelante.

## 2. Flechitas de navegación en tiempo real

Sobre la imagen de la cámara se superponen **flechas de dirección** que guían el recorrido:

- Indican **hacia dónde caminar** hacia la siguiente parada, calculadas con **geolocalización + brújula (heading)** y la polilínea de la ruta.
- **Anclaje:** versión base con flechas en pantalla apuntando al rumbo objetivo (bajo consumo, funciona en casi todos los equipos). Mejora posterior con flechas ancladas al mundo (ARKit / ARCore world tracking) que "se pegan" al suelo.
- **Llegada a parada:** la flecha se convierte en un marcador ● y se dispara el contenido de la parada (ver §3).
- Si el GPS pierde precisión, se avisa y se ofrece la vista mapa automáticamente.

## 3. Contenido en los lugares especiales

Cuando el usuario se acerca a una **parada o destacado** (geocerca alrededor del punto), la app muestra su contenido sin salir de la cámara:

- **Información → recuadro desplegable:** un panel inferior (bottom sheet) con el nombre del lugar y su descripción, plegable para no tapar la vista. Es el mismo contenido ya definido en la fase 6.
- **Imágenes → superposición en tiempo real:** las imágenes asociadas al punto se muestran **flotando ancladas a su ubicación** en la vista de cámara.

## 4. Imágenes históricas en edificios («ayer y hoy»)

Caso especial acordado para **edificios importantes**:

1. Al crear el recorrido, en el destacado del edificio se **carga la imagen antigua** (fotografía histórica) y, como referencia, una **foto actual de la fachada**.
2. Durante el recorrido, al **apuntar la cámara al edificio**, la imagen antigua aparece **superpuesta y alineada sobre la fachada real** — como si el pasado se viera en tiempo real.
3. El usuario puede **ajustar opacidad** (deslizador «ayer ⇄ hoy») para comparar el edificio actual con el histórico.

### Cómo se logra el anclaje (opciones técnicas)

| Enfoque | Cómo funciona | Precisión | Esfuerzo |
|---------|---------------|-----------|----------|
| **GPS + brújula** (base) | La imagen se posiciona según la ubicación y orientación del teléfono | Baja-media (5–15 m) | Bajo |
| **Reconocimiento de imagen** | La foto actual de la fachada se registra como marcador; el SDK la detecta en cámara y pega la imagen histórica | Alta en la fachada registrada | Medio (ARKit Image Tracking / ARCore Augmented Images) |
| **World tracking + planos** | ARCore/ARKit detectan la pared como plano vertical y anclan la imagen | Alta, estable al moverse | Alto |

**Decisión de diseño:** partir con GPS + brújula y reconocimiento de imagen por fachada; el world tracking queda como mejora evolutiva.

## 5. Cambios en la creación de recorridos (fase 2)

El formulario de «Crear ruta» se amplía. Al **agregar un destacado** (★) o parada, se ofrece adjuntar contenido:

```
★ Agregar destacado
   ├─ 📝 Cargar información  → texto que se mostrará en el recuadro desplegable
   └─ 🖼️ Cargar imagen(es)   → se superponen en tiempo real durante el recorrido
        └─ 🏛️ ¿Es un edificio histórico?
             ├─ Sí: pedir imagen antigua + foto actual de referencia
             └─ No: imagen(es) ilustrativas del lugar
```

- La **información** se edita en un campo de texto enriquecido sencillo (título + descripción).
- Las **imágenes** se suben desde la galería o se toman en el momento; cada destacado admite varias.
- Todo queda **asociado al punto georreferenciado** del recorrido.
- Para rutas **públicas**, el formulario debe declarar que las imágenes se mostrarán a terceros (ver §7).

## 6. Permisos y sensores requeridos

| Permiso | Para qué |
|---------|----------|
| Cámara | Vista AR en vivo, reconocimiento de fachadas |
| Ubicación (precisa, en uso) | Posicionar al usuario en la ruta y disparar geocercas |
| Brújula / magnetómetro | Orientar las flechas hacia el rumbo correcto |
| Movimiento (giroscopio/acelerómetro) | Estabilizar el anclaje AR |
| Notificaciones (opcional) | Avisos de paradas próximas con la pantalla apagada |

**Batería:** la vista AR es intensiva; definir modo ahorro (flechas sin world tracking, pantalla atenuada entre paradas).

## 7. Consideraciones de contenido y privacidad

- **Derechos de las imágenes históricas:** validar la fuente (archivos municipales, bibliotecas, colecciones con licencia). La app debe exigir declarar origen/licencia al subir.
- **Imágenes propias vs. públicas:** en rutas privadas solo las ve quien tiene el enlace; en públicas, cualquiera.
- **Moderación mínima:** reportar contenido inapropiado en rutas públicas.
- **Precisión GPS en ciudad:** los edificios altos degradan el GPS; por eso el reconocimiento de fachada (§4) es el anclaje confiable para el caso «ayer y hoy».

## 8. Impacto en el roadmap

Nuevas decisiones técnicas que la AR agrega antes de implementar:

- [ ] Elección de stack con soporte AR: **nativo** (ARKit iOS / ARCore Android), **multiplataforma** (Unity AR Foundation, Flutter con plugins AR) o híbrido
- [ ] Estrategia de anclaje: fase 1 GPS+brújula, fase 2 reconocimiento de imagen por fachada
- [x] ~~Diseño de la pantalla de recorrido AR~~ — **hecho**: fase 7 del mockup con vista cámara, flechas, hoja de información plegable, alternancia AR ⇄ Mapa y deslizador «ayer ⇄ hoy»
- [ ] Modelo de datos de destacados: tipo de contenido (info / imagen / edificio histórico), archivos, licencia, foto de referencia
- [ ] Flujo de permisos y degradación elegante en equipos sin AR

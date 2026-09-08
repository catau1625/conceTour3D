# Paletas de color y tipografía

El sistema de color de ConceTour 3D está construido sobre **variables CSS** (`custom properties`). Toda la interfaz del mockup consume tokens semánticos, lo que permite cambiar la paleta completa modificando un solo bloque `:root`.

Fuente de diseño: el documento `conceTour3D-paletasTipo.pages` (incluido en la raíz del repositorio).

---

## 1. Tokens semánticos

La interfaz no usa colores crudos: cada uso tiene un token con significado.

| Token | Uso |
|-------|-----|
| `--bg` | Fondo general de la pantalla |
| `--surface` | Tarjetas y superficies elevadas |
| `--surface-2` | Campos de entrada y filas alternas |
| `--ink` | Texto principal |
| `--muted` | Texto secundario |
| `--line` | Bordes y divisores |
| `--accent` | Color de acción: botones primarios, trazado de ruta |
| `--accent-ink` | Texto sobre el color de acción |
| `--accent-soft` | Fondos suaves asociados a la acción |
| `--ok` | Éxito / rutas propias |
| `--star` | Lugares destacados (estrellas) |
| `--danger` | Cerrar sesión / descartar |
| `--map-land` | Mapa: manzanas / terreno |
| `--map-road` | Mapa: calles |
| `--map-road-edge` | Mapa: bordes de calles |
| `--map-park` | Mapa: áreas verdes |
| `--map-water` | Mapa: agua (río Biobío) |
| `--frame` | Bisel del teléfono en el mockup |

---

## 2. Paleta Estándar (base)

Paleta neutra y profesional. Es la **única con modo oscuro** (automático según `prefers-color-scheme`, o forzado con `data-theme="dark"`).

### Modo claro

| Token | Valor | Muestra |
|-------|-------|---------|
| `--bg` | `#EEF1F5` | ![](https://placehold.co/14x14/EEF1F5/EEF1F5) |
| `--surface` | `#FFFFFF` | blanco |
| `--surface-2` | `#F4F6F9` | ![](https://placehold.co/14x14/F4F6F9/F4F6F9) |
| `--ink` | `#1B2430` | ![](https://placehold.co/14x14/1B2430/1B2430) |
| `--muted` | `#6B7684` | ![](https://placehold.co/14x14/6B7684/6B7684) |
| `--line` | `#D8DEE6` | ![](https://placehold.co/14x14/D8DEE6/D8DEE6) |
| `--accent` | `#2563EB` | ![](https://placehold.co/14x14/2563EB/2563EB) |
| `--ok` | `#15803D` | ![](https://placehold.co/14x14/15803D/15803D) |
| `--star` | `#D97706` | ![](https://placehold.co/14x14/D97706/D97706) |
| `--danger` | `#DC2626` | ![](https://placehold.co/14x14/DC2626/DC2626) |
| `--map-land` | `#F1EFE9` | ![](https://placehold.co/14x14/F1EFE9/F1EFE9) |
| `--map-park` | `#CDE8C8` | ![](https://placehold.co/14x14/CDE8C8/CDE8C8) |
| `--map-water` | `#B7D6EE` | ![](https://placehold.co/14x14/B7D6EE/B7D6EE) |

### Modo oscuro

| Token | Valor |
|-------|-------|
| `--bg` | `#151A21` |
| `--surface` | `#1E242D` |
| `--surface-2` | `#262D37` |
| `--ink` | `#EDF1F6` |
| `--muted` | `#98A2B0` |
| `--line` | `#37404C` |
| `--accent` | `#5B8DEF` |
| `--ok` | `#4ADE80` |
| `--star` | `#FBBF24` |
| `--danger` | `#F87171` |
| `--map-land` | `#2A2F36` |
| `--map-park` | `#2E4A33` |
| `--map-water` | `#243A52` |

---

## 3. Paletas temáticas

Cada paleta temática define 5 colores base (`--p1`…`--p5`) y deriva de ellos todos los tokens semánticos, ajustados para mantener contraste legible en texto y mapa.

Se activan con `data-palette="…"` en el elemento `<html>` o con el parámetro `?paleta=…` en la URL del mockup.

### 🌇 Atardecer — `atardecer`

`#FFCF9C · #FF8C6B · #E8543F · #7C3F82 · #2C2153`

| Token | Valor |
|-------|-------|
| `--bg` | `#FFF3E8` |
| `--ink` | `#2C2153` |
| `--muted` | `#7A6A8C` |
| `--accent` | `#7C3F82` |
| `--ok` | `#2C2153` |
| `--star` | `#E8543F` |
| `--danger` | `#E8543F` |
| `--map-land` | `#FCEBDC` |
| `--map-park` | `#FFDFBE` |
| `--map-water` | `#DCCBE2` |

Tonalidades cálidas de atardecer sobre el río: melocotón, coral y berenjena.

### 🌲 Bosque — `bosque`

`#77E4A3 · #B6BE28 · #D39E70 · #3CAEC7 · #A57729`

| Token | Valor |
|-------|-------|
| `--bg` | `#F3F6EE` |
| `--ink` | `#3A2A12` |
| `--muted` | `#7A6A55` |
| `--accent` | `#3CAEC7` |
| `--ok` | `#2E9E64` |
| `--star` | `#A57729` |
| `--danger` | `#B4512E` |
| `--map-land` | `#EEF0E3` |
| `--map-park` | `#B9E8CB` |
| `--map-water` | `#BFE3EC` |

Verdes del Parque Ecuador y turquesas del Biobío, con tierra y madera.

### 🍋 Cítrica — `citrica`

`#DDEB75 · #CDE7A2 · #D2BF5B · #E79737 · #CD3518`

| Token | Valor |
|-------|-------|
| `--bg` | `#F7F8EC` |
| `--ink` | `#2F2A12` |
| `--muted` | `#7A7050` |
| `--accent` | `#E79737` |
| `--ok` | `#8A9A1E` |
| `--star` | `#B59F2E` |
| `--danger` | `#CD3518` |
| `--map-land` | `#F4F5E6` |
| `--map-park` | `#CDE7A2` |
| `--map-water` | `#C9E6DD` |

Lima y mandarina, fresca y veraniega.

### 🦩 Tropical — `tropical`

`#00C2CB · #7FE0D4 · #FFE38A · #FF9A76 · #FF5D8F`

| Token | Valor |
|-------|-------|
| `--bg` | `#EEF9F9` |
| `--ink` | `#123A3D` |
| `--muted` | `#5C7276` |
| `--accent` | `#00C2CB` |
| `--ok` | `#1EA79A` |
| `--star` | `#E0A100` |
| `--danger` | `#E03A70` |
| `--map-land` | `#F2F4EA` |
| `--map-park` | `#D2F3EE` |
| `--map-water` | `#BDEDF0` |

Turquesa, arena y flamenco, la más juguetona.

> ⚠️ Las paletas temáticas son de evaluación: fijan `color-scheme: light` y no tienen modo oscuro. La paleta **Estándar** es la candidata base para la implementación.

---

## 4. Tipografía

| Rol | Fuente | Pesos | Uso |
|-----|--------|-------|-----|
| Interfaz | **Plus Jakarta Sans** | 400 · 500 · 600 · 700 · 800 | Todo el texto de la app: títulos, cuerpo, botones |
| Datos | **IBM Plex Mono** | 400 · 500 · 600 | Códigos de ruta, distancias, leyendas, metadatos |

Ambas se cargan desde Google Fonts en el mockup:

```html
<link rel="stylesheet"
  href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=IBM+Plex+Mono:wght@400;500;600&display=swap">
```

### Escala tipográfica del mockup

| Elemento | Tamaño / peso |
|----------|---------------|
| Título de pantalla (`.title`) | 26 px · 800 |
| Título de tarjeta | 22 px · 800 |
| Marca (`.brand`) | 17 px · 800 |
| Cuerpo | 14 px · 400 |
| Secundario / `.lead` | 14 px · 400 (color `--muted`) |
| Etiquetas (`.label`, `.eyebrow`) | 11–12 px · 600 |
| Botones | 14.5 px · 600 |
| Leyendas mono | 11.5–12.5 px · 400–600 |

---

## 5. Cómo añadir una nueva paleta

1. Definir los 5 colores base y asignarlos a `--p1`…`--p5`.
2. Derivar `--bg`, `--surface`, `--surface-2`, `--ink`, `--muted` y `--line` asegurando contraste AA sobre el blanco.
3. Asignar `--accent` (acción principal) y derivar `--accent-ink` y `--accent-soft`.
4. Mapear `--ok`, `--star` y `--danger` con sus fondos suaves (`--ok-soft`, `--star-soft`, `--danger-soft`).
5. Ajustar los tokens de mapa (`--map-*`) para que parques y agua sigan distinguibles.
6. Registrar la paleta en el selector del mockup (bloque `.palettes`) y en el script que aplica `data-palette`.

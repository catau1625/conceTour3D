# conceTour3D

**ConceTour 3D** es una aplicación móvil para crear, compartir y recorrer rutas turísticas a pie por Concepción (Región del Biobío, Chile). Este repositorio contiene la documentación de diseño del proyecto: el mockup interactivo del flujo completo, el sistema de paletas de color y la tipografía.

> Estado del proyecto: **diseño / prototipado** — aún no existe implementación de la app; el material aquí publicado es la base sobre la cual se construirá.

🌐 **[Ver los mockups interactivos](https://catau1625.github.io/conceTour3D/)** — publicado con GitHub Pages · [📦 Repositorio](https://github.com/catau1625/conceTour3D) · Licencia MIT

---

## Galería

Las cinco paletas del sistema sobre el flujo completo en 6 fases. En el sitio puedes cambiarlas en vivo con el selector o con `?paleta=…` en la URL.

| Estándar | Atardecer |
|----------|-----------|
| ![Lámina estándar](mockups/img/estandar/lamina-estandar.png) | ![Lámina atardecer](mockups/img/atardecer/lamina-atardecer.png) |

| Bosque | Cítrica | Tropical |
|--------|---------|----------|
| ![Lámina bosque](mockups/img/bosque/lamina-bosque.png) | ![Lámina cítrica](mockups/img/citrica/lamina-citrica.png) | ![Lámina tropical](mockups/img/tropical/lamina-tropical.png) |

### Capturas del sitio publicado

Verificación visual del despliegue en GitHub Pages (septiembre 2026), disponible en [docs/capturas/](docs/capturas/):

- [Página del repositorio en GitHub](docs/capturas/github-readme.png) — README con galería y tabla de fases
- Mockup renderizado en cada paleta: [estándar](docs/capturas/mockup-estandar.png) · [atardecer](docs/capturas/mockup-atardecer.png) · [bosque](docs/capturas/mockup-bosque.png) · [cítrica](docs/capturas/mockup-citrica.png) · [tropical](docs/capturas/mockup-tropical.png)

---

## ¿Qué es ConceTour 3D?

Una app que permite a los usuarios:

- **Crear recorridos** propios definiendo tramos, paradas y lugares destacados sobre el mapa de Concepción.
- **Unirse a recorridos** públicos creados por otros usuarios mediante un enlace o código de invitación.
- **Compartir rutas** con un código corto (ej. `CT-4F7K`) y un enlace público.
- **Guardar perfiles** con rutas recorridas, propias y favoritas.
- **Descubrir cada parada** con un carrusel de imágenes y una descripción breve.

## Flujo de diseño: 6 fases

El mockup interactivo documenta el flujo completo en seis pantallas:

| Fase | Pantalla | Descripción |
|------|----------|-------------|
| 1 | [Inicio / bienvenida](docs/flujo-de-fases.md#fase-1--inicio--bienvenida) | Menú de usuario, acceso rápido a crear o unirse a un recorrido |
| 2 | [Crear ruta](docs/flujo-de-fases.md#fase-2--crear-ruta) | Formulario con tramos, paradas, destacados, visibilidad y horarios |
| 3 | [Ruta creada](docs/flujo-de-fases.md#fase-3--ruta-creada) | Ticket de éxito con código de ruta, mapa y opciones de compartir |
| 4 | [Perfil](docs/flujo-de-fases.md#fase-4--perfil) | Datos editables y listas plegadas (recorridas, propias, favoritas) |
| 5 | [Perfil · listas desplegadas](docs/flujo-de-fases.md#fase-5--perfil-con-listas-desplegadas) | Las tres listas del perfil abiertas |
| 6 | [Ver ruta](docs/flujo-de-fases.md#fase-6--ver-ruta) | Mapa con paradas y destacados, cada uno con carrusel de 3 imágenes |

## Sistema de diseño

- **Tipografía:** Plus Jakarta Sans (interfaz) e IBM Plex Mono (datos, códigos, leyendas).
- **Color:** 5 paletas intercambiables — Estándar (neutra, con modo oscuro), Atardecer, Bosque, Cítrica y Tropical. Detalle completo en [docs/paletas-de-color.md](docs/paletas-de-color.md).
- **Tokens semánticos:** `accent` (acciones y trazado de ruta), `ok` (éxito / rutas propias), `star` (destacados), `danger` (cerrar sesión / descartar), más tokens de mapa (tierra, calles, parque, agua — el río Biobío).

## Cómo ver los mockups

Abre el archivo directamente en un navegador:

```bash
open mockups/conceTour3D-fases.html
```

Los seis teléfonos del documento son **interactivos**: los menús, switches, acordeones, botones de agregar paradas/tramos/destacados y los carruseles responden al clic.

### Probar las paletas de color

El selector de la cabecera permite cambiar la paleta de toda la lámina. También se puede forzar por URL:

```
mockups/conceTour3D-fases.html?paleta=atardecer
mockups/conceTour3D-fases.html?paleta=bosque
mockups/conceTour3D-fases.html?paleta=citrica
mockups/conceTour3D-fases.html?paleta=tropical
```

Sin parámetro se usa la paleta **Estándar** (única con modo oscuro automático vía `prefers-color-scheme`).

## Estructura del repositorio

```
conceTour3D/
├── README.md                      ← este archivo
├── LICENSE                        ← MIT © 2026 Catalina Ubilla Rubio
├── docs/
│   ├── flujo-de-fases.md          ← documentación detallada de las 6 pantallas
│   └── paletas-de-color.md        ← paletas, tokens semánticos y tipografía
├── mockups/
│   ├── conceTour3D-fases.html     ← mockup interactivo (HTML + CSS + JS, un solo archivo)
│   └── img/                       ← exportaciones PNG por paleta y fase
│       ├── estandar/              ← fase-01…fase-06 + lámina completa
│       ├── atardecer/
│       ├── bosque/
│       ├── citrica/
│       └── tropical/
└── conceTour3D-paletasTipo.pages  ← documento Pages con paletas y tipografía (fuente)
```

## Datos de ejemplo usados en el diseño

- **Usuario:** Catalina Ubilla · @cata.conce · Concepción
- **Ruta principal de muestra:** «Centro histórico de Conce» — 2,3 km, ~1 h 10, 4 paradas (Plaza de la Independencia, Catedral de la Santísima Concepción, Galería de la Historia, Parque Ecuador) y 2 destacados.
- **Código de ruta de muestra:** `CT-4F7K` → `concetour3d.app/r/CT-4F7K`

## Roadmap previsto

- [ ] Definir stack de implementación (app móvil) y repositorio de código
- [ ] Mapa real con cartografía de Concepción (reemplaza el mapa vectorial ilustrado del mockup)
- [ ] Sistema de cuentas y autenticación
- [ ] Códigos de invitación y enlaces públicos
- [ ] Decisión final de paleta (la neutral es la base; las temáticas están en evaluación)

## Licencia

MIT — ver [LICENSE](LICENSE). © 2026 Catalina Ubilla Rubio.

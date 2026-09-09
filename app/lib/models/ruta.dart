/// Tipos de contenido adjunto a un destacado (ver docs/realidad-aumentada.md §5).
enum TipoContenido {
  /// 📝 Información: se muestra en un recuadro desplegable durante el recorrido.
  info,

  /// 🖼️ Imágenes: se superponen en tiempo real en la vista de cámara.
  imagenes,

  /// 🏛️ Edificio histórico: imagen antigua alineada sobre la fachada (ayer ⇄ hoy).
  edificioHistorico;

  String get icono => switch (this) {
        TipoContenido.info => '📝',
        TipoContenido.imagenes => '🖼️',
        TipoContenido.edificioHistorico => '🏛️',
      };

  String get descripcion => switch (this) {
        TipoContenido.info => 'Se muestra en un recuadro desplegable',
        TipoContenido.imagenes => 'Se superponen en tiempo real',
        TipoContenido.edificioHistorico => 'Ayer ⇄ hoy sobre la fachada',
      };
}

/// Un lugar destacado dentro de un tramo.
class Destacado {
  Destacado({
    required this.nombre,
    required this.tipo,
    this.descripcion = '',
    this.imagenAntiguaPath,
    this.fotoReferenciaPath,
  });

  final String nombre;
  final TipoContenido tipo;

  /// Solo para [TipoContenido.info].
  final String descripcion;

  /// Solo para [TipoContenido.edificioHistorico].
  final String? imagenAntiguaPath;
  final String? fotoReferenciaPath;
}

/// Una parada simple dentro de un tramo.
class Parada {
  Parada(this.nombre);
  final String nombre;
}

/// Tramo de la ruta: origen → destino con paradas y destacados.
class Tramo {
  Tramo({
    required this.nombre,
    required this.origen,
    required this.destino,
    this.distancia = '— m',
  });

  final String nombre;
  final String origen;
  final String destino;
  final String distancia;
  final List<Parada> paradas = [];
  final List<Destacado> destacados = [];
}

/// Ruta en construcción (fase 2 · Crear ruta).
class RutaDraft {
  String nombre = 'Centro histórico de Conce';
  bool publica = true;
  bool conHorarios = false;
  String horaInicio = '10:00';
  String horaTermino = '12:30';
  final Set<String> dias = {'L', 'X', 'V', 'S'};
  final List<Tramo> tramos = [
    Tramo(
      nombre: 'Tramo 1',
      origen: 'Plaza de la Independencia',
      destino: 'Catedral de la Santísima Concepción',
      distancia: '650 m',
    )..paradas.add(Parada('Plaza'))
     ..destacados.add(Destacado(
       nombre: 'Fuente de la Plaza',
       tipo: TipoContenido.info,
       descripcion: 'Pila de mármol de 1856 con la figura de Ceres.',
     )),
    Tramo(
      nombre: 'Tramo 2',
      origen: 'Catedral de la Santísima Concepción',
      destino: 'Parque Ecuador',
      distancia: '900 m',
    )..paradas.add(Parada('Galería de la Historia')),
  ];

  Tramo get ultimoTramo => tramos.last;

  int get totalParadas => tramos.fold(0, (n, t) => n + t.paradas.length);
  int get totalDestacados => tramos.fold(0, (n, t) => n + t.destacados.length);
}

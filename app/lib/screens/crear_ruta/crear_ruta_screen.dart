import 'package:flutter/material.dart';

import '../../models/ruta.dart';
import '../../theme/app_colors.dart';

/// Fase 2 · Crear ruta.
///
/// Formulario con nombre, visibilidad, horarios, tramos con paradas y
/// destacados. El panel de contenido del destacado replica el mockup
/// (📝 información · 🖼️ imágenes · 🏛️ edificio histórico).
class CrearRutaScreen extends StatefulWidget {
  const CrearRutaScreen({super.key});

  @override
  State<CrearRutaScreen> createState() => _CrearRutaScreenState();
}

class _CrearRutaScreenState extends State<CrearRutaScreen> {
  final _draft = RutaDraft();
  final _lugares = [
    'Mercado Central',
    'Casa del Arte',
    'Teatro Biobío',
    'Barrio Estación',
    'Universidad de Concepción',
    'Cerro Caracol',
  ];
  var _siguienteLugar = 0;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                children: [
                  _TopBar(colors: colors),
                  const SizedBox(height: 14),
                  Text('Nombre de la ruta',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: colors.muted)),
                  const SizedBox(height: 6),
                  TextFormField(
                    initialValue: _draft.nombre,
                    onChanged: (v) => _draft.nombre = v,
                  ),
                  const SizedBox(height: 12),
                  _ToggleRow(
                    titulo: 'Ruta pública',
                    textoOn: 'Cualquiera puede unirse y verla',
                    textoOff: 'Privada · solo con enlace de invitación',
                    valor: _draft.publica,
                    onChanged: (v) => setState(() => _draft.publica = v),
                  ),
                  const SizedBox(height: 10),
                  _ToggleRow(
                    titulo: 'Incluir horarios',
                    textoOn: 'Se muestran al unirse a la ruta',
                    textoOff: 'Ruta sin horario definido',
                    valor: _draft.conHorarios,
                    onChanged: (v) => setState(() => _draft.conHorarios = v),
                  ),
                  if (_draft.conHorarios) ...[
                    const SizedBox(height: 10),
                    _HorariosEditor(
                      draft: _draft,
                      onChanged: () => setState(() {}),
                    ),
                  ],
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tramos de la ruta',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w700)),
                      Text('${_draft.tramos.length} tramos',
                          style: TextStyle(fontSize: 12, color: colors.muted)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  for (final tramo in _draft.tramos)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _TramoCard(tramo: tramo),
                    ),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 4.4,
                    children: [
                      OutlinedButton.icon(
                        onPressed: _agregarParada,
                        icon: const Icon(Icons.add, size: 16),
                        label: const Text('Agregar parada'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: colors.accent,
                          backgroundColor: colors.accentSoft,
                          side: BorderSide.none,
                          textStyle: const TextStyle(
                              fontSize: 12.5, fontWeight: FontWeight.w600),
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: _panelDestacado,
                        icon: const Icon(Icons.star, size: 16),
                        label: const Text('Agregar destacado'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: colors.star,
                          backgroundColor: colors.starSoft,
                          side: BorderSide.none,
                          textStyle: const TextStyle(
                              fontSize: 12.5, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: _agregarTramo,
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Agregar tramo'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colors.muted,
                      side: BorderSide(
                          style: BorderStyle.solid, color: colors.line),
                      minimumSize: const Size.fromHeight(34),
                      textStyle: const TextStyle(
                          fontSize: 12.5, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [colors.bg, colors.bg.withValues(alpha: 0)],
                ),
              ),
              child: FilledButton.icon(
                onPressed: _crearRuta,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Crear ruta'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _agregarParada() {
    setState(() {
      final nombre = _lugares[_siguienteLugar++ % _lugares.length];
      _draft.ultimoTramo.paradas.add(Parada(nombre));
    });
  }

  void _agregarTramo() {
    setState(() {
      final n = _draft.tramos.length + 1;
      final origen = _draft.ultimoTramo.destino;
      _draft.tramos.add(Tramo(
        nombre: 'Tramo $n',
        origen: origen,
        destino: 'Dirección final',
      ));
    });
  }

  Future<void> _panelDestacado() async {
    final destacado = await showModalBottomSheet<Destacado>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => const _PanelDestacado(),
    );
    if (destacado != null) {
      setState(() => _draft.ultimoTramo.destacados.add(destacado));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Destacado agregado ${destacado.tipo.icono}')),
        );
      }
    }
  }

  void _crearRuta() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ruta creada ✓')),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.colors});

  final AppColorsValues colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton.icon(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(Icons.arrow_back, size: 18),
          label: const Text('Crear ruta',
              style:
                  TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          style: TextButton.styleFrom(foregroundColor: colors.ink),
        ),
        CircleAvatar(
          radius: 20,
          backgroundColor: colors.accentSoft,
          child: Text('CU',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: colors.accent)),
        ),
      ],
    );
  }
}

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.titulo,
    required this.textoOn,
    required this.textoOff,
    required this.valor,
    required this.onChanged,
  });

  final String titulo;
  final String textoOn;
  final String textoOff;
  final bool valor;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: colors.line),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titulo,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(
                  valor ? textoOn : textoOff,
                  style: TextStyle(fontSize: 12, color: colors.muted),
                ),
              ],
            ),
          ),
          Switch(value: valor, onChanged: onChanged),
        ],
      ),
    );
  }
}

class _HorariosEditor extends StatelessWidget {
  const _HorariosEditor({required this.draft, required this.onChanged});

  final RutaDraft draft;
  final VoidCallback onChanged;

  static const _dias = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: colors.line),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _HoraField(
                  label: 'Inicio',
                  valor: draft.horaInicio,
                  onChanged: (v) => draft.horaInicio = v,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _HoraField(
                  label: 'Término',
                  valor: draft.horaTermino,
                  onChanged: (v) => draft.horaTermino = v,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            children: [
              for (final d in _dias)
                FilterChip(
                  label: Text(d),
                  selected: draft.dias.contains(d),
                  onSelected: (sel) {
                    sel ? draft.dias.add(d) : draft.dias.remove(d);
                    onChanged();
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HoraField extends StatelessWidget {
  const _HoraField(
      {required this.label, required this.valor, required this.onChanged});

  final String label;
  final String valor;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w600, color: colors.muted)),
        const SizedBox(height: 4),
        TextFormField(
          initialValue: valor,
          onChanged: onChanged,
          keyboardType: TextInputType.datetime,
        ),
      ],
    );
  }
}

class _TramoCard extends StatelessWidget {
  const _TramoCard({required this.tramo});

  final Tramo tramo;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(tramo.nombre,
                    style: const TextStyle(fontWeight: FontWeight.w700)),
                Text('recto · ${tramo.distancia}',
                    style: TextStyle(
                        fontSize: 11, color: colors.muted, fontFamily: 'monospace')),
              ],
            ),
            const SizedBox(height: 8),
            _PuntoRow(icono: Icons.circle, color: colors.accent, texto: tramo.origen),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Container(
                width: 2,
                height: 12,
                margin: const EdgeInsets.symmetric(vertical: 2),
                color: colors.line,
              ),
            ),
            _PuntoRow(
                icono: Icons.square, color: colors.danger, texto: tramo.destino),
            if (tramo.paradas.isNotEmpty || tramo.destacados.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final p in tramo.paradas)
                    _Chip(
                      texto: '● Parada · ${p.nombre}',
                      fondo: colors.accentSoft,
                      color: colors.accent,
                    ),
                  for (final d in tramo.destacados)
                    _Chip(
                      texto: '★ ${d.nombre} · ${d.tipo.icono}',
                      fondo: colors.starSoft,
                      color: colors.star,
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PuntoRow extends StatelessWidget {
  const _PuntoRow(
      {required this.icono, required this.color, required this.texto});

  final IconData icono;
  final Color color;
  final String texto;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icono, size: 12, color: color),
        const SizedBox(width: 8),
        Expanded(child: Text(texto, style: const TextStyle(fontSize: 13.5))),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip(
      {required this.texto, required this.fondo, required this.color});

  final String texto;
  final Color fondo;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: fondo,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(texto,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: color)),
    );
  }
}

/// Panel *Nuevo destacado*: nombre + tipo de contenido (📝/🖼️/🏛️).
class _PanelDestacado extends StatefulWidget {
  const _PanelDestacado();

  @override
  State<_PanelDestacado> createState() => _PanelDestacadoState();
}

class _PanelDestacadoState extends State<_PanelDestacado> {
  final _nombre = TextEditingController();
  final _descripcion = TextEditingController();
  TipoContenido _tipo = TipoContenido.info;

  @override
  void dispose() {
    _nombre.dispose();
    _descripcion.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Nuevo destacado',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700)),
              Text('se ancla a este tramo',
                  style: TextStyle(fontSize: 12, color: colors.muted)),
            ],
          ),
          const SizedBox(height: 12),
          Text('Nombre del lugar',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: colors.muted)),
          const SizedBox(height: 6),
          TextFormField(
            controller: _nombre,
            decoration: const InputDecoration(
                hintText: 'Ej: Fuente de la Plaza'),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              for (final tipo in TipoContenido.values) ...[
                Expanded(child: _OpcionTipo(tipo: tipo, seleccionado: _tipo == tipo, onTap: () => setState(() => _tipo = tipo))),
                if (tipo != TipoContenido.values.last) const SizedBox(width: 8),
              ],
            ],
          ),
          const SizedBox(height: 12),
          if (_tipo == TipoContenido.info)
            TextFormField(
              controller: _descripcion,
              minLines: 3,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Se despliega al llegar al lugar durante el recorrido…',
              ),
            ),
          if (_tipo == TipoContenido.imagenes) ...[
            _ZonaCarga(
              titulo: '🖼️ Arrastra imágenes o toca para subir',
              subtitulo: 'Se verán superpuestas en la cámara durante el recorrido',
            ),
            const SizedBox(height: 8),
            Row(
              children: List.generate(
                3,
                (i) => Container(
                  width: 46,
                  height: 46,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: colors.line, style: BorderStyle.solid),
                    color: colors.surface2,
                  ),
                ),
              ),
            ),
          ],
          if (_tipo == TipoContenido.edificioHistorico) ...[
            _ZonaCarga(
              titulo: '🏛️ Imagen antigua · obligatoria',
              subtitulo: 'Se alinea sobre la fachada real en el recorrido',
            ),
            const SizedBox(height: 8),
            _ZonaCarga(
              titulo: '📷 Foto actual de referencia',
              subtitulo: 'Permite reconocer la fachada con la cámara',
            ),
            const SizedBox(height: 8),
            Text(
              'En rutas públicas se pedirá declarar la fuente y licencia de la imagen histórica.',
              style: TextStyle(fontSize: 10.5, color: colors.muted),
            ),
          ],
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colors.danger,
                    minimumSize: const Size.fromHeight(44),
                  ),
                  child: const Text('Cancelar'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: FilledButton.icon(
                  onPressed: () {
                    final nombre = _nombre.text.trim();
                    if (nombre.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Ingresa el nombre del lugar')),
                      );
                      return;
                    }
                    Navigator.of(context).pop(Destacado(
                      nombre: nombre,
                      tipo: _tipo,
                      descripcion: _descripcion.text.trim(),
                    ));
                  },
                  icon: const Icon(Icons.star, size: 16),
                  label: const Text('Agregar destacado'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OpcionTipo extends StatelessWidget {
  const _OpcionTipo(
      {required this.tipo, required this.seleccionado, required this.onTap});

  final TipoContenido tipo;
  final bool seleccionado;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        decoration: BoxDecoration(
          color: seleccionado ? colors.accentSoft : colors.surface2,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: seleccionado ? colors.accent : colors.line,
            width: seleccionado ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            Text(tipo.icono, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 3),
            Text(
              switch (tipo) {
                TipoContenido.info => 'Información',
                TipoContenido.imagenes => 'Imágenes',
                TipoContenido.edificioHistorico => 'Edificio histórico',
              },
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: colors.ink,
              ),
            ),
            Text(
              tipo.descripcion,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 9.8, color: colors.muted),
            ),
          ],
        ),
      ),
    );
  }
}

class _ZonaCarga extends StatelessWidget {
  const _ZonaCarga({required this.titulo, required this.subtitulo});

  final String titulo;
  final String subtitulo;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: colors.line,
          style: BorderStyle.solid,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12),
        color: colors.surface2,
      ),
      child: Column(
        children: [
          Text(titulo,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12.5)),
          Text(subtitulo,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10.5, color: colors.muted)),
        ],
      ),
    );
  }
}

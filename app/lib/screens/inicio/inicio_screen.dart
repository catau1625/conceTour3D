import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';

/// Fase 1 · Inicio / bienvenida.
///
/// Saludo personalizado, acceso rápido a crear o unirse a un recorrido
/// y menú de usuario. Replica mockups/conceTour3D-fases.html, fase 1.
class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  static const _usuario = 'Catalina';

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _TopBar(colors: colors),
              const SizedBox(height: 34),
              Text(
                'BIENVENIDA',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                  color: colors.muted,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Hola, $_usuario 👋',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                '¿Qué quieres hacer hoy en Concepción?',
                style: TextStyle(color: colors.muted),
              ),
              const SizedBox(height: 14),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _AccionTile(
                        colors: colors,
                        icono: Icons.add,
                        texto: 'Crear recorrido',
                        primario: true,
                        onTap: () => context.push('/crear-ruta'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _AccionTile(
                        colors: colors,
                        icono: Icons.arrow_forward,
                        texto: 'Unirse a recorrido',
                        onTap: () => _proximamente(context),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: _GhostButton(
                      texto: 'Rutas públicas cerca',
                      onTap: () => _proximamente(context),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _GhostButton(
                      texto: 'Ayuda',
                      onTap: () => _proximamente(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _proximamente(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Disponible en una próxima iteración')),
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ConceTour 3D',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.2,
                  ),
            ),
            Text(
              'CONCEPCIÓN · BIOBÍO',
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.6,
                color: colors.muted,
              ),
            ),
          ],
        ),
        PopupMenuButton<String>(
          onSelected: (valor) {
            if (valor == 'salir') {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sesión cerrada (demo)')),
              );
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'perfil', child: Text('👤  Perfil')),
            const PopupMenuItem(value: 'rutas', child: Text('🗺️  Mis rutas')),
            const PopupMenuDivider(),
            PopupMenuItem(
              value: 'salir',
              child: Text(
                '⏻  Cerrar sesión',
                style: TextStyle(color: colors.danger),
              ),
            ),
          ],
          child: CircleAvatar(
            radius: 20,
            backgroundColor: colors.accentSoft,
            child: Text(
              'CU',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: colors.accent,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AccionTile extends StatelessWidget {
  const _AccionTile({
    required this.colors,
    required this.icono,
    required this.texto,
    required this.onTap,
    this.primario = false,
  });

  final AppColorsValues colors;
  final IconData icono;
  final String texto;
  final VoidCallback onTap;
  final bool primario;

  @override
  Widget build(BuildContext context) {
    final fondo = primario ? colors.accent : colors.surface;
    final textoColor = primario ? colors.accentInk : colors.ink;
    final iconoFondo =
        primario ? Colors.white.withValues(alpha: 0.18) : colors.accentSoft;
    final iconoColor = primario ? colors.accentInk : colors.accent;

    return Material(
      color: fondo,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          height: 128,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: colors.line),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: iconoFondo,
                child: Icon(icono, size: 24, color: iconoColor),
              ),
              const SizedBox(height: 10),
              Text(
                texto,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                  color: textoColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GhostButton extends StatelessWidget {
  const _GhostButton({required this.texto, required this.onTap});

  final String texto;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(34),
        side: BorderSide(
          style: BorderStyle.solid,
          color: colors.line,
        ),
        foregroundColor: colors.muted,
        textStyle: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
      ),
      child: Text(texto),
    );
  }
}

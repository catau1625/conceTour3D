import 'package:go_router/go_router.dart';

import '../screens/crear_ruta/crear_ruta_screen.dart';
import '../screens/inicio/inicio_screen.dart';

/// Rutas de la app. Por ahora las fases 1–2; el resto se agrega
/// a medida que se implementan (ver roadmap del README del repo).
final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const InicioScreen(),
    ),
    GoRoute(
      path: '/crear-ruta',
      builder: (context, state) => const CrearRutaScreen(),
    ),
  ],
);

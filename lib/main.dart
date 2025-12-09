import 'package:flutter/material.dart';
import 'package:cinemapedia_220419/config/router/app_router.dart'; // Tu go_router
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cinemapedia_220419/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Cargar variables de entorno
  await dotenv.load(fileName: '.env');

  // Inicializar formato de fechas para español (México)
  await initializeDateFormatting('es_MX', null);

  // Iniciar aplicación
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter, // GoRouter es quien controla las rutas
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
    );
  }
}

import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/catalogo_casos_screen.dart';
import 'screens/detalhe_caso_screen.dart';
import 'screens/exploracao_pistas_screen.dart';
import 'screens/conclusao_caso_screen.dart';
import 'screens/novo_caso_screen.dart';

void main() {
  runApp(const NuclearCaseApp());
}

class NuclearCaseApp extends StatelessWidget {
  const NuclearCaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nuclear Case',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/catalogo': (context) => const CatalogoCasosScreen(),
        '/detalhe-caso': (context) => const DetalheCasoScreen(),
        '/pistas': (context) => const ExploracaoPistasScreen(),
        '/conclusao': (context) => const ConclusaoCasoScreen(),
        '/novo-caso': (context) => const NovoCasoScreen(),
      },
    );
  }
}
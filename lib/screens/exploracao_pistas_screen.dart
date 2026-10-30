import 'package:flutter/material.dart';
import '../models/nuclear_models.dart';
import '../theme/app_theme.dart';

class ExploracaoPistasScreen extends StatefulWidget {
  const ExploracaoPistasScreen({super.key});

  @override
  State<ExploracaoPistasScreen> createState() => _ExploracaoPistasScreenState();
}

class _ExploracaoPistasScreenState extends State<ExploracaoPistasScreen> {
  void _alternarStatusPista(Pista pista) {
    setState(() {
      pista.examinada = !pista.examinada;
    });
  }

  void _marcarTodasComoExaminadas(Caso caso) {
    setState(() {
      for (final pista in caso.pistas) {
        pista.examinada = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final caso = ModalRoute.of(context)!.settings.arguments as Caso;
    final examinadas = caso.totalPistasExaminadas;
    final total = caso.pistas.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sala de Evidências'),
        actions: [
          TextButton.icon(
            onPressed: () => _marcarTodasComoExaminadas(caso),
            icon: const Icon(
              Icons.done_all,
              size: 18,
              color: AppTheme.accentGreen,
            ),
            label: const Text(
              'Analisar Todas',
              style: TextStyle(color: AppTheme.accentGreen, fontSize: 12),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Painel superior que atualiza em tempo real via setState()
          Container(
            color: AppTheme.navySurface,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(
                  Icons.biotech_outlined,
                  color: AppTheme.accentGreen,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        caso.titulo,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppTheme.textLight,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Pistas examinadas: $examinadas de $total',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppTheme.accentGreen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Lista interativa de pistas
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: caso.pistas.length,
              itemBuilder: (context, index) {
                final pista = caso.pistas[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundColor: pista.examinada
                                    ? AppTheme.accentGreen
                                    : AppTheme.navyDark,
                                child: Text(
                                  '${pista.ordem}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: pista.examinada
                                        ? AppTheme.navyDark
                                        : AppTheme.textLight,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  pista.titulo,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.textLight,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: pista.examinada
                                      ? AppTheme.accentGreen
                                          .withValues(alpha: 0.18)
                                      : Colors.amber.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  pista.examinada ? 'EXAMINADA' : 'PENDENTE',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: pista.examinada
                                        ? AppTheme.accentGreen
                                        : Colors.amberAccent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Exibe o conteúdo científico detalhado quando examinada
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppTheme.navyDark.withValues(alpha: 0.65),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              pista.examinada
                                  ? pista.conteudo
                                  : 'Evidência confidencial. Toque no botão abaixo para examinar o laudo científico desta pista.',
                              style: TextStyle(
                                fontSize: 13.5,
                                fontStyle: pista.examinada
                                    ? FontStyle.normal
                                    : FontStyle.italic,
                                color: pista.examinada
                                    ? AppTheme.textLight
                                    : AppTheme.textMuted,
                                height: 1.4,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton.icon(
                              onPressed: () => _alternarStatusPista(pista),
                              icon: Icon(
                                pista.examinada
                                    ? Icons.visibility_off_outlined
                                    : Icons.manage_search,
                                color: AppTheme.accentGreen,
                              ),
                              label: Text(
                                pista.examinada
                                    ? 'Ocultar Evidência'
                                    : 'Examinar Evidência',
                                style: const TextStyle(
                                  color: AppTheme.accentGreen,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Rodapé para avançar direto à conclusão
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/conclusao',
                  arguments: caso,
                );
              },
              icon: const Icon(Icons.gavel_outlined),
              label: const Text('IR PARA CONCLUSÃO DO CASO'),
            ),
          ),
        ],
      ),
    );
  }
}
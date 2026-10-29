import 'package:flutter/material.dart';
import '../models/nuclear_models.dart';
import '../theme/app_theme.dart';

class DetalheCasoScreen extends StatefulWidget {
  const DetalheCasoScreen({super.key});

  @override
  State<DetalheCasoScreen> createState() => _DetalheCasoScreenState();
}

class _DetalheCasoScreenState extends State<DetalheCasoScreen> {
  @override
  Widget build(BuildContext context) {
    // Recebe o objeto Caso enviado por parâmetro na rota nomeada
    final caso = ModalRoute.of(context)!.settings.arguments as Caso;
    final totalPistas = caso.pistas.length;
    final examinadas = caso.totalPistasExaminadas;

    return Scaffold(
      appBar: AppBar(
        title: Text('Dossiê #0${caso.id}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Cabeçalho do Caso
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppTheme.accentGreen.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            caso.icone,
                            size: 36,
                            color: AppTheme.accentGreen,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'CATEGORIA: ${caso.categoria}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.accentGreen,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                caso.titulo,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Situação Investigada:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textLight,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      caso.descricao,
                      style: const TextStyle(
                        fontSize: 14.5,
                        color: AppTheme.textMuted,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Card de Progresso das Pistas
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Progresso da Coleta de Evidências',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textLight,
                          ),
                        ),
                        Text(
                          '$examinadas de $totalPistas',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.accentGreen,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: totalPistas == 0 ? 0 : examinadas / totalPistas,
                      backgroundColor: AppTheme.navyDark,
                      color: AppTheme.accentGreen,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      examinadas == totalPistas
                          ? 'Todas as pistas foram analisadas! Você já tem base científica para registrar seu veredito.'
                          : 'Examine as pistas científicas antes de responder à pergunta final do caso.',
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: AppTheme.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Pergunta Central do Caso
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.navySurface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.accentGreen.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.help_outline,
                    color: AppTheme.accentGreen,
                    size: 26,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Pergunta Investigativa:',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.accentGreen,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          caso.pergunta.enunciado,
                          style: const TextStyle(
                            fontSize: 14.5,
                            color: AppTheme.textLight,
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Botão 1: Ir para Sala de Evidências (Tela 4)
            ElevatedButton.icon(
              onPressed: () async {
                await Navigator.pushNamed(
                  context,
                  '/pistas',
                  arguments: caso,
                );
                setState(() {});
              },
              icon: const Icon(Icons.search),
              label: Text('EXPLORAR PISTAS ($examinadas/$totalPistas)'),
            ),
            const SizedBox(height: 12),

            // Botão 2: Ir para Relatório de Conclusão (Tela 5)
            OutlinedButton.icon(
              onPressed: () async {
                await Navigator.pushNamed(
                  context,
                  '/conclusao',
                  arguments: caso,
                );
                setState(() {});
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.accentGreen,
                side: const BorderSide(color: AppTheme.accentGreen, width: 1.5),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.assignment_turned_in_outlined),
              label: const Text('REGISTRAR CONCLUSÃO DO CASO'),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../data/mock_casos.dart';
import '../models/nuclear_models.dart';
import '../theme/app_theme.dart';

class CatalogoCasosScreen extends StatefulWidget {
  const CatalogoCasosScreen({super.key});

  @override
  State<CatalogoCasosScreen> createState() => _CatalogoCasosScreenState();
}

class _CatalogoCasosScreenState extends State<CatalogoCasosScreen> {
  String _categoriaSelecionada = 'TODOS';

  final List<String> _categorias = [
    'TODOS',
    'ALIMENTACAO',
    'SAUDE',
    'ENERGIA',
  ];

  List<Caso> get _casosFiltrados {
    if (_categoriaSelecionada == 'TODOS') {
      return MockCasosRepository.casos;
    }
    return MockCasosRepository.casos
        .where((caso) => caso.categoria == _categoriaSelecionada)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final listaCasos = _casosFiltrados;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Investigações'),
        actions: [
          IconButton(
            tooltip: 'Sugerir Novo Caso',
            icon: const Icon(Icons.add_circle_outline, color: AppTheme.accentGreen),
            onPressed: () async {
              await Navigator.pushNamed(context, '/novo-caso');
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Barra de filtro por categoria (Gerenciamento de Estado com setState)
          Container(
            color: AppTheme.navySurface,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filtrar por área (${listaCasos.length} caso(s) encontrado(s)):',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.textMuted,
                  ),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _categorias.map((categoria) {
                      final selecionado = _categoriaSelecionada == categoria;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(categoria),
                          selected: selecionado,
                          selectedColor: AppTheme.accentGreen,
                          backgroundColor: AppTheme.navyCard,
                          labelStyle: TextStyle(
                            color: selecionado
                                ? AppTheme.navyDark
                                : AppTheme.textLight,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          onSelected: (_) {
                            setState(() {
                              _categoriaSelecionada = categoria;
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          // Lista de Casos com ListView e Card
          Expanded(
            child: listaCasos.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhum caso encontrado nesta categoria.',
                      style: TextStyle(color: AppTheme.textMuted),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: listaCasos.length,
                    itemBuilder: (context, index) {
                      final caso = listaCasos[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: Card(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(14),
                            onTap: () async {
                              await Navigator.pushNamed(
                                context,
                                '/detalhe-caso',
                                arguments: caso,
                              );
                              setState(() {});
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: AppTheme.accentGreen
                                              .withValues(alpha: 0.15),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Icon(
                                          caso.icone,
                                          color: AppTheme.accentGreen,
                                          size: 28,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              caso.titulo,
                                              style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: AppTheme.textLight,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                _buildBadgeCategoria(
                                                    caso.categoria),
                                                const SizedBox(width: 8),
                                                _buildDificuldade(
                                                    caso.dificuldade),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Icon(
                                        caso.concluido
                                            ? Icons.check_circle
                                            : Icons.arrow_forward_ios,
                                        color: caso.concluido
                                            ? AppTheme.accentGreen
                                            : AppTheme.textMuted,
                                        size: caso.concluido ? 26 : 18,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    caso.descricao,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 13.5,
                                      color: AppTheme.textMuted,
                                      height: 1.35,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.fact_check_outlined,
                                            size: 16,
                                            color: AppTheme.accentGreen,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            'Pistas analisadas: ${caso.totalPistasExaminadas}/${caso.pistas.length}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: AppTheme.textLight,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        caso.concluido
                                            ? 'CASO RESOLVIDO'
                                            : 'EM ABERTO',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: caso.concluido
                                              ? AppTheme.accentGreen
                                              : Colors.amberAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeCategoria(String categoria) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppTheme.navyDark,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.accentGreen.withValues(alpha: 0.4)),
      ),
      child: Text(
        categoria,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: AppTheme.accentGreen,
        ),
      ),
    );
  }

  Widget _buildDificuldade(int nivel) {
    return Row(
      children: List.generate(3, (index) {
        return Icon(
          index < nivel ? Icons.star : Icons.star_border,
          size: 15,
          color: Colors.amberAccent,
        );
      }),
    );
  }
}
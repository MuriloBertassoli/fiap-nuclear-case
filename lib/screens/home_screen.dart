import 'package:flutter/material.dart';
import '../data/mock_casos.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _areasNucleares = const [
    {
      'titulo': 'Medicina',
      'subtitulo': 'Radiofármacos e diagnósticos precisos',
      'icone': Icons.medical_services_outlined,
    },
    {
      'titulo': 'Alimentação',
      'subtitulo': 'Conservação segura por irradiação',
      'icone': Icons.restaurant_menu,
    },
    {
      'titulo': 'Energia Limpa',
      'subtitulo': 'Geração contínua com baixo carbono',
      'icone': Icons.bolt,
    },
    {
      'titulo': 'Pesquisa Naval',
      'subtitulo': 'Ciência e soberania tecnológica',
      'icone': Icons.directions_boat_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final totalCasos = MockCasosRepository.casos.length;
    final casosResolvidos =
        MockCasosRepository.casos.where((c) => c.concluido).length;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.radar, color: AppTheme.accentGreen),
            SizedBox(width: 8),
            Text('NUCLEAR CASE'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Banner Principal / Identidade Visual
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.navyCard, AppTheme.navySurface],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppTheme.accentGreen.withValues(alpha: 0.4),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.accentGreen.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.biotech,
                      size: 56,
                      color: AppTheme.accentGreen,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Descubra o que você não vê.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textLight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Investigação científica interativa sobre as aplicações pacíficas e benefícios da tecnologia nuclear no cotidiano — Challenge FIAP & Marinha do Brasil (CTMSP).',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.textMuted,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildIndicador(
                        icone: Icons.folder_open,
                        valor: '$totalCasos',
                        rotulo: 'Casos Ativos',
                      ),
                      _buildIndicador(
                        icone: Icons.verified_outlined,
                        valor: '$casosResolvidos/$totalCasos',
                        rotulo: 'Concluídos',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Seção com GridView (requisito visual da Sprint)
            const Text(
              'Áreas de Investigação Científica',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textLight,
              ),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _areasNucleares.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.25,
              ),
              itemBuilder: (context, index) {
                final area = _areasNucleares[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          area['icone'] as IconData,
                          size: 32,
                          color: AppTheme.accentGreen,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          area['titulo'] as String,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: AppTheme.textLight,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          area['subtitulo'] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppTheme.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // Botão Principal para ir ao Catálogo
            ElevatedButton.icon(
              onPressed: () async {
                await Navigator.pushNamed(context, '/catalogo');
                setState(() {}); // Atualiza contadores ao retornar
              },
              icon: const Icon(Icons.search),
              label: const Text('INICIAR INVESTIGAÇÕES'),
            ),
            const SizedBox(height: 12),

            // Botão Secundário para sugerir novo caso (Formulário 2)
            OutlinedButton.icon(
              onPressed: () async {
                await Navigator.pushNamed(context, '/novo-caso');
                setState(() {});
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.accentGreen,
                side: const BorderSide(color: AppTheme.accentGreen),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.add_circle_outline),
              label: const Text('SUGERIR NOVO CASO CIENTÍFICO'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicador({
    required IconData icone,
    required String valor,
    required String rotulo,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.navyDark.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icone, color: AppTheme.accentGreen, size: 22),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                valor,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppTheme.textLight,
                ),
              ),
              Text(
                rotulo,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppTheme.textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
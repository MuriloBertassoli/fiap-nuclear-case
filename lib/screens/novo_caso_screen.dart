import 'package:flutter/material.dart';
import '../data/mock_casos.dart';
import '../models/nuclear_models.dart';
import '../theme/app_theme.dart';

class NovoCasoScreen extends StatefulWidget {
  const NovoCasoScreen({super.key});

  @override
  State<NovoCasoScreen> createState() => _NovoCasoScreenState();
}

class _NovoCasoScreenState extends State<NovoCasoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _pistaInicialController = TextEditingController();
  final _explicacaoController = TextEditingController();

  String _categoriaSelecionada = 'ENERGIA';
  int _dificuldadeSelecionada = 1;
  bool _fonteVerificada = true;

  final List<String> _categorias = ['ALIMENTACAO', 'SAUDE', 'ENERGIA'];

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    _pistaInicialController.dispose();
    _explicacaoController.dispose();
    super.dispose();
  }

  IconData _obterIconePorCategoria(String categoria) {
    switch (categoria) {
      case 'ALIMENTACAO':
        return Icons.restaurant_menu;
      case 'SAUDE':
        return Icons.medical_services_outlined;
      default:
        return Icons.bolt;
    }
  }

  void _salvarNovoCaso() {
    if (!_fonteVerificada) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'É necessário confirmar que o caso se baseia em fontes científicas verificadas.',
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      final novoId = MockCasosRepository.casos.length + 1;

      final novoCaso = Caso(
        id: novoId,
        titulo: _tituloController.text.trim(),
        descricao: _descricaoController.text.trim(),
        categoria: _categoriaSelecionada,
        dificuldade: _dificuldadeSelecionada,
        icone: _obterIconePorCategoria(_categoriaSelecionada),
        explicacaoCientifica: _explicacaoController.text.trim(),
        pistas: [
          Pista(
            id: novoId * 100 + 1,
            casoId: novoId,
            ordem: 1,
            titulo: 'Evidência Principal',
            conteudo: _pistaInicialController.text.trim(),
          ),
        ],
        pergunta: Pergunta(
          id: novoId * 200 + 1,
          casoId: novoId,
          enunciado:
              'Qual é a conclusão científica correta sobre o caso "${_tituloController.text.trim()}"?',
          alternativas: [
            Alternativa(
              id: novoId * 300 + 1,
              perguntaId: novoId * 200 + 1,
              texto: _explicacaoController.text.trim(),
              correta: true,
              explicacao:
                  'Correto! Esta conclusão está alinhada com as evidências registadas no caso.',
            ),
            Alternativa(
              id: novoId * 300 + 2,
              perguntaId: novoId * 200 + 1,
              texto:
                  'A tecnologia nuclear não possui aplicação segura ou regulamentada neste contexto.',
              correta: false,
              explicacao:
                  'Incorreto. Revise a pista científica cadastrada para este caso.',
            ),
          ],
        ),
      );

      setState(() {
        MockCasosRepository.casos.add(novoCaso);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Caso "${novoCaso.titulo}" adicionado com sucesso!'),
          backgroundColor: AppTheme.accentTeal,
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sugerir Caso Científico'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Contribuir com Nova Investigação',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textLight,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Adicione um novo mistério educativo ao catálogo do Nuclear Case.',
                style: TextStyle(fontSize: 13.5, color: AppTheme.textMuted),
              ),
              const SizedBox(height: 20),

              // Título do Caso
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(
                  labelText: 'Título Investigativo',
                  hintText: 'Ex: O mistério dos sensores industriais',
                  prefixIcon: Icon(Icons.title, color: AppTheme.accentGreen),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe o título do caso.';
                  }
                  if (valor.trim().length < 5) {
                    return 'O título deve ter pelo menos 5 caracteres.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Categoria e Dificuldade (DropdownButton)
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.navySurface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppTheme.accentGreen.withValues(alpha: 0.35),
                        ),
                      ),
                      child: DropdownButton<String>(
                        value: _categoriaSelecionada,
                        isExpanded: true,
                        dropdownColor: AppTheme.navyCard,
                        underline: const SizedBox(),
                        items: _categorias.map((cat) {
                          return DropdownMenuItem<String>(
                            value: cat,
                            child: Text(cat, style: const TextStyle(fontSize: 13)),
                          );
                        }).toList(),
                        onChanged: (valor) {
                          if (valor != null) {
                            setState(() {
                              _categoriaSelecionada = valor;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.navySurface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppTheme.accentGreen.withValues(alpha: 0.35),
                        ),
                      ),
                      child: DropdownButton<int>(
                        value: _dificuldadeSelecionada,
                        isExpanded: true,
                        dropdownColor: AppTheme.navyCard,
                        underline: const SizedBox(),
                        items: const [
                          DropdownMenuItem(value: 1, child: Text('Dificuldade: 1')),
                          DropdownMenuItem(value: 2, child: Text('Dificuldade: 2')),
                          DropdownMenuItem(value: 3, child: Text('Dificuldade: 3')),
                        ],
                        onChanged: (valor) {
                          if (valor != null) {
                            setState(() {
                              _dificuldadeSelecionada = valor;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Descrição do Caso
              TextFormField(
                controller: _descricaoController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Descrição da Situação / Mistério',
                  hintText: 'Descreva o contexto que o jogador irá investigar...',
                  alignLabelWithHint: true,
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe a descrição do caso.';
                  }
                  if (valor.trim().length < 15) {
                    return 'A descrição deve ter pelo menos 15 caracteres.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Pista Inicial
              TextFormField(
                controller: _pistaInicialController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Pista Científica Inicial',
                  hintText: 'Informe uma evidência que ajude a resolver o caso...',
                  alignLabelWithHint: true,
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Cadastre pelo menos uma pista inicial.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Explicação Científica
              TextFormField(
                controller: _explicacaoController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Explicação Científica Final',
                  hintText: 'Explique o conceito científico por trás da solução...',
                  alignLabelWithHint: true,
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe a explicação científica.';
                  }
                  if (valor.trim().length < 15) {
                    return 'A explicação deve ter pelo menos 15 caracteres.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Switch de Responsabilidade Científica
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.navySurface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        'Conteúdo revisado em fontes científicas confiáveis',
                        style: TextStyle(fontSize: 13, color: AppTheme.textLight),
                      ),
                    ),
                    Switch(
                      value: _fonteVerificada,
                      activeThumbColor: AppTheme.accentGreen,
                      onChanged: (valor) {
                        setState(() {
                          _fonteVerificada = valor;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              ElevatedButton.icon(
                onPressed: _salvarNovoCaso,
                icon: const Icon(Icons.save_outlined),
                label: const Text('CADASTRAR CASO NO CATÁLOGO'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
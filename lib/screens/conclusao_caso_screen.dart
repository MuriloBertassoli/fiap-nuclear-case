import 'package:flutter/material.dart';
import '../models/nuclear_models.dart';
import '../theme/app_theme.dart';

class ConclusaoCasoScreen extends StatefulWidget {
  const ConclusaoCasoScreen({super.key});

  @override
  State<ConclusaoCasoScreen> createState() => _ConclusaoCasoScreenState();
}

class _ConclusaoCasoScreenState extends State<ConclusaoCasoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _investigadorController = TextEditingController();
  final _justificativaController = TextEditingController();

  int? _alternativaSelecionadaId;
  String _grauConfianca = 'Alto';
  bool _confirmouLeituraPistas = false;

  final List<String> _niveisConfianca = [
    'Alto',
    'Médio',
    'Inicial (em dúvida)',
  ];

  @override
  void dispose() {
    _investigadorController.dispose();
    _justificativaController.dispose();
    super.dispose();
  }

  void _submeterConclusao(Caso caso) {
    if (_alternativaSelecionadaId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, selecione uma alternativa para a pergunta do caso.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    if (!_confirmouLeituraPistas) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Confirme a caixa de revisão científica antes de enviar.'),
          backgroundColor: Colors.orangeAccent,
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      final alternativaEscolhida = caso.pergunta.alternativas.firstWhere(
        (alt) => alt.id == _alternativaSelecionadaId,
      );

      setState(() {
        if (alternativaEscolhida.correta) {
          caso.concluido = true;
        }
      });

      // Exibe feedback rápido via SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            alternativaEscolhida.correta
                ? 'Relatório validado! Conclusão científica correta.'
                : 'Relatório analisado. Revise a explicação científica do caso.',
          ),
          backgroundColor: alternativaEscolhida.correta
              ? AppTheme.accentTeal
              : Colors.amber.shade800,
        ),
      );

      // Exibe o resultado detalhado e explicação científica via Dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppTheme.navySurface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: alternativaEscolhida.correta
                    ? AppTheme.accentGreen
                    : Colors.amberAccent,
              ),
            ),
            title: Row(
              children: [
                Icon(
                  alternativaEscolhida.correta
                      ? Icons.verified
                      : Icons.info_outline,
                  color: alternativaEscolhida.correta
                      ? AppTheme.accentGreen
                      : Colors.amberAccent,
                  size: 28,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    alternativaEscolhida.correta
                        ? 'Caso Solucionado!'
                        : 'Análise Incompleta',
                    style: const TextStyle(
                      color: AppTheme.textLight,
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  ),
                ),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Investigador(a): ${_investigadorController.text.trim()} (Confiança: $_grauConfianca)',
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: AppTheme.accentGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Feedback da sua resposta:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textLight,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    alternativaEscolhida.explicacao,
                    style: const TextStyle(
                      color: AppTheme.textMuted,
                      fontSize: 13.5,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.navyDark,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Explicação Científica Completa:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: AppTheme.accentGreen,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          caso.explicacaoCientifica,
                          style: const TextStyle(
                            color: AppTheme.textLight,
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Fecha o Dialog
                },
                child: const Text(
                  'REVISAR RESPOSTA',
                  style: TextStyle(color: AppTheme.textMuted),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Fecha o Dialog
                  Navigator.popUntil(
                    context,
                    ModalRoute.withName('/catalogo'),
                  );
                },
                child: const Text('VOLTAR AO CATÁLOGO'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final caso = ModalRoute.of(context)!.settings.arguments as Caso;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatório de Conclusão'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Pergunta Central do Caso
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CASO: ${caso.titulo.toUpperCase()}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.accentGreen,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        caso.pergunta.enunciado,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textLight,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Seleção de Alternativas
              const Text(
                '1. Selecione a sua conclusão científica:',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textLight,
                ),
              ),
              const SizedBox(height: 10),
              ...caso.pergunta.alternativas.map((alternativa) {
                final selecionada = _alternativaSelecionadaId == alternativa.id;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      setState(() {
                        _alternativaSelecionadaId = alternativa.id;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: selecionada
                            ? AppTheme.accentGreen.withValues(alpha: 0.15)
                            : AppTheme.navySurface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: selecionada
                              ? AppTheme.accentGreen
                              : AppTheme.textMuted.withValues(alpha: 0.3),
                          width: selecionada ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            selecionada
                                ? Icons.radio_button_checked
                                : Icons.radio_button_unchecked,
                            color: selecionada
                                ? AppTheme.accentGreen
                                : AppTheme.textMuted,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              alternativa.texto,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppTheme.textLight,
                                fontWeight: selecionada
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                height: 1.35,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 16),

              // Campo 1: Identificação do Investigador (TextFormField validado)
              const Text(
                '2. Registo do Investigador:',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textLight,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _investigadorController,
                decoration: const InputDecoration(
                  labelText: 'Nome ou Codinome do Investigador',
                  hintText: 'Ex: Agente Silva',
                  prefixIcon: Icon(Icons.badge_outlined, color: AppTheme.accentGreen),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe o nome do investigador.';
                  }
                  if (valor.trim().length < 3) {
                    return 'O nome deve ter pelo menos 3 caracteres.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Campo 2: DropdownButton para grau de confiança
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.navySurface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.accentGreen.withValues(alpha: 0.35),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.speed, color: AppTheme.accentGreen),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Grau de confiança na resposta:',
                        style: TextStyle(color: AppTheme.textMuted, fontSize: 14),
                      ),
                    ),
                    DropdownButton<String>(
                      value: _grauConfianca,
                      dropdownColor: AppTheme.navyCard,
                      underline: const SizedBox(),
                      style: const TextStyle(
                        color: AppTheme.accentGreen,
                        fontWeight: FontWeight.bold,
                      ),
                      items: _niveisConfianca.map((nivel) {
                        return DropdownMenuItem<String>(
                          value: nivel,
                          child: Text(nivel),
                        );
                      }).toList(),
                      onChanged: (novoValor) {
                        if (novoValor != null) {
                          setState(() {
                            _grauConfianca = novoValor;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Campo 3: Justificativa / Hipótese Científica (TextFormField validado)
              TextFormField(
                controller: _justificativaController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Análise / Justificativa Científica',
                  hintText: 'Explique brevemente o porquê da sua conclusão com base nas pistas...',
                  alignLabelWithHint: true,
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Registe a sua justificativa sobre o caso.';
                  }
                  if (valor.trim().length < 10) {
                    return 'Escreva uma justificativa com pelo menos 10 caracteres.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Campo 4: Checkbox de confirmação
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.navySurface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Checkbox(
                      value: _confirmouLeituraPistas,
                      activeColor: AppTheme.accentGreen,
                      checkColor: AppTheme.navyDark,
                      onChanged: (valor) {
                        setState(() {
                          _confirmouLeituraPistas = valor ?? false;
                        });
                      },
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                        child: Text(
                          'Confirmo que avaliei as evidências científicas deste dossiê antes de emitir o veredito.',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppTheme.textLight,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              // Botão de Envio do Formulário
              ElevatedButton.icon(
                onPressed: () => _submeterConclusao(caso),
                icon: const Icon(Icons.send_outlined),
                label: const Text('ENVIAR CONCLUSÃO E VER RESULTADO'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../models/nuclear_models.dart';

class MockCasosRepository {
  static final List<Caso> casos = [
    Caso(
      id: 1,
      titulo: 'O alimento radioativo?',
      descricao:
          'Um lote de morangos passou por um processo de irradiação controlada antes de chegar ao supermercado. Consumidores estão em dúvida: comer essa fruta oferece risco de radiação?',
      categoria: 'ALIMENTACAO',
      dificuldade: 1,
      icone: Icons.restaurant_menu,
      explicacaoCientifica:
          'A irradiação de alimentos utiliza feixes de energia (como raios gama, raios X ou elétrons) para eliminar microrganismos, pragas e retardar o apodrecimento. Assim como passar por um raio-X médico não torna o corpo humano radioativo, o alimento irradiado não entra em contato direto com fontes radioativas e não retém radioatividade.',
      pistas: [
        Pista(
          id: 101,
          casoId: 1,
          ordem: 1,
          titulo: 'Laudo do Laboratório Agrícola',
          conteudo:
              'Os morangos foram expostos a uma fonte controlada de energia por poucos minutos, sem qualquer contato físico com poeira ou material radioativo.',
        ),
        Pista(
          id: 102,
          casoId: 1,
          ordem: 2,
          titulo: 'Comparação com a Luz Solar e Raio-X',
          conteudo:
              'A energia atravessa o alimento de forma semelhante à luz atravessando uma janela ou a um exame de raio-X: ela cumpre sua função esterilizante e não permanece acumulada no produto.',
        ),
        Pista(
          id: 103,
          casoId: 1,
          ordem: 3,
          titulo: 'Análise Microbiológica e de Conservação',
          conteudo:
              'O lote irradiado apresentou redução drástica de fungos e bactérias, aumentando a validade sem necessidade de conservantes químicos adicionais.',
        ),
      ],
      pergunta: Pergunta(
        id: 201,
        casoId: 1,
        enunciado:
            'Com base nas pistas analisadas, um alimento irradiado se torna radioativo?',
        alternativas: [
          Alternativa(
            id: 301,
            perguntaId: 201,
            texto:
                'Não. A irradiação apenas atravessa o alimento para eliminar microrganismos, sem torná-lo radioativo.',
            correta: true,
            explicacao:
                'Correto! Irradiação é diferente de contaminação radioativa. O processo é seguro e reconhecido por órgãos internacionais de saúde.',
          ),
          Alternativa(
            id: 302,
            perguntaId: 201,
            texto:
                'Sim, mas a radioatividade desaparece se o alimento for lavado em água corrente.',
            correta: false,
            explicacao:
                'Incorreto. O alimento não fica radioativo em nenhum momento do processo de irradiação comercial.',
          ),
          Alternativa(
            id: 303,
            perguntaId: 201,
            texto:
                'Sim, qualquer exposição à tecnologia nuclear transfere átomos radioativos para a fruta.',
            correta: false,
            explicacao:
                'Incorreto. A exposição controlada apenas transfere energia para inativar pragas e bactérias, sem alterar a radioatividade natural do alimento.',
          ),
        ],
      ),
    ),
    Caso(
      id: 2,
      titulo: 'O segredo do diagnóstico',
      descricao:
          'Um paciente precisa investigar o funcionamento metabólico de um órgão interno sem realizar uma cirurgia invasiva. Como a medicina nuclear pode revelar o que está acontecendo em tempo real?',
      categoria: 'SAUDE',
      dificuldade: 2,
      icone: Icons.medical_services_outlined,
      explicacaoCientifica:
          'Na medicina nuclear, pequenas quantidades de substâncias chamadas radiofármacos são administradas ao paciente. Elas se concentram no órgão-alvo e emitem sinais leves que são captados por câmeras especiais (como no exame de cintilografia ou PET-CT), permitindo avaliar a função biológica do tecido com alta precisão e segurança.',
      pistas: [
        Pista(
          id: 104,
          casoId: 2,
          ordem: 1,
          titulo: 'O Papel do Radiofármaco',
          conteudo:
              'Diferente de um contraste comum, o radiofármaco possui afinidade química com tecidos específicos e emite um sinal detectável externamente em doses rigorosamente calculadas.',
        ),
        Pista(
          id: 105,
          casoId: 2,
          ordem: 2,
          titulo: 'Meia-Vida Curta',
          conteudo:
              'Os elementos utilizados para diagnóstico médico possuem meia-vida muito curta (geralmente poucas horas), decaindo rapidamente e sendo eliminados naturalmente pelo organismo.',
        ),
        Pista(
          id: 106,
          casoId: 2,
          ordem: 3,
          titulo: 'Imagem Funcional vs. Anatômica',
          conteudo:
              'Enquanto uma radiografia comum mostra apenas o formato dos ossos, o exame nuclear mostra se o órgão está metabolicamente ativo e funcionando bem.',
        ),
      ],
      pergunta: Pergunta(
        id: 202,
        casoId: 2,
        enunciado:
            'Como a tecnologia nuclear auxilia no diagnóstico médico por imagem?',
        alternativas: [
          Alternativa(
            id: 304,
            perguntaId: 202,
            texto:
                'Utilizando radiofármacos de meia-vida curta que permitem visualizar o funcionamento de órgãos em tempo real.',
            correta: true,
            explicacao:
                'Exato! Os radiofármacos funcionam como traçadores seguros que revelam a atividade fisiológica do corpo sem cirurgia.',
          ),
          Alternativa(
            id: 305,
            perguntaId: 202,
            texto:
                'Substituindo completamente todos os exames de sangue e ultrassom em qualquer situação clínica.',
            correta: false,
            explicacao:
                'Incorreto. A medicina nuclear é complementar e indicada para investigações funcionais específicas, sob prescrição médica.',
          ),
          Alternativa(
            id: 306,
            perguntaId: 202,
            texto:
                'Aquecendo os órgãos internos para gerar fotografias térmicas na superfície da pele.',
            correta: false,
            explicacao:
                'Incorreto. A imagem é formada pela captação da radiação leve emitida pelo traçador, e não por aquecimento térmico.',
          ),
        ],
      ),
    ),
    Caso(
      id: 3,
      titulo: 'O futuro energético',
      descricao:
          'Um conselho municipal está avaliando matrizes elétricas para abastecer uma região industrial e hospitalar 24 horas por dia, buscando baixa emissão de gases de efeito estufa. Quais fatores devem ser pesados sobre a energia nuclear?',
      categoria: 'ENERGIA',
      dificuldade: 3,
      icone: Icons.bolt,
      explicacaoCientifica:
          'As usinas nucleares geram eletricidade de base (contínua, não dependente de chuva, sol ou vento) com baixíssima emissão de carbono durante a operação. Por outro lado, exigem rigorosos protocolos de segurança, alto investimento inicial e gestão técnica de longo prazo para os rejeitos radioativos.',
      pistas: [
        Pista(
          id: 107,
          casoId: 3,
          ordem: 1,
          titulo: 'Estabilidade da Geração (Energia de Base)',
          conteudo:
              'Ao contrário de fontes intermitentes, uma usina termonuclear opera continuamente dia e noite, garantindo estabilidade para hospitais e indústrias.',
        ),
        Pista(
          id: 108,
          casoId: 3,
          ordem: 2,
          titulo: 'Balanço de Emissões de Carbono',
          conteudo:
              'A fissão nuclear não queima combustíveis fósseis como carvão ou gás, evitando a emissão direta de CO2 na atmosfera durante a geração elétrica.',
        ),
        Pista(
          id: 109,
          casoId: 3,
          ordem: 3,
          titulo: 'Desafios e Responsabilidades',
          conteudo:
              'O planejamento exige licenciamento rigoroso, múltiplas barreiras físicas de contenção, fiscalização constante e armazenamento seguro dos resíduos gerados.',
        ),
      ],
      pergunta: Pergunta(
        id: 203,
        casoId: 3,
        enunciado:
            'Qual é a avaliação cientificamente equilibrada sobre o uso da energia nuclear na matriz elétrica?',
        alternativas: [
          Alternativa(
            id: 307,
            perguntaId: 203,
            texto:
                'Oferece geração contínua e baixa emissão de carbono, mas exige alto rigor em segurança, custos elevados e gestão responsável de rejeitos.',
            correta: true,
            explicacao:
                'Perfeito! A análise científica considera tanto os grandes benefícios de estabilidade e descarbonização quanto as exigências técnicas e de segurança.',
          ),
          Alternativa(
            id: 308,
            perguntaId: 203,
            texto:
                'É uma fonte que não gera nenhum tipo de resíduo nem precisa de fiscalização especial após construída.',
            correta: false,
            explicacao:
                'Incorreto. Toda instalação nuclear requer regulação estrita e gerenciamento técnico permanente de seus rejeitos.',
          ),
          Alternativa(
            id: 309,
            perguntaId: 203,
            texto:
                'É uma das maiores emissoras de fumaça de gás carbônico devido à queima de urânio nas torres de resfriamento.',
            correta: false,
            explicacao:
                'Incorreto. O urânio não é queimado como carvão, e o que sai das torres de resfriamento é apenas vapor de água limpa.',
          ),
        ],
      ),
    ),
  ];
}
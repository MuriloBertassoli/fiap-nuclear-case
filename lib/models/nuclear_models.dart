import 'package:flutter/material.dart';

class Alternativa {
  final int id;
  final int perguntaId;
  final String texto;
  final bool correta;
  final String explicacao;

  Alternativa({
    required this.id,
    required this.perguntaId,
    required this.texto,
    required this.correta,
    required this.explicacao,
  });
}

class Pergunta {
  final int id;
  final int casoId;
  final String enunciado;
  final List<Alternativa> alternativas;

  Pergunta({
    required this.id,
    required this.casoId,
    required this.enunciado,
    required this.alternativas,
  });
}

class Pista {
  final int id;
  final int casoId;
  final String titulo;
  final String conteudo;
  final int ordem;
  bool examinada;

  Pista({
    required this.id,
    required this.casoId,
    required this.titulo,
    required this.conteudo,
    required this.ordem,
    this.examinada = false,
  });
}

class Caso {
  final int id;
  final String titulo;
  final String descricao;
  final String categoria;
  final int dificuldade;
  final String explicacaoCientifica;
  final IconData icone;
  final List<Pista> pistas;
  final Pergunta pergunta;
  bool concluido;

  Caso({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.categoria,
    required this.dificuldade,
    required this.explicacaoCientifica,
    required this.icone,
    required this.pistas,
    required this.pergunta,
    this.concluido = false,
  });

  int get totalPistasExaminadas =>
      pistas.where((pista) => pista.examinada).length;
}
# Nuclear Case — Descubra o que você não vê

Aplicativo mobile educativo desenvolvido em **Flutter e Dart** para a **1ª Sprint do Challenge 2026** da FIAP.

---

## 👥 Integrantes da Equipe

* **Murilo Massini** — RM: 567383
* **Giovanni Sacristan** — RM: 567548
* **Gabriel Deotti** — RM: 567258

---

## ⚓ Empresa / Parceiro Relacionado ao Projeto

* **Parceiro:** Marinha do Brasil / Centro Tecnológico da Marinha em São Paulo (CTMSP) — Challenge FIAP 2026 (2º Ano ADS).

---

## 📖 Descrição Resumida da Solução

O **Nuclear Case** é um jogo educativo de investigação científica criado para aproximar a sociedade das aplicações pacíficas e dos benefícios da tecnologia nuclear (como medicina diagnóstica, conservação de alimentos por irradiação e geração de energia limpa).

Em vez de um quiz convencional, o usuário assume o papel de um investigador científico:
1. Explora um **Catálogo de Investigações** categorizado por área e nível de dificuldade;
2. Acessa o **Dossiê do Caso** com a pergunta investigativa central;
3. Examina evidências interativas na **Sala de Evidências**, acompanhando o progresso das pistas analisadas em tempo real (`StatefulWidget` e `setState()`);
4. Emite seu veredito no **Relatório de Conclusão**, preenchendo um formulário validado e recebendo feedback imediato com a explicação científica detalhada (`Dialog` e `SnackBar`);
5. Pode contribuir cadastrando novos mistérios científicos através da tela **Sugerir Caso Científico**.

---

## 🛠️ Tecnologias Utilizadas

* **Flutter** (SDK 3.x / Material Design 3)
* **Dart**
* **Gerenciamento de Estado:** `StatefulWidget` e `setState()`
* **Navegação:** Rotas nomeadas (`Navigator.pushNamed` e passagem de objetos via `ModalRoute.of(context)!.settings.arguments`)
* **Validação de Formulários:** `Form`, `GlobalKey<FormState>`, `TextFormField`, `DropdownButton`, `Checkbox`, `Switch`, `AlertDialog` e `SnackBar`
* **Controle de Versão:** Git e GitHub Classroom

---

## 📱 Estrutura de Telas do Aplicativo

1. **Tela Inicial (`/` - `HomeScreen`):** Apresentação visual do projeto, indicadores de progresso e `GridView` com as 4 áreas de aplicação da tecnologia nuclear.
2. **Catálogo de Investigações (`/catalogo` - `CatalogoCasosScreen`):** Lista de casos em `ListView` e `Card` com filtro dinâmico por categoria (`TODOS`, `ALIMENTACAO`, `SAUDE`, `ENERGIA`).
3. **Dossiê do Caso (`/detalhe-caso` - `DetalheCasoScreen`):** Detalhamento do mistério selecionado por parâmetro, barra de progresso de evidências e pergunta investigativa.
4. **Sala de Evidências (`/pistas` - `ExploracaoPistasScreen`):** Exploração interativa das pistas científicas com atualização dinâmica de estado (`EXAMINADA` / `PENDENTE`) e contador em tempo real.
5. **Relatório de Conclusão (`/conclusao` - `ConclusaoCasoScreen`):** Formulário validado para envio da resposta do caso, identificação do investigador, grau de confiança e exibição do veredito científico em `AlertDialog`.
6. **Sugerir Caso Científico (`/novo-caso` - `NovoCasoScreen`):** Formulário validado para inclusão dinâmica de novos casos investigativos em memória.

---

## 🚀 Instruções Básicas para Execução

1. **Pré-requisitos:** Certifique-se de ter o [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado e um emulador Android (Android Studio) ou dispositivo físico conectado.
2. **Clonar o repositório:**
   ```bash
   git clone <URL_DO_REPOSITORIO_GITHUB_CLASSROOM>
   cd <PASTA_DO_PROJETO>

   Caso de erro na hora de rodar, verificar a versao do sdk no pubspec.yaml, mudar de 3.13.1 para 3.10.0
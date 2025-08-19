Mestre das Notas 🎓
Sobre o Projeto
O Mestre das Notas é um sistema de gerenciamento de notas escolares desenvolvido em Dart, utilizando a filosofia de Orientação a Objetos (POO). 🚀 O objetivo principal é fornecer uma ferramenta de linha de comando robusta para registrar, calcular e gerenciar o desempenho acadêmico de alunos, com todos os dados persistidos em um banco de dados MySQL.

🚀 Funcionalidades Chave
O sistema opera através de um menu interativo e oferece as seguintes funcionalidades essenciais:

Cadastros e Registros ✍️

[1] Registrar Aluno: Adiciona um novo estudante com seus dados completos.

[7] Registrar Nota: Atribui uma nota a um aluno para uma disciplina específica.

Consultas e Relatórios 📊

[2] Listar Notas de Todos os Alunos: Exibe um relatório detalhado de todas as notas.

[3] Calcular Média: Calcula a média geral de um aluno.

[4] Verificar Aprovação: Determina se um aluno está Aprovado (média ≥ 7) ou Reprovado (média < 7).

[5] Listar Aprovados: Mostra todos os alunos que foram aprovados.

[6] Listar Reprovados: Mostra todos os alunos que foram reprovados.

Gerenciamento de Dados 🛠️

[8] Editar Aluno: Permite atualizar os dados de um estudante.

[9] Excluir Aluno: Remove um aluno e todas as suas notas do sistema.

[10] Excluir Nota: Deleta uma nota específica de um aluno.

Pré-Requisitos
Para executar o projeto, você precisará dos seguintes componentes instalados e configurados:

SDK do Dart: Versão 3.0+

Servidor MySQL: Uma instância do MySQL em execução.

Dependências do Dart: A biblioteca mysql1 para comunicação com o banco de dados.

📁 Estrutura do Projeto
O projeto é organizado de forma modular para facilitar a manutenção e o desenvolvimento:

bin/: Contém o arquivo executável principal (mestre_das_notas.dart).

lib/: Armazena a lógica central do sistema.

gerenciador.dart: A classe central que gerencia todas as operações de banco de dados (CRUD).

menu/: Contém o menu interativo (menu_principal.dart) que guia a experiência do usuário.

aluno/: Define a classe Aluno.

disciplina/: Define a classe Disciplina.

⚙️ Como Executar
Clone o Repositório 📂
git clone https://www.dio.me/articles/enviando-seu-projeto-para-o-github
cd mestre-das-notas

Configure o Banco de Dados 🖥️

Inicie o seu servidor MySQL.

Importe o arquivo .sql fornecido para criar as tabelas necessárias (mestre_das_notas.sql).

Instale as Dependências 📦
dart pub get

Inicie a Aplicação ⚡
dart run

🤝 Contribuição
Contribuições são muito bem-vindas! Se você tiver ideias para novas funcionalidades, melhorias no código ou encontrar algum bug, sinta-se à vontade para abrir uma issue ou enviar um pull request.

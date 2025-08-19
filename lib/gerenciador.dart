// lib/gerenciador.dart

import 'dart:io';
import 'package:mysql1/mysql1.dart';

class Gerenciador {
  final MySqlConnection conn;

  // O construtor recebe a conexão com o banco de dados
  Gerenciador(this.conn);

  // Método para registrar um novo aluno no banco de dados
  Future<void> registrarAluno() async {
    print('\n--- Registro de Aluno ---');

    // 1. Coletar dados do aluno
    stdout.write('Digite o nome do aluno: ');
    String? nome = stdin.readLineSync();

    stdout.write('Digite a matrícula: ');
    String? matricula = stdin.readLineSync();

    stdout.write('Digite a data de nascimento (YYYY-MM-DD): ');
    String? dataNascimento = stdin.readLineSync();

    stdout.write('Digite o CPF: ');
    String? cpf = stdin.readLineSync();

    stdout.write('Digite o email: ');
    String? email = stdin.readLineSync();

    // 2. Tratar erros de entrada
    if (nome == null ||
        nome.isEmpty ||
        matricula == null ||
        matricula.isEmpty) {
      print('⚠️ Erro: Nome e matrícula não podem ser vazios.');
      return;
    }

    // 3. Verificar se o aluno já existe (usando matrícula ou CPF)
    try {
      var resultados = await conn.query(
        'SELECT COUNT(*) FROM alunos WHERE matricula = ? OR cpf = ?',
        [matricula, cpf],
      );

      // CORREÇÃO: Verifique se o resultado não é nulo e converta o tipo
      int count = 0;
      if (resultados.isNotEmpty && resultados.first.values != null) {
        // Obtenha o valor da primeira coluna (COUNT(*)) e converta para int
        count = (resultados.first.values![0] as int);
      }

      if (count > 0) {
        print('⚠️ Erro: Já existe um aluno com esta matrícula ou CPF.');
        return;
      }
    } catch (e) {
      print('❌ Erro ao verificar aluno: $e');
      return;
    }

    // 4. Inserir o novo aluno no banco de dados
    try {
      await conn.query(
        'INSERT INTO alunos (nome, matricula, data_nascimento, cpf, email) VALUES (?, ?, ?, ?, ?)',
        [nome, matricula, dataNascimento, cpf, email],
      );
      print('✅ Aluno "$nome" cadastrado com sucesso!');
    } catch (e) {
      print('❌ Erro ao cadastrar aluno: $e');
    }
  }

  // Futuras implementações para os outros métodos virão aqui...

  // --- Funções Adicionadas ---

  // Funcionalidade 2 e 7: Registrar nota para um aluno
  Future<void> registrarNota() async {
    print('\n--- Registro de Nota ---');
    stdout.write('Digite a matrícula do aluno: ');
    String? matricula = stdin.readLineSync();

    if (matricula == null || matricula.isEmpty) {
      print('⚠️ Erro: A matrícula não pode ser vazia.');
      return;
    }

    try {
      // 1. Encontrar o aluno pelo ID
      var alunoResult = await conn.query(
        'SELECT id, nome FROM alunos WHERE matricula = ?',
        [matricula],
      );

      if (alunoResult.isEmpty) {
        print('⚠️ Erro: Aluno com a matrícula $matricula não encontrado.');
        return;
      }
      final alunoId = alunoResult.first['id'];
      final nomeAluno = alunoResult.first['nome'];
      print('Aluno selecionado: $nomeAluno');

      // 2. Coletar dados da nota
      stdout.write('Digite o nome da disciplina: ');
      String? nomeDisciplina = stdin.readLineSync();
      stdout.write('Digite a nota (0-10): ');
      String? notaString = stdin.readLineSync();

      if (nomeDisciplina == null || notaString == null) {
        print('⚠️ Erro: Disciplina e nota não podem ser vazios.');
        return;
      }
      double nota = double.parse(notaString);

      // 3. Validar a nota
      if (nota < 0 || nota > 10) {
        print('⚠️ Erro: A nota deve estar entre 0 e 10.');
        return;
      }

      // 4. Inserir a nota no banco de dados
      // Esta parte requer que a tabela 'materias' ou 'disciplinas' exista e contenha o nome da disciplina.
      // Assumindo que você tem uma tabela 'materias', precisamos buscar o ID da materia.
      var materiaResult = await conn.query(
        'SELECT id FROM materias WHERE nome = ?',
        [nomeDisciplina],
      );
      if (materiaResult.isEmpty) {
        print(
          '⚠️ Erro: Disciplina não encontrada. Certifique-se de que a disciplina foi cadastrada no banco de dados.',
        );
        return;
      }
      final materiaId = materiaResult.first['id'];

      await conn.query(
        'INSERT INTO notas (aluno_id, materia_id, nota) VALUES (?, ?, ?)',
        [alunoId, materiaId, nota],
      );
      print(
        '✅ Nota $nota para $nomeDisciplina de $nomeAluno registrada com sucesso!',
      );
    } catch (e) {
      print('❌ Erro ao registrar nota: $e');
    }
  }

  // Funcionalidade 3: Calcular a média de um aluno
  Future<void> calcularMediaAluno() async {
    print('\n--- Calcular Média de Aluno ---');
    stdout.write('Digite a matrícula do aluno: ');
    String? matricula = stdin.readLineSync();
    if (matricula == null || matricula.isEmpty) return;

    try {
      var resultados = await conn.query(
        'SELECT AVG(n.nota) AS media FROM notas n JOIN alunos a ON n.aluno_id = a.id WHERE a.matricula = ?',
        [matricula],
      );

      final media = resultados.first['media'];
      if (media != null) {
        print(
          'Média do aluno com matrícula $matricula é: ${media.toStringAsFixed(2)}',
        );
      } else {
        print('Aluno com matrícula $matricula não possui notas registradas.');
      }
    } catch (e) {
      print('❌ Erro ao calcular média: $e');
    }
  }

  // Funcionalidade 4: Verificar aprovação de um aluno
  Future<void> verificarAprovacaoAluno() async {
    print('\n--- Verificar Aprovação ---');
    stdout.write('Digite a matrícula do aluno: ');
    String? matricula = stdin.readLineSync();
    if (matricula == null || matricula.isEmpty) return;

    try {
      var resultados = await conn.query(
        'SELECT AVG(n.nota) AS media FROM notas n JOIN alunos a ON n.aluno_id = a.id WHERE a.matricula = ?',
        [matricula],
      );
      final media = resultados.first['media'];

      if (media == null) {
        print('Aluno com matrícula $matricula não possui notas.');
      } else if (media >= 7.0) {
        print(
          '✅ Aluno com matrícula $matricula está APROVADO com média ${media.toStringAsFixed(2)}.',
        );
      } else {
        print(
          '❌ Aluno com matrícula $matricula está REPROVADO com média ${media.toStringAsFixed(2)}.',
        );
      }
    } catch (e) {
      print('❌ Erro ao verificar aprovação: $e');
    }
  }

  // Funcionalidade 5 e 6: Listar alunos aprovados/reprovados
  Future<void> listarAprovadosReprovados(bool isAprovado) async {
    final status = isAprovado ? 'Aprovados' : 'Reprovados';
    print('\n--- Listar Alunos $status ---');
    try {
      var resultados = await conn.query(
        'SELECT a.nome, AVG(n.nota) AS media '
        'FROM alunos a JOIN notas n ON a.id = n.aluno_id '
        'GROUP BY a.id '
        'HAVING AVG(n.nota) ${isAprovado ? '>= 7.0' : '< 7.0'}',
      );

      if (resultados.isEmpty) {
        print('Nenhum aluno $status encontrado.');
        return;
      }

      for (var row in resultados) {
        print(
          'Nome: ${row['nome']}, Média: ${row['media'].toStringAsFixed(2)}',
        );
      }
    } catch (e) {
      print('❌ Erro ao listar alunos: $e');
    }
  }

  // Funcionalidade 2: Listar notas de todos os alunos
  Future<void> listarNotasTodosAlunos() async {
    print('\n--- Lista de Notas de Todos os Alunos ---');

    try {
      // 1. Consulta para buscar todos os alunos, notas e matérias.
      var resultados = await conn.query('''
        SELECT
          a.nome AS nome_aluno,
          m.nome AS nome_materia,
          n.nota
        FROM alunos a
        JOIN notas n ON a.id = n.aluno_id
        JOIN materias m ON n.materia_id = m.id
        ORDER BY a.nome, m.nome
        ''');

      // 2. Organizar os resultados para exibição
      // Usaremos um mapa para agrupar as notas por aluno.
      final Map<String, List<Map<String, dynamic>>> alunosNotas = {};
      for (var row in resultados) {
        final nomeAluno = row['nome_aluno'] as String;
        final nomeMateria = row['nome_materia'] as String;
        final nota = row['nota'] as double;

        if (!alunosNotas.containsKey(nomeAluno)) {
          alunosNotas[nomeAluno] = [];
        }
        alunosNotas[nomeAluno]!.add({'materia': nomeMateria, 'nota': nota});
      }

      // 3. Exibir os resultados
      if (alunosNotas.isEmpty) {
        print('Nenhum aluno ou nota encontrada.');
        return;
      }

      alunosNotas.forEach((nomeAluno, notas) {
        print('\nAluno: $nomeAluno');
        for (var notaInfo in notas) {
          final nomeMateria = notaInfo['materia'];
          final nota = notaInfo['nota'];
          print('  - $nomeMateria: $nota');
        }
      });
    } catch (e) {
      print('❌ Erro ao listar notas: $e');
    }
  }

  // --- Funções de Edição e Exclusão ---

  // Editar dados de um aluno
  Future<void> editarAluno() async {
    print('\n--- Editar Dados do Aluno ---');
    stdout.write('Digite a matrícula do aluno que deseja editar: ');
    String? matricula = stdin.readLineSync();

    if (matricula == null || matricula.isEmpty) {
      print('⚠️ Erro: Matrícula não pode ser vazia.');
      return;
    }

    try {
      var alunoResult = await conn.query(
        'SELECT id, nome FROM alunos WHERE matricula = ?',
        [matricula],
      );
      if (alunoResult.isEmpty) {
        print('⚠️ Erro: Aluno com a matrícula $matricula não encontrado.');
        return;
      }
      final alunoId = alunoResult.first['id'];

      print('\nAluno encontrado: ${alunoResult.first['nome']}');
      print('O que você deseja editar?');
      print('[1] Nome');
      print('[2] Data de Nascimento');
      print('[3] CPF');
      print('[4] Email');
      stdout.write('Escolha uma opção: ');

      String? opcao = stdin.readLineSync();
      String? novoValor;
      String campo = '';

      switch (opcao) {
        case '1':
          campo = 'nome';
          stdout.write('Digite o novo nome: ');
          novoValor = stdin.readLineSync();
          break;
        case '2':
          campo = 'data_nascimento';
          stdout.write('Digite a nova data de nascimento (YYYY-MM-DD): ');
          novoValor = stdin.readLineSync();
          break;
        case '3':
          campo = 'cpf';
          stdout.write('Digite o novo CPF: ');
          novoValor = stdin.readLineSync();
          break;
        case '4':
          campo = 'email';
          stdout.write('Digite o novo email: ');
          novoValor = stdin.readLineSync();
          break;
        default:
          print('Opção inválida.');
          return;
      }

      if (novoValor != null && novoValor.isNotEmpty) {
        await conn.query('UPDATE alunos SET $campo = ? WHERE id = ?', [
          novoValor,
          alunoId,
        ]);
        print('✅ Aluno atualizado com sucesso!');
      } else {
        print('⚠️ Erro: O novo valor não pode ser vazio.');
      }
    } catch (e) {
      print('❌ Erro ao editar aluno: $e');
    }
  }

  // Excluir um aluno
  Future<void> excluirAluno() async {
    print('\n--- Excluir Aluno ---');
    stdout.write('Digite a matrícula do aluno que deseja excluir: ');
    String? matricula = stdin.readLineSync();

    if (matricula == null || matricula.isEmpty) {
      print('⚠️ Erro: Matrícula não pode ser vazia.');
      return;
    }

    try {
      // Primeiro, excluímos as notas do aluno para evitar erros de chave estrangeira
      var alunoResult = await conn.query(
        'SELECT id FROM alunos WHERE matricula = ?',
        [matricula],
      );
      if (alunoResult.isEmpty) {
        print('⚠️ Erro: Aluno com a matrícula $matricula não encontrado.');
        return;
      }
      final alunoId = alunoResult.first['id'];

      await conn.query('DELETE FROM notas WHERE aluno_id = ?', [alunoId]);
      await conn.query('DELETE FROM alunos WHERE id = ?', [alunoId]);

      print(
        '✅ Aluno com matrícula $matricula e suas notas foram excluídos com sucesso!',
      );
    } catch (e) {
      print('❌ Erro ao excluir aluno: $e');
    }
  }

  // Excluir uma nota de um aluno
  Future<void> excluirNota() async {
    print('\n--- Excluir Nota ---');
    stdout.write('Digite a matrícula do aluno: ');
    String? matricula = stdin.readLineSync();
    stdout.write('Digite o nome da disciplina para a nota a ser excluída: ');
    String? nomeDisciplina = stdin.readLineSync();

    if (matricula == null ||
        matricula.isEmpty ||
        nomeDisciplina == null ||
        nomeDisciplina.isEmpty) {
      print('⚠️ Erro: Matrícula e nome da disciplina não podem ser vazios.');
      return;
    }

    try {
      var alunoResult = await conn.query(
        'SELECT id FROM alunos WHERE matricula = ?',
        [matricula],
      );
      if (alunoResult.isEmpty) {
        print('⚠️ Erro: Aluno não encontrado.');
        return;
      }
      final alunoId = alunoResult.first['id'];

      var materiaResult = await conn.query(
        'SELECT id FROM materias WHERE nome = ?',
        [nomeDisciplina],
      );
      if (materiaResult.isEmpty) {
        print('⚠️ Erro: Disciplina não encontrada.');
        return;
      }
      final materiaId = materiaResult.first['id'];

      await conn.query(
        'DELETE FROM notas WHERE aluno_id = ? AND materia_id = ?',
        [alunoId, materiaId],
      );
      print(
        '✅ Nota da disciplina $nomeDisciplina para o aluno excluída com sucesso!',
      );
    } catch (e) {
      print('❌ Erro ao excluir nota: $e');
    }
  }
}

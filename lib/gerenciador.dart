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
}


import 'db_connection.dart';

class Aluno {
  String nome;
  String matricula;
  String dataNascimento;
  String cpf;
  String email;
  String curso;

  Aluno({
    required this.nome,
    required this.matricula,
    required this.dataNascimento,
    required this.cpf,
    required this.email,
    required this.curso,
  });

  void exibirDados() {
    print('Nome: $nome');
    print('Matrícula: $matricula');
    print('Data de Nascimento: $dataNascimento');
    print('CPF: $cpf');
    print('Email: $email');
    print('Curso: $curso');
  }

  void adicionarDisciplina(String disciplina, double nota) {}
}


Future<void> cadastrarAluno(Aluno aluno) async {
  final conn = await DbConnection.conectar();
  try {
    var result = await conn.query(
      'INSERT INTO alunos (nome) VALUES (?)',
      [aluno.nome],
    );
    print('Aluno cadastrado com ID: ${result.insertId}');
  } catch (e) {
    print('Erro ao cadastrar aluno: $e');
  } finally {
    await conn.close();
  }
}
/*
class SistemaNotas {
  List<Aluno> alunos = [];

  void cadastrarAluno() {
    print('\n--- CADASTRAR ALUNO ---');
    print('Digite o nome do aluno:');
    String nome = stdin.readLineSync()?.trim() ?? '';

    if (nome.isEmpty) {
      print('Nome do aluno não pode ser vazio.');
      return;
    }

    if (alunos.any((a) => a.nome.toLowerCase() == nome.toLowerCase())) {
      print('Aluno já cadastrado.');
      return;
    }

    alunos.add(Aluno(nome));
    print('Aluno cadastrado com sucesso!');
  }

}

class SistemaAlunos {
  List<Aluno> alunos = [];

  cadastrarAluno(Aluno aluno) {
    bool jaExiste = alunos.any(
      (a) => a.matricula == aluno.matricula || a.cpf == aluno.cpf,
    );

    if (jaExiste) {
      print("⚠️Aluno já registrado com essa matrícula ou CPF.⚠️");
    } else {
      alunos.add(aluno);
      print("Aluno cadastrado com sucesso!");
    }
  }
}
*/
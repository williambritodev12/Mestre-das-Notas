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
}

class SistemaAlunos {
  List<Aluno> alunos = [];

  void cadastrarAluno(Aluno aluno) {
    bool jaExiste = alunos.any((a) => a.matricula == aluno.matricula || a.cpf == aluno.cpf);

    if (jaExiste) {
      print("⚠️Aluno já registrado com essa matrícula ou CPF.⚠️");
    } else {
      alunos.add(aluno);
      print("Aluno cadastrado com sucesso!");
    }
  }
}
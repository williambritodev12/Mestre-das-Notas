// aluno.dart
class Disciplina {
  String nome;
  double nota;

  Disciplina(this.nome, this.nota);
}

class Aluno {
  String nome;
  int idade;
  List<Disciplina> disciplinas;

  Aluno(this.nome, this.idade) : disciplinas = [];

  // Método para adicionar uma nova disciplina ao aluno e a nota
  void adicionarDisciplina(String nomeDisciplina, double nota) {
    // Verificação da nota: A lógica para garantir que a nota é válida.
    if (nota >= 0 && nota <= 10) {
      disciplinas.add(Disciplina(nomeDisciplina, nota));
      print(
        "Nota $nota para disciplina $nomeDisciplina adicionada com sucesso!",
      );
    } else {
      print("⚠️Nota inválida. A nota deve estar entre 0 e 10.⚠️");
    }
  }

  // Método para calcular a média das notas do aluno
  double calcularMedia() {
    if (disciplinas.isEmpty) {
      return 0.0; // Se não há disciplinas, a média é 0
    }

    double somaNotas = 0.0;
    for (var disciplina in disciplinas) {
      somaNotas += disciplina.nota;
    }

    return somaNotas / disciplinas.length;
  }

  // Método para verificar se o aluno foi aprovado ou reprovado
  String verificarAprovacao() {
    double media = calcularMedia();

    // A lógica para determinar a aprovação (média >= 7)
    if (media >= 7.0) {
      return "Aprovado";
    } else {
      return "Reprovado";
    }
  }

  bool foiAprovado() {
    return calcularMedia() >= 7.0;
  }
}

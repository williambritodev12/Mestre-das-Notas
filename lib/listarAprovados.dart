import 'aluno/aluno.dart';

void listarAprovados(List<Aluno> alunos) {
  if (alunos.isEmpty) {
    print('\nNenhum aluno cadastrado.');
    return;
  }

  var aprovados = alunos.where((a) => a.foiAprovado()).toList();
  if (aprovados.isEmpty) {
    print('\nNenhum aluno aprovado.');
    return;
  }

  print('\n--- ALUNOS APROVADOS ---');
  for (var aluno in aprovados) {
    print('${aluno.nome} - Média: ${aluno.calcularMedia().toStringAsFixed(2)}');
  }
}

void listarReprovados(List<Aluno> alunos) {
  if (alunos.isEmpty) {
    print('\nNenhum aluno cadastrado.');
    return;
  }

  var reprovados = alunos.where((a) => !a.foiAprovado()).toList();
  if (reprovados.isEmpty) {
    print('\nNenhum aluno reprovado.');
    return;
  }

  print('\n--- ALUNOS REPROVADOS ---');
  for (var aluno in reprovados) {
    print('${aluno.nome} - Média: ${aluno.calcularMedia().toStringAsFixed(2)}');
  }
}

import 'dart:io';
import 'package:mestre_das_notas/gerenciador.dart';

// A função agora retorna um Future<void>, o que a torna compatível com 'await'
Future<void> menuPrincipal(Gerenciador gerenciador) async {
  int opcao;

  do {
    print('\n--- Menu Principal ---');
    print('[1] Registrar nota de aluno.');
    print('[2] Listar notas de todos os alunos.');
    print('[3] Calcular a média de um aluno.');
    print('[4] Verificar se o aluno foi aprovado ou reprovado.');
    print('[5] Listar todos os alunos aprovados.');
    print('[6] Listar todos os alunos reprovados.');
    print('[0] Sair.');
    print('----------------------');
    stdout.write('Escolha uma opção: ');

    try {
      String? input = stdin.readLineSync();
      if (input != null) {
        opcao = int.parse(input);
      } else {
        opcao = -1;
      }
    } catch (e) {
      opcao = -1;
    }

    switch (opcao) {
      case 1:
        // A chamada aqui é assíncrona, já que o método do gerenciador é async
        await gerenciador.registrarAluno();
        break;
      // ... Adicione os outros casos do menu aqui
      case 0:
        print('Saindo do sistema. Até logo!');
        break;
      default:
        print('Opção inválida! Por favor, escolha uma opção entre 0 e 6.');
        break;
    }
  } while (opcao != 0);
}

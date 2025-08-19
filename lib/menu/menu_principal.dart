// lib/menu/menu_principal.dart

import 'dart:io';
import 'package:mestre_das_notas/gerenciador.dart';

Future<void> menuPrincipal(Gerenciador gerenciador) async {
  int opcao;

  do {
    print('\n--- Menu Principal ---');
    print('[1] Registrar aluno.');
    print('[2] Registrar Nota do aluno.');
    print('[3] Calcular a média de um aluno.');
    print('[4] Verificar se o aluno foi aprovado ou reprovado.');
    print('[5] Listar todos os alunos aprovados.');
    print('[6] Listar todos os alunos reprovados.');
    print('[7] Listar notas de todos os alunos.');
    print('[8] Editar dados de um aluno.');
    print('[9] Excluir um aluno.');
    print('[10] Excluir uma nota.');
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
        await gerenciador.registrarAluno();
        break;
      case 2:
        await gerenciador.registrarNota();
        break;
      case 3:
        await gerenciador.calcularMediaAluno();
        break;
      case 4:
        await gerenciador.verificarAprovacaoAluno();
        break;
      case 5:
        await gerenciador.listarAprovadosReprovados(true);
        break;
      case 6:
        await gerenciador.listarAprovadosReprovados(false);
        break;
      case 7:
        await gerenciador.listarNotasTodosAlunos();
        break;
      case 8:
        await gerenciador.editarAluno();
        break;
      case 9:
        await gerenciador.excluirAluno();
        break;
      case 10:
        await gerenciador.excluirNota();
        break;
      case 0:
        print('Saindo do sistema. Até logo!');
        break;
      default:
        print('Opção inválida! Por favor, escolha uma opção entre 0 e 7.');
        break;
    }
  } while (opcao != 0);
}

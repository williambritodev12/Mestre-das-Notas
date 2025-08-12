import 'dart:io';
import 'dart:typed_data';

// Função Menu Inicial
menu() {
  int opcao;

  do {
    print('==============================');
    print('      MESTRE DAS NOTAS        ');
    print('==============================');
    print('1 - Cadastrar Aluno');
    print('2 - Cadastrar Disciplina');
    print('3 - Cadastrar Nota');
    print('4 - Listar Alunos');
    print('5 - Listar Disciplinas');
    print('6 - Listar Notas');
    print('7 - Sair');
    print('==============================');
    stdout.write('Escolha uma opção: ');
    opcao = int.parse(stdin.readLineSync()!);

    switch (opcao) {
      case 1:
        print('Cadastrar Aluno selecionado.');
        // Chamar função para cadastrar aluno
        break;
      case 2:
        print('Cadastrar Disciplina selecionado.');
        // Chamar função para cadastrar disciplina
        break;
      case 3:
        print('Cadastrar Nota selecionado.');
        // Chamar função para cadastrar nota
        break;
      case 4:
        print('Listar Alunos selecionado.');
        // Chamar função para listar alunos
        break;
      case 5:
        print('Listar Disciplinas selecionado.');
        // Chamar função para listar disciplinas
        break;
      case 6:
        print('Listar Notas selecionado.');
        // Chamar função para listar notas
        break;
      case 7:
        print('Saindo do programa...');
        break;
      default:
        print('Opção inválida. Tente novamente.');
    }
  } while (opcao != 7);
}

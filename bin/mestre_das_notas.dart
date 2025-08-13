// bin/mestre_das_notas.dart

import 'dart:io';
import 'package:mysql1/mysql1.dart';
import 'package:mestre_das_notas/gerenciador.dart';
import 'package:mestre_das_notas/menu/menu_principal.dart';

void main() async {
  // 1. Estabelecer a conexão com o banco de dados
  final conn = await MySqlConnection.connect(
    ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      db: 'mestre_das_notas',
    ),
  );
  print('✅ Conexão estabelecida com sucesso!');

  // 2. Instanciar a classe gerenciadora com a conexão
  final gerenciador = Gerenciador(conn);

  // 3. Chamar a função do menu principal.
  // A execução do código vai parar aqui até o menu ser encerrado.
  await menuPrincipal(gerenciador);

  // 4. Fechar a conexão apenas depois que a função menuPrincipal retornar
  // (ou seja, quando o usuário escolher "Sair" do menu).
  await conn.close();
  print('✅ Conexão com o banco de dados encerrada.');
}

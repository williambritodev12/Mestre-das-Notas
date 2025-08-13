import 'package:mysql1/mysql1.dart';

Future<void> main() async {
  final conn = await MySqlConnection.connect(
    ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      db: 'mestre_das_notas',
    ),
  );
  print('Conexão estabelecida com sucesso!');

  await conn.close();
}

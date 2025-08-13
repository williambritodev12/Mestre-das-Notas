import 'package:mysql1/mysql1.dart';
import 'package:mysql1/mysql1.dart' show MySqlConnection;

class DbConnection {
  static Future<MySqlConnection> conectar() async {
    var settings = ConnectionSettings(
      host: 'localhost', // Conexão local
      port: 3306,        // Porta padrão MySQL
      user: 'root',      // Usuário padrão
      password: 'admin',  // Sua senha
      db: 'Mestre_das_notas', // Nome do banco
    );

    return await MySqlConnection.connect(settings);
  }
}

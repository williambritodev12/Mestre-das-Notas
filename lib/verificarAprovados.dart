import 'db_connection.dart';

Future<void> verificarAprovados() async {
  final conn = await DbConnection.conectar();
  try {
    var results = await conn.query(
      'SELECT aluno_id, AVG(nota) as media FROM notas GROUP BY aluno_id HAVING media >= 7',
    );

    print('Alunos Aprovados:');
    for (var row in results) {
      print('Aluno ID: ${row[0]}, Média: ${row[1]}');
    }
  } catch (e) {
    print('Erro ao verificar aprovados: $e');
  } finally {
    await conn.close();
  }
}
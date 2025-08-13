import 'db_connection.dart';

Future<void> listarNotas(int alunoId) async {
  final conn = await DbConnection.conectar();
  try {
    var results = await conn.query(
      'SELECT disciplina, nota FROM notas WHERE aluno_id = ?',
      [alunoId],
    );

    print('Notas do Aluno ID $alunoId:');
    for (var row in results) {
      print('Disciplina: ${row[0]}, Nota: ${row[1]}');
    }
  } catch (e) {
    print('Erro ao listar notas: $e');
  } finally {
    await conn.close();
  }
}
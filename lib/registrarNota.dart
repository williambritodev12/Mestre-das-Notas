import 'db_connection.dart';

Future<void> registrarNota(int alunoId, String disciplina, double nota) async {
  final conn = await DbConnection.conectar();
  try {
    await conn.query(
      'INSERT INTO notas (aluno_id, disciplina, nota) VALUES (?, ?, ?)',
      [alunoId, disciplina, nota],
    );
    print('Nota registrada com sucesso!');
  } catch (e) {
    print('Erro ao registrar nota: $e');
  } finally {
    await conn.close();
  }
}
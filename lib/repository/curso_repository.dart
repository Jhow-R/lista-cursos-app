import 'package:lista_cursos/models/curso_model.dart';
import 'package:lista_cursos/repository/database_helper.dart';

class CursoRepository {
  // Instancia do Database Helper
  DatabaseHelper _databaseHelper;

  // Construtor
  CursoRepository() {
    _databaseHelper = new DatabaseHelper();
  }

  Future<List<CursoModel>> findAll() async {
    var connection = await _databaseHelper.connection;
    var result = await connection.query(
      "CursoModel",
      columns: [
        "id",
        "nome",
        "nivel",
        "percentualConclusao",
        "preco",
        "conteudo"
      ],
    );

    // Converte a lista de Maps para Lista de Cursos
    List<CursoModel> listaCursos = new List<CursoModel>();
    for (Map i in result) {
      listaCursos.add(CursoModel.fromMap(i));
    }

    return listaCursos;
  }

  Future<int> create(CursoModel cursoModel) async {
    var connection = await _databaseHelper.connection;
    var result = await connection.insert(
      "CursoModel",
      cursoModel.toMap(),
    );
    return result;
  }

  Future<int> createRaw(CursoModel cursoModel) async {
    var connection = await _databaseHelper.connection;
    var sqlCommand = " INSERT INTO CursoModel ( " +
        "  nome , " +
        "  nivel , " +
        "  percentualConclusao , " +
        "  preco , " +
        "  conteudo ) " +
        "VALUES ( " +
        "    '${cursoModel.nome}' , " +
        "    '${cursoModel.nivel}' , " +
        "    ${cursoModel.percentualConclusao}, " +
        "    ${cursoModel.preco}, " +
        "    '${cursoModel.conteudo}' " +
        "  ) ";

    var result = await connection.rawInsert(sqlCommand);
    return result;
  }

  Future<CursoModel> get(int id) async {
    var connection = await _databaseHelper.connection;
    List<Map> results = await connection.query(
      "CursoModel",
      columns: [
        "id",
        "nome",
        "nivel",
        "percentualConclusao",
        "preco",
        "conteudo"
      ],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.length > 0) {
      return CursoModel.fromMap(
        results.first,
      );
    } else {
      return null;
    }
  }

  Future<CursoModel> getRaw(int id) async {
    var connection = await _databaseHelper.connection;
    var sqlCommand = "SELECT * FROM CursoModel WHERE ID = $id  ";

    var results = await connection.rawQuery(sqlCommand);
    if (results.length > 0) {
      return new CursoModel.fromMap(results.first);
    } else {
      return null;
    }
  }

  Future<int> update(CursoModel cursoModel) async {
    var connection = await _databaseHelper.connection;
    return await connection.update(
      "CursoModel",
      cursoModel.toMap(),
      where: "id = ?",
      whereArgs: [cursoModel.id],
    );
  }

  Future<int> updateRaw(CursoModel cursoModel) async {
    var connection = await _databaseHelper.connection;
    var sqlCommand = " UPDATE CursoModel SET  " +
        "  nome = '${cursoModel.nome}' , " +
        "  nivel = '${cursoModel.nivel}' , " +
        "  percentualConclusao = ${cursoModel.percentualConclusao} , " +
        "  preco = ${cursoModel.preco} , " +
        "  conteudo =  '${cursoModel.conteudo}'  " +
        " WHERE id = ${cursoModel.id} ";

    var result = await connection.rawUpdate(sqlCommand);
    return result;
  }

  Future<void> delete(CursoModel cursoModel) async {
    var connection = await _databaseHelper.connection;
    return await connection.delete(
      "CursoModel",
      where: "id = ?",
      whereArgs: [cursoModel.id],
    );
  }

  Future<void> deleteRaw(CursoModel cursoModel) async {
    var connection = await _databaseHelper.connection;
    var sqlCommand =
        " DELETE FROM CursoModel   " + " WHERE id = ${cursoModel.id} ";

    var result = await connection.rawDelete(sqlCommand);
    return result;
  }
}

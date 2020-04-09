import 'package:lista_cursos/models/curso_model.dart';

import 'database.dart';

// SELECT, INSERT, UPDATE, DELETE
class CursoRepository {
  
  List<CursoModel> findAll() {
    List<CursoModel> lista = <CursoModel>[
      new CursoModel(
          id: 1,
          nome: 'Delphi 1',
          nivel: 'Ultra Avancado',
          percentualConclusao: 0.7,
          preco: 1000),
      new CursoModel(
          id: 2,
          nome: 'Delphi 2',
          nivel: 'Ultra Avancado',
          percentualConclusao: 0.7,
          preco: 1000),
      new CursoModel(
          id: 3,
          nome: 'Delphi 3',
          nivel: 'Ultra Avancado',
          percentualConclusao: 0.7,
          preco: 1000)
    ];

    return lista;
  }

  Future<List<CursoModel>> findAllAsync() async {
    var db = Database();
    await db.createDatabase();

    List<CursoModel> cursos = new List<CursoModel>();

    if (db.created) {
      cursos = new List<CursoModel>();
      cursos.add(
        new CursoModel(
            id: 1,
            nome: 'Java',
            nivel: 'Básico',
            percentualConclusao: 99,
            preco: 1000),
      );

      cursos.add(
        new CursoModel(
            id: 1,
            nome: 'Java',
            nivel: 'Básico',
            percentualConclusao: 99,
            preco: 1000),
      );

      cursos.add(
        new CursoModel(
            id: 1,
            nome: 'Java',
            nivel: 'Básico',
            percentualConclusao: 99,
            preco: 1000),
      );
    }
    return new Future.value(cursos);
  }
}

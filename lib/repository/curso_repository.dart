import 'package:lista_cursos/models/curso_model.dart';

class CursoRepository {
  // SELECT, INSERT, UPDATE, DELETE

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
}

import 'package:lista_cursos/models/curso_model.dart';
import 'package:lista_cursos/services/CursoService.dart';
import 'package:mobx/mobx.dart';
part 'curso_screen_store.g.dart';

class CursoScreenStore = _CursoScreenStore with _$CursoScreenStore;

abstract class _CursoScreenStore with Store {
  final CursoService _cursoService = CursoService();

  _CursoScreenStore() {
    init();
  }

  init() async {
    isLoading = true;
    var listaCursoLocal = await _cursoService.findAll();
    quantidade = listaCursoLocal.length;
    listaCurso = listaCursoLocal.asObservable();
    isLoading = false;
  }

  @action
  findAllCourses() async {
    init();
  }

  @observable
  bool isLoading = false;

  @observable
  int quantidade = 0;

  @observable
  String filtro = '';

  @observable
  ObservableList<CursoModel> listaCurso = <CursoModel>[].asObservable();

  @action
  setFiltro(value) {
    filtro = value;
    print('Filtro: $filtro');
  }

  @computed
  int get quantidadeFiltered {
    return filtered.length;
  }

  @computed
  List<CursoModel> get filtered {
    if (filtro.isEmpty) {
      return listaCurso;
    } else {
      var filtrados = listaCurso
          .where(
            (c) => c.nome.toLowerCase().contains(
                  filtro.toLowerCase(),
                ),
          )
          .toList();
      // quantidade = filtrados.length;
      return filtrados;
    }
  }
}

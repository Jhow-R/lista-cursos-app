import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lista_cursos/store/curso_screen_store.dart';
import 'package:lista_cursos/widget/curso_listview.dart';
import 'package:lista_cursos/widget/curso_listview_loading.dart';

class CursosScreen extends StatefulWidget {
  @override
  _CursosScreenState createState() => _CursosScreenState();
}

class _CursosScreenState extends State<CursosScreen> {
  // Instância para exibir um SnackBar na tela
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final CursoScreenStore _cursoScreenStore = CursoScreenStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(64, 75, 96, .9),
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Digite o nome do curso',
          ),
          onChanged: _cursoScreenStore.setFiltro,
        ),
        actions: [
          IconButton(
              icon: Observer(builder: (_) {
                return Text('${_cursoScreenStore.quantidadeFiltered}');
              }),
              onPressed: null)
        ],
      ),
      body: Observer(
        builder: (context) {
          if (_cursoScreenStore.isLoading) {
            // Carregando as informações
            return CursoListViewLoading();
          } else {
            return CursoListView(
              cursos: _cursoScreenStore.filtered,
              context: context,
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(64, 75, 96, .9),
        child: Icon(Icons.cached),
        onPressed: () async {
          _cursoScreenStore.findAllCourses();
        },
      ),
    );
  }
}

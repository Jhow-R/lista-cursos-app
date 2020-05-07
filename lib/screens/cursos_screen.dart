import 'package:flutter/material.dart';
import 'package:lista_cursos/models/curso_model.dart';
import 'package:lista_cursos/repository/curso_repository.dart';

class CursosScreen extends StatefulWidget {
  @override
  _CursosScreenState createState() => _CursosScreenState();
}

class _CursosScreenState extends State<CursosScreen> {
  // Instância para exibir um SnackBar na tela
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(64, 75, 96, .9),
        title: Text("Cursos"),
      ),
      body: FutureBuilder<List<CursoModel>>(
        future: CursoRepository().findAllAsync(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return buildListView(snapshot.data);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(64, 75, 96, .9),
        child: Icon(Icons.add),
        onPressed: () async {
          var retorno = await Navigator.pushNamed(context, "/cursos_novo");

          if (retorno != null) {
            // Atualizar a tela
            setState(() {});

            scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text(retorno.toString()),
            ));
          }
        },
      ),
    );
  }

  // Cria a lista de Cards de acordo com os cursos no Repository
  ListView buildListView(List<CursoModel> cursos) {
    return ListView.builder(
      itemCount: cursos == null ? 0 : cursos.length,
      //itemCount: cursos.length,
      itemBuilder: (BuildContext ctx, int index) {
        return Dismissible(
          key: Key(cursos[index].id.toString()),
          child: cardCurso(cursos[index]),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            //new cursoRepository.delete(cursos[index].id);
            setState(() {});
          },
          background: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: AlignmentDirectional.centerEnd,
              color: Colors.redAccent,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Retorna os cards para os cartões
  Card cardCurso(CursoModel curso) {
    return Card(
      elevation: 12.0,
      margin: new EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 6.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(64, 75, 96, .9),
        ),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
              border: new Border(
                right: new BorderSide(
                  width: 1.0,
                  color: Colors.white24,
                ),
              ),
            ),
            child: Icon(
              Icons.autorenew,
              color: Colors.white,
            ),
          ),
          title: Text(
            curso.nome,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: LinearProgressIndicator(
                    backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
                    value: curso.percentualConclusao,
                    valueColor: AlwaysStoppedAnimation(Colors.green),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    curso.nivel,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.white,
            size: 30.0,
          ),
          onTap: () {
            print('Navegar');
            navegarParaDetalhes(curso);
          },
        ),
      ),
    );
  }

  // Navegação para a tela de detalhes do curso
  void navegarParaDetalhes(CursoModel curso) async {
    var retorno = await Navigator.pushNamed(context, "/cursos_detalhes",
        arguments: curso);

    print(retorno);
  }
}

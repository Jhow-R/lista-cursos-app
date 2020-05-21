import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista_cursos/models/curso_model.dart';

class CursosDetalhesScreen extends StatefulWidget {
  @override
  _CursosDetalhesScreenState createState() => _CursosDetalhesScreenState();
}

class _CursosDetalhesScreenState extends State<CursosDetalhesScreen> {
  CursoModel cursoModel;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    cursoModel = ModalRoute.of(context).settings.arguments;

    // INDICADOR DE NÍVEL
    final levelIndicator = Container(
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
            value: cursoModel?.percentualConclusao,
            valueColor: AlwaysStoppedAnimation(Colors.green),
          ),
        ),
      ),
    );

    // PREÇO DO CURSO
    final coursePrice = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: new BoxDecoration(
        border: new Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Center(
        child: new Text(
          "R\$ " + cursoModel?.preco.toString(),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

    //TÍTULO DO CURSO
    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 80.0),
        Icon(
          Icons.computer,
          color: Colors.white,
          size: 40.0,
        ),
        Container(
          width: 90.0,
          child: new Divider(color: Colors.green),
        ),
        SizedBox(height: 10.0),
        Text(
          cursoModel?.nome,
          style: TextStyle(
            color: Colors.white,
            fontSize: 45.0,
          ),
        ),
        SizedBox(height: 22.7),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: levelIndicator,
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  cursoModel?.nivel,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: coursePrice,
            ),
          ],
        ),
      ],
    );

    // CONTEÚDO SUPERIOR: INDICADOR DE NÍVEL + PREÇO DO CURSO + TÍTULO DO CURSO
    final topContent = Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10.0),
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("drive.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        )
      ],
    );

    // DESCRIÇÃO DO CURSO
    final bottomContentText = Text(
      cursoModel?.conteudo,
      style: TextStyle(fontSize: 18.0),
      textAlign: TextAlign.justify,
    );

    // BOTÃO DE EDITAR
    final editButton = Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Text(
          "Editar",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () async {
          var retorno = await Navigator.pushNamed(context, "/cursos_editar",
              arguments: cursoModel);

          if (retorno != null) {
            cursoModel = retorno as CursoModel;

            setState(() {});

            scaffoldKey.currentState.showSnackBar(
              new SnackBar(
                content: Text(
                  'Curso alterado com sucesso!',
                ),
              ),
            );
          }
        },
      ),
    );

    // CONTEÚDO INFERIOR: DESCRIÇÃO DO CURSO + BOTÃO DE EDITAR
    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[
            bottomContentText,
            editButton,
          ],
        ),
      ),
    );

    return Scaffold(
      key: scaffoldKey,
      body: Column(
        children: <Widget>[
          topContent,
          bottomContent,
        ],
      ),
    );
  }
}

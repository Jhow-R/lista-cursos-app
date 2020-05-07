import 'package:flutter/material.dart';
import 'package:lista_cursos/models/curso_model.dart';

class CursosEditarScreen extends StatefulWidget {
  @override
  _CursosEditarScreenState createState() => _CursosEditarScreenState();
}

class _CursosEditarScreenState extends State<CursosEditarScreen> {
  @override
  Widget build(BuildContext context) {
    CursoModel cursoModel = ModalRoute.of(context).settings.arguments;
    GlobalKey<FormState> formKey = new GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(64, 75, 96, .9),
        title: Text("Editar curso: ${cursoModel.nome}"),
      ),
      body: Form(
        key: formKey,
        child: Column(children: <Widget>[
          // NOME
          TextFormField(
            initialValue: cursoModel.nome,
            decoration: new InputDecoration(
              icon: const Icon(Icons.text_fields),
              hintText: 'Digite o nome do curso',
              labelText: 'Nome',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Nome requerido';
              } else if (value.length < 1) {
                return 'Nome inválido';
              }
              return null;
            },
            onSaved: (value) {
              cursoModel.nome = value;
            },
            keyboardType: TextInputType.text,
          ),

          // BOTÃO DE GRAVAR
          RaisedButton(
            child: Text('Gravar'),
            onPressed: () {
              // Validar o formulário
              if (formKey.currentState.validate()) {
                // Salvar o formulário
                formKey.currentState.save();

                //Alterar o model no Repository
                //new CursoRepository().Update(cursoModel);

                // Fechar a tela devolvendo a mensagem de sucesso
                Navigator.pop(context, "Curso alterado com sucesso!");
              }
            },
          ),
        ]),
      ),
    );
  }
}

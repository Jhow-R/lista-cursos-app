import 'package:flutter/material.dart';

import '../models/curso_model.dart';

class CursosNovoScreen extends StatefulWidget {
  @override
  _CursosNovoScreenState createState() => _CursosNovoScreenState();
}

class _CursosNovoScreenState extends State<CursosNovoScreen> {
  CursoModel cursoModel = new CursoModel();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  // Manipula-se o formulário através dessa chave
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(64, 75, 96, .9),
        title: Text("Novo Curso"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                // NOME
                TextFormField(
                  decoration: new InputDecoration(
                    icon: const Icon(Icons.text_fields),
                    hintText: 'Digite o nome do curso',
                    labelText: 'Nome',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Nome requerido';
                    } else if (value.length < 3) {
                      return 'Nome inválido';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    cursoModel.nome = value;
                  },
                  keyboardType: TextInputType.text,
                ),

                // PREÇO
                TextFormField(
                  decoration: new InputDecoration(
                    icon: const Icon(Icons.monetization_on),
                    hintText: '999',
                    labelText: 'Preço',
                  ),
                  validator: (value) {
                    if ((value.isEmpty) || (int.parse(value) <= 0)) {
                      return 'Digite um preço válido!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    cursoModel.preco = int.parse(value);
                  },
                  keyboardType: TextInputType.number,
                ),

                // PERCENTUAL
                TextFormField(
                  decoration: new InputDecoration(
                    icon: const Icon(Icons.flight_takeoff),
                    hintText: '99.99',
                    labelText: 'Percentual de conclusão',
                  ),
                  validator: (value) {
                    if ((value.isEmpty) || (double.parse(value) <= 0)) {
                      return 'Digite um percentual correto!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    var percent = double.parse(value);
                    cursoModel.percentualConclusao = percent / 100;
                  },
                  keyboardType: TextInputType.number,
                ),

                // NÍVEL
                DropdownButtonFormField(
                  items: ["Básico", "Inter", "Avançado"]
                      .map(
                        (e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ),
                      )
                      .toList(),
                  decoration: new InputDecoration(
                    icon: const Icon(Icons.score),
                    hintText: 'Selecione o nível',
                    labelText: 'Nível',
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Selecione o nível';
                    }

                    return null;
                  },
                  onChanged: (value) {
                    cursoModel.nivel = value;
                  },
                ),

                // CONTEÚDO
                TextFormField(
                  maxLines: 5,
                  decoration: new InputDecoration(
                    alignLabelWithHint: true,
                    icon: const Icon(Icons.text_fields),
                    hintText: 'Digite o conteúdo do curso',
                    labelText: 'Conteúdo',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Conteúdo requerido';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    cursoModel.conteudo = value;
                  },
                  keyboardType: TextInputType.multiline,
                ),

                // BOTÃO DE GRAVAR
                RaisedButton(
                  child: Text('Gravar'),
                  onPressed: () {
                    // Validar o formulário
                    if (formKey.currentState.validate()) {
                      // Salvar o formulário
                      formKey.currentState.save();

                      //Salvar o model no Repository

                      // Fechar a tela devolvendo a mensagem de sucesso
                      Navigator.pop(context, "Curso inserido com sucesso!");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lista_cursos/screens/cursos_detalhes_screen.dart';
import 'package:lista_cursos/screens/cursos_editar.dart';
import 'package:lista_cursos/screens/cursos_novo_screen.dart';
import 'package:lista_cursos/screens/cursos_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => CursosScreen(),
        "/cursos_detalhes": (context) => CursosDetalhesScreen(),
        '/cursos_novo': (context) => CursosNovoScreen(),
        '/cursos_editar': (context) => CursosEditarScreen(),
      },
      title: 'Cursos App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Arial',
      ),
      // HOME: Não posso usar "home" se eu configuro um initalRoute
      //home: CursosScreen(),   
      //home: CursosDetalhesScreen(),
    );
  }
}

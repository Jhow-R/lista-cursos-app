import 'package:flutter/material.dart';
import 'package:lista_cursos/screens/curso_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cursos App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CursosScreen(),
    );
  }
}


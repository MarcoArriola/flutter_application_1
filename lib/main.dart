import 'package:flutter/material.dart';

void main() {
  runApp(const HOlaMundo());
}

class HOlaMundo extends StatelessWidget {
  const HOlaMundo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home:Text("Hola Mundo"));
  }
}
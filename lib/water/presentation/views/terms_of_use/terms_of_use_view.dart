import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TermsOfUseView extends StatelessWidget {
  const TermsOfUseView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      body: Column(children: [
        Text('Bem-vindo!'),
        Text('Antes de seguirmos adiante, é necessário que aceite os termos de uso.'),
        SingleChildScrollView(
          child: Column(),
        ),
      ]),
    ));
  }
}

import 'package:flutter/material.dart';

class WaterDisplayPage extends StatelessWidget {
  const WaterDisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Water')),
      body: Container(alignment: Alignment.center, child: const Text('Body')),
    );
  }
}

import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: GridView.count(
        crossAxisCount: 2,
        children: List.generate(
          3,
          (index) => Card.filled(child: Text("Fuente de dinero $index")),
        ),
      ),
    );
  }
}

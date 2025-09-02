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
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.purple,
                      Colors.cyanAccent,
                      Colors.yellowAccent,
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(8),
                child: const Text("Hola <username>, bienvenido de vuelta"),
              ),
              const SizedBox(height: 16),
              const Text(
                "Fuentes de dinero",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 400,
                child: GridView.count(
                  scrollDirection: Axis.horizontal,
                  crossAxisSpacing: 10,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: List.generate(
                    5,
                    (index) => Container(
                      width: 500,
                      margin: const EdgeInsets.all(8),
                      color: Colors.grey[200],
                      child: const Placeholder(),
                    ),
                  ),
                ),
              ),
              const Text(
                "Categorías",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 400,
                child: GridView.count(
                  scrollDirection: Axis.horizontal,
                  crossAxisSpacing: 10,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: List.generate(
                    5,
                    (index) => Container(
                      width: 500,
                      margin: const EdgeInsets.all(8),
                      color: Colors.grey[200],
                      child: const Placeholder(),
                    ),
                  ),
                ),
              ),
              const Text(
                "Pagos",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 400,
                child: ListView(
                  children: List.generate(
                    3,
                    (_) => Container(
                      height: 100,
                      color: Colors.grey[200],
                      child: Placeholder(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_finances/components/dashboard-widgets/categories_list.dart';
import 'package:my_finances/components/drawer_item/drawer_item.dart';
import 'package:my_finances/components/drawer_item/drawer_item_entry.dart';
import 'package:my_finances/database/account_service.dart';
import 'package:my_finances/models/account.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int counter = 30;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(leading: null),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await AccountService().insert(
              Account(
                id: counter,
                name: "fsfds",
                description: "fds",
                icon: Icons.add.codePoint,
                image: "dfsfds",
                creationDate: DateTime.now(),
                showTheoreticalBalance: false,
                baseBalance: 0,
                lastChecked: DateTime.now(),
              ),
            );
            setState(() {
              counter = counter + 1;
            });
          },
          child: Icon(Icons.add),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Row(
                  children: [
                    CircleAvatar(),
                    Column(
                      children: [
                        Text("Hola, usuario"),
                        Row(children: [Text("21 años"), Text("-"), Text("Él")]),
                      ],
                    ),
                  ],
                ),
              ),
              DrawerItem(
                entry: DrawerItemEntry(
                  route: "something",
                  subroutes: [],
                  navigatable: false,
                  title: "Something",
                ),
                isSelected: false,
                selectedSubroute: [],
                navigateTo: (_) {},
              ),
              DrawerItem(
                entry: DrawerItemEntry(
                  route: "a",
                  subroutes: [
                    DrawerItemEntry(
                      route: "b",
                      subroutes: [],
                      navigatable: true,
                      title: "B",
                    ),
                    DrawerItemEntry(
                      route: "c",
                      subroutes: [],
                      navigatable: true,
                      title: "C",
                    ),
                  ],
                  navigatable: false,
                  title: "A",
                ),
                isSelected: true,
                selectedSubroute: ["b"],
                navigateTo: (_) {},
              ),
            ],
          ),
        ),
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
              CategoriesList(),
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

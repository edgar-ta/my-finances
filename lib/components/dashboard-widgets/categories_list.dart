import 'package:flutter/material.dart';
import 'package:my_finances/database/account_service.dart';
import 'package:my_finances/models/account.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AccountService().getAll(),
      builder: (context, streamSnapshot) {
        if (streamSnapshot.error != null) {
          return Text("Hubo un error");
        }
        if (!streamSnapshot.hasData) {
          return Text("Cargando todavía");
        }

        return SizedBox(
          height: 400,
          child: GridView.count(
            scrollDirection: Axis.horizontal,
            crossAxisSpacing: 10,
            shrinkWrap: true,
            crossAxisCount: 2,
            children:
                streamSnapshot.data!
                    .map((element) => Text(element.name))
                    .toList(),
          ),
        );
      },
    );
    ;
  }
}

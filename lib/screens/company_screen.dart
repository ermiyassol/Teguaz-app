import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teguaz_app/providers/companies.dart';
import 'package:teguaz_app/widgets/company_list.dart';
import 'package:teguaz_app/widgets/main_appbar.dart';
import 'package:teguaz_app/widgets/main_drawer.dart';

class CompanyScreen extends StatelessWidget {
  static const routeName = '/company-screen';

  @override
  Widget build(BuildContext context) {
    final companies =
        Provider.of<Companies>(context).companies;
    return Scaffold(
        appBar: MainAppBar('Companies List'),
        drawer: MainDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
            itemBuilder: (_, index) {
              // return;
              return ChangeNotifierProvider.value(
                value: companies[index],
                child: CompanyList(),
              );
            },
            itemCount: companies.length,
          ),
        ));
  }
}

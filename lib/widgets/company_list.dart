import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teguaz_app/providers/company.dart';
import 'package:teguaz_app/screens/company_detail_screen.dart';

class CompanyList extends StatelessWidget {
  // const CompanyList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final company = Provider.of<Company>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
          child: GestureDetector(
            child: Image.network(
              company.logoUrl,
              fit: BoxFit.cover,
            ),
            onTap: () {
              Navigator.of(context).pushNamed(
                  CompanyDetailScreen.routeName,
                  arguments: company.companyId);
            },
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            title: Text(
              company.companyName.toUpperCase(),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            trailing: IconButton(
                icon: Icon(
              Icons.arrow_forward,
              color: Colors.white,
            )),
          )),
    );
  }
}

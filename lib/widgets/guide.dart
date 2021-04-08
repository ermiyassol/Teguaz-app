import 'package:flutter/material.dart';

class Guide extends StatelessWidget {
  static const routeName = '/guide';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guide'),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Text(
                'How To Use The App',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic),
              ),
              Container(
                height: MediaQuery.of(context)
                        .size
                        .height *
                    0.76,
                child: ListView.builder(
                  itemBuilder: (_, i) {
                    return Column(
                      children: [
                        Text(
                            'Primarily, we would like to thank our God for his help in the process of starting and completing the documentation of the project. The project group would like to express our appreciation to all those who gave us the possibility to complete this project documentation. Secondly, special thanks to Bus Companies Specifically Abay bus company and Traveler bus ticket reservation agent to encourage us to develop this final year project. In addition, a special thanks to our final year project advisor Mr. Gbreegiziabhier. A. For his guidance, understanding, patience and most importantly, his friendship during the project work. Lastly, we would like to thank our class met for their help and advice.',
                            style: TextStyle(
                                fontSize: 17)),
                        SizedBox(
                          height: 19,
                        ),
                        Text(
                            'Primarily, we would like to thank our God for his help in the process of starting and completing the documentation of the project. The project group would like to express our appreciation to all those who gave us the possibility to complete this project documentation. Secondly, special thanks to Bus Companies Specifically Abay bus company and Traveler bus ticket reservation agent to encourage us to develop this final year project. In addition, a special thanks to our final year project advisor Mr. Gbreegiziabhier. A. For his guidance, understanding, patience and most importantly, his friendship during the project work. Lastly, we would like to thank our class met for their help and advice.',
                            style: TextStyle(
                                fontSize: 17)),
                      ],
                    );
                  },
                  itemCount: 1,
                ),
              )
            ],
          )),
    );
  }
}

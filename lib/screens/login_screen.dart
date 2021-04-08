import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 215,
      child: Form(
        child: Column(
          children: [
            TextFormField(
              textInputAction:
                  TextInputAction.next,
              keyboardType:
                  TextInputType.emailAddress,
              decoration: InputDecoration(
                  labelText: 'Email'),
            ),
            TextFormField(
              textInputAction:
                  TextInputAction.next,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: 'Password'),
            ),
            RaisedButton(
                child: Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.white),
                ),
                color: Theme.of(context)
                    .primaryColor,
                onPressed: () {}),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start,
              children: [
                Text('Or'),
                FlatButton(
                    onPressed: () {},
                    child:
                        Text('Forget Password'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

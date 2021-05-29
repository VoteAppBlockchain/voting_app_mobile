import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:voting_app_mobile/pages/voting.dart';
import 'package:voting_app_mobile/http/vote_http.dart';

class LoginStateless extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Login(),
    );
  }
}

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  TextEditingController idNumberEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  void dispose() {
    idNumberEditingController.dispose();
    passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 50),
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              title(),
              idNumberField(),
              passwordField(),
              loginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget title() {
    return Container(
        padding: EdgeInsets.all(20),
        child: Text(
          "Login",
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ));
  }

  Widget idNumberField() {
    return Container(
        padding: EdgeInsets.all(15),
        child: TextFormField(
          controller: idNumberEditingController,
          maxLines: 1,
          validator: (value) {
            if (value.isEmpty) {
              return "Please enter user name";
            }
            return null;
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "ID Number",
              prefixIcon: Icon(Icons.person)),
        ));
  }

  Widget passwordField() {
    return Container(
        padding: EdgeInsets.all(15),
        child: TextFormField(
          controller: passwordEditingController,
          maxLines: 1,
          obscureText: !_passwordVisible,
          validator: (value) {
            if (value.isEmpty) {
              return "Please enter  your password";
            }
            return null;
          },
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  }),
              border: OutlineInputBorder(),
              labelText: "Password",
              prefixIcon: Icon(Icons.lock)),
        ));
  }

  Widget loginButton() {
    return Container(
      padding: EdgeInsets.all(10),
      child: MaterialButton(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10)),
        elevation: 8,
        color: Colors.green,
        child: Text(
          "Login",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        onPressed: () {
          // If both field is filled
          if (_formKey.currentState.validate()) {
            String idNumber = idNumberEditingController.text;
            String password = passwordEditingController.text;

            VoteHttp voteHttp = new VoteHttp();
            voteHttp.login(idNumber, password).then((response) {
              if (response.length > 0) {
                String hexValue = response[0]["hexvalue"];
                String name = response[0]["name"];
                String surname = response[0]["surname"];

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => Vote(
                              name: Utf8Decoder().convert(name.codeUnits),
                              surname: Utf8Decoder().convert(surname.codeUnits),
                              hexValue: hexValue,
                            )),
                    (Route<dynamic> route) => false);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                  'Voter not registered.',
                  style: TextStyle(fontSize: 20),
                )));
              }
            });
          } else {
            // If fields are empty
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              'ID and password are not correct.',
              style: TextStyle(fontSize: 20),
            )));
          }
        },
      ),
    );
  }
}

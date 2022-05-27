// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, avoid_print

import 'dart:async';

import 'package:apporder/routes.dart';
import 'package:apporder/screens/homes/homes_screen.dart';
import 'package:apporder/screens/login_signup/loginsignup_page.dart';
import 'package:apporder/utils/custom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPass extends StatefulWidget {
  final Function onSignUpSelected;
  const ForgotPass({Key? key, required this.onSignUpSelected})
      : super(key: key);
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_BodyState');
  final TextEditingController email = TextEditingController();
  late SharedPreferences prefs;
  String errore = '';
  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser != null) {
      Timer.run(() {
        FluroRouters.router
            .navigateTo(context, HomesScreen.routeName, replace: true);
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    // _formKey.currentState?.dispose();
    super.dispose();
  }

  void submit() async {
    try {
      if (email.text.isEmpty) {
        errore = 'Vui lòng nhập email';
      }

      if (email.text.isNotEmpty) {
        FirebaseAuth.instance.signOut();
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
        FluroRouters.router
            .navigateTo(context, LoginSignupScreen.routeName, replace: true);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          errore = 'Không tìm thấy email người dùng.';
        });
      }
    }
  }

  Future settingSharepre() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.all(size.height > 770
          ? 64
          : size.height > 670
              ? 32
              : 16),
      child: Center(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: size.height *
                (size.height > 770
                    ? 0.7
                    : size.height > 670
                        ? 0.8
                        : 0.9),
            width: 500,
            color: Colors.white,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "LOG IN",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: 30,
                          child: Divider(
                            color: Palette.animationColor,
                            thickness: 2,
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        TextField(
                          controller: email,
                          onChanged: (value) {
                            setState(() {
                              String pattern =
                                  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                  r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                  r"{0,253}[a-zA-Z0-9])?)*$";
                              RegExp regex = RegExp(pattern);
                              if (value == '' || value.isEmpty)
                                errore = '';
                              else if (!regex.hasMatch(value)) {
                                errore = 'Email chưa đúng định dạng';
                              } else {
                                errore = '';
                              }
                            });
                          },
                          decoration: errore == ''
                              ? InputDecoration(
                                  hintText: 'Email',
                                  labelText: 'Email',
                                  suffixIcon: Icon(
                                    Icons.mail_outline,
                                  ),
                                )
                              : InputDecoration(
                                  hintText: 'Email',
                                  labelText: 'Email',
                                  errorText: errore,
                                  suffixIcon: Icon(
                                    Icons.mail_outline,
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: 64,
                        ),
                        actionButton("Send mail"),
                        SizedBox(
                          height: 32,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Back to?",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                FluroRouters.router.navigateTo(
                                    context, LoginSignupScreen.routeName,
                                    replace: true);
                              },
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Palette.animationColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Palette.animationColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget actionButton(String text) {
    return InkWell(
      onTap: () {
        setState(() {
          submit();
        });
      },
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Palette.animationColor,
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Palette.animationColor.withOpacity(0.2),
              spreadRadius: 4,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

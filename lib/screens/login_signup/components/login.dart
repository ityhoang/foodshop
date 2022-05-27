// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, avoid_print

import 'dart:async';

import 'package:apporder/routes.dart';
import 'package:apporder/screens/forgot/forgot_screen.dart';
import 'package:apporder/screens/homes/homes_screen.dart';
import 'package:apporder/utils/custom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogIn extends StatefulWidget {
  final Function onSignUpSelected;
  const LogIn({Key? key, required this.onSignUpSelected}) : super(key: key);
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_BodyState');
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  late SharedPreferences prefs;
  String errore = '';
  String errorp = '';
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
      if (password.text.isEmpty) {
        errorp = 'Vui lòng nhập password';
      }
      if (email.text.isNotEmpty || password.text.isNotEmpty) {
        FirebaseAuth.instance.signOut();
        UserCredential result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: email.text, password: password.text);
        if (result.user!.uid.isNotEmpty) {
          settingSharepre().then((value) {
            prefs = value;
            prefs.setString("uid", result.user!.uid);
            prefs.remove("cart");
            prefs.remove("count");
            FluroRouters.router
                .navigateTo(context, HomesScreen.routeName, replace: true);
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          errore = 'Không tìm thấy email người dùng.';
        });
      } else if (e.code == 'wrong-password') {
        setState(() {
          errorp = 'Sai mật khẩu.';
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
                          height: 32,
                        ),
                        TextField(
                          controller: password,
                          obscureText: true,
                          onChanged: (value) {
                            setState(() {
                              String pattern = r"\s";
                              RegExp regex = RegExp(pattern);
                              if (value == '' || value.isEmpty)
                                errorp = '';
                              else if (regex.hasMatch(value)) {
                                errorp = 'Password chứa khoảng trắng';
                              } else if (value.length <= 6) {
                                errorp = 'Password phải lớn hơn 6 ký tự';
                              } else {
                                errorp = '';
                              }
                            });
                          },
                          decoration: errorp == ''
                              ? InputDecoration(
                                  hintText: 'Password',
                                  labelText: 'Password',
                                  suffixIcon: Icon(
                                    Icons.lock_outline,
                                  ),
                                )
                              : InputDecoration(
                                  hintText: 'Password',
                                  labelText: 'Password',
                                  errorText: errorp,
                                  suffixIcon: Icon(
                                    Icons.lock_outline,
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: 64,
                        ),
                        actionButton("Log In"),
                        SizedBox(
                          height: 32,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "You do not have an account?",
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
                                widget.onSignUpSelected();
                              },
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Sign Up",
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
                        InkWell(
                            onTap: () {
                              FluroRouters.router.navigateTo(
                                  context, ForgotScreen.routeName,
                                  replace: true);
                            },
                            child: Text("Forgot Password"))
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

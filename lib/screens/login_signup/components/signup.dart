// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_final_fields, avoid_print

import 'package:apporder/routes.dart';
import 'package:apporder/screens/homes/homes_screen.dart';
import 'package:apporder/utils/custom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  final Function onLogInSelected;

  SignUp({Key? key, required this.onLogInSelected}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_BodyState');
  final TextEditingController emailS = TextEditingController();
  final TextEditingController passwordS = TextEditingController();
  final TextEditingController yourNameS = TextEditingController();
  final TextEditingController repasswordS = TextEditingController();
  late SharedPreferences prefs;
  String erroru = '';
  String errorp = '';
  String errore = '';
  String errorpr = '';

  bool isMale = true;

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  void signup() async {
    UserCredential? result;
    try {
      if (yourNameS.text.isEmpty) {
        erroru = 'Vui lòng nhập name';
      }
      if (emailS.text.isEmpty) {
        errore = 'Vui lòng nhập email';
      }
      if (passwordS.text.isEmpty) {
        errorp = 'Vui lòng nhập password';
      }
      if (repasswordS.text.isEmpty) {
        errorpr = 'Vui lòng nhập lại password';
      }
      if (yourNameS.text.isNotEmpty ||
          emailS.text.isNotEmpty ||
          passwordS.text.isNotEmpty ||
          repasswordS.text.isNotEmpty) {
        FirebaseAuth.instance.signOut();
        result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailS.text, password: passwordS.text);
        FirebaseFirestore.instance
            .collection("User")
            .doc(result.user!.uid)
            .set({
          "UserName": yourNameS.text,
          "UserId": result.user!.uid,
          "UserEmail": emailS.text,
          "UserPassword": passwordS.text,
          "UserGender": isMale == true ? "Male" : "Female",
          "avtar": isMale == true
              ? "https://tyhoang.ga/images/uploads/avt_b.png"
              : "https://tyhoang.ga/images/uploads/avt_g.png",
          "address": "",
          "phone": "",
        });
        FirebaseFirestore.instance
            .collection("User")
            .doc(result.user!.uid)
            .collection("like")
            .doc("listid")
            .set({});
        FirebaseFirestore.instance
            .collection("User")
            .doc(result.user!.uid)
            .collection("cart");
        FirebaseFirestore.instance
            .collection("User")
            .doc(result.user!.uid)
            .collection("news")
            .doc("listnews")
            .set({});
        FirebaseFirestore.instance
            .collection("User")
            .doc(result.user!.uid)
            .collection("bill");
        settingSharepre().then((value) {
          prefs = value;
          prefs.setString("uid", result!.user!.uid);
          prefs.remove("cart");
          prefs.remove("count");
          FluroRouters.router
              .navigateTo(context, HomesScreen.routeName, replace: true);
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        setState(() {
          errorp = 'Mật khẩu quá yếu.';
        });
      } else if (e.code == 'email-already-in-use') {
        setState(() {
          errore = 'Tài khoản email đã tồn tại.';
        });
      }
    } catch (e) {
      print(e);
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
                          "SIGN UP",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          width: 30,
                          child: Divider(
                            color: Palette.animationColor,
                            thickness: 2,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: yourNameS,
                          onChanged: (value) {
                            setState(() {
                              if (value == '' || value.isEmpty)
                                erroru = '';
                              else if (RegExp(
                                      r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                                  .hasMatch(value)) {
                                erroru = 'Tên không được chứa ký tự đặc biệt';
                              } else {
                                erroru = '';
                              }
                            });
                          },
                          decoration: erroru == ''
                              ? InputDecoration(
                                  hintText: 'Name',
                                  labelText: 'Name',
                                  suffixIcon: Icon(
                                    Icons.person_outline,
                                  ),
                                )
                              : InputDecoration(
                                  hintText: 'Name',
                                  labelText: 'Name',
                                  errorText: erroru,
                                  suffixIcon: Icon(
                                    Icons.person_outline,
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: emailS,
                          onChanged: (value) {
                            setState(() {
                              String pattern =
                                  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                  r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                  r"{0,253}[a-zA-Z0-9])?)*$";
                              RegExp regex = RegExp(pattern);
                              if (value == null || value.isEmpty)
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
                          height: 15,
                        ),
                        TextField(
                          controller: passwordS,
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
                          height: 15,
                        ),
                        TextField(
                          controller: repasswordS,
                          obscureText: true,
                          onChanged: (value) {
                            setState(() {
                              String pattern = r"\s";
                              RegExp regex = RegExp(pattern);
                              if (value == '' || value.isEmpty)
                                errorpr = '';
                              else if (regex.hasMatch(value)) {
                                errorpr = 'Passwork chứa khoảng trắng';
                              } else if (value.length <= 6) {
                                errorpr = 'Passwork phải lớn hơn 6 ký tự';
                              } else if (repasswordS.text != passwordS.text) {
                                errorpr = 'Repassword không trùng khớp';
                              } else {
                                errorpr = '';
                              }
                            });
                          },
                          decoration: errorpr == ''
                              ? InputDecoration(
                                  hintText: 'Re-Password',
                                  labelText: 'Re-Password',
                                  suffixIcon: Icon(
                                    Icons.lock_outline,
                                  ),
                                )
                              : InputDecoration(
                                  hintText: 'Re-Password',
                                  labelText: 'Re-Password',
                                  errorText: errorpr,
                                  suffixIcon: Icon(
                                    Icons.lock_outline,
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isMale = true;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      margin: EdgeInsets.only(right: 8),
                                      decoration: BoxDecoration(
                                          color: isMale
                                              ? Palette.textColor2
                                              : Colors.transparent,
                                          border: Border.all(
                                              width: 1,
                                              color: isMale
                                                  ? Colors.transparent
                                                  : Palette.textColor1),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Icon(
                                        FontAwesomeIcons.userCircle,
                                        color: isMale
                                            ? Colors.white
                                            : Palette.iconColor,
                                      ),
                                    ),
                                    Text(
                                      "Male",
                                      style:
                                          TextStyle(color: Palette.textColor1),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isMale = false;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      margin: EdgeInsets.only(right: 8),
                                      decoration: BoxDecoration(
                                          color: isMale
                                              ? Colors.transparent
                                              : Palette.textColor2,
                                          border: Border.all(
                                              width: 1,
                                              color: isMale
                                                  ? Palette.textColor1
                                                  : Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Icon(
                                        FontAwesomeIcons.userCircle,
                                        color: isMale
                                            ? Palette.iconColor
                                            : Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "Female",
                                      style:
                                          TextStyle(color: Palette.textColor1),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        actionButton("Create Account"),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Already have an account?",
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
                                widget.onLogInSelected();
                              },
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Log In",
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
          signup();
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

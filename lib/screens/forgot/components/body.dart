// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unnecessary_new, prefer_final_fields, avoid_print

import 'package:apporder/routes.dart';
import 'package:apporder/screens/homes/homes_screen.dart';
import 'package:apporder/screens/login_signup/loginsignup_page.dart';
import 'package:apporder/utils/custom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = new RegExp(p);

bool isMale = true;

class _BodyState extends State<Body> {
  GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_BodyState');
  final TextEditingController email = TextEditingController();
  late SharedPreferences prefs;
  String errore = '';
  bool isSignupScreen = false;

  Future settingSharepre() async {
    return await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    settingSharepre().then((value) {
      prefs = value;
      if (prefs.containsKey("uid")) {
        FluroRouters.router
            .navigateTo(context, HomesScreen.routeName, replace: true);
      }
    });
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  void submit() async {
    try {
      if (email.text.isEmpty) {
        errore = '           Vui lòng nhập email';
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
          errore = '          Không tìm thấy email người dùng.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                height: _size.height * 0.35,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/background.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.only(top: _size.height * 0.12, left: 20),
                  color: Color(0xFF702323).withOpacity(.85),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          text: "Welcome to",
                          style: TextStyle(
                            fontSize: 25,
                            letterSpacing: 2,
                            color: Colors.yellow[700],
                          ),
                          children: [
                            TextSpan(
                              text: isSignupScreen ? " Food," : " Back,",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow[700],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        isSignupScreen
                            ? "Signup to Continue"
                            : "Forgot Password to Continue",
                        style: TextStyle(
                          letterSpacing: 1,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            buildBottomHalfContainer(
                true, isCheckHeight(_size.height) + (_size.height * 0.25) - 45),
            AnimatedPositioned(
              duration: Duration(milliseconds: 700),
              curve: Curves.bounceInOut,
              top: _size.height * 0.25,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 700),
                curve: Curves.bounceInOut,
                height: isCheckHeight(_size.height),
                width: _size.width * 0.922,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(horizontal: _size.width * 0.04),
                decoration: BoxDecoration(
                  color: Color(0xFFDCF3F7),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignupScreen = false;
                                });
                              },
                              child: Column(
                                children: [
                                  Text(
                                    "Forgot Password",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: !isSignupScreen
                                            ? Palette.activeColor
                                            : Palette.textColor1),
                                  ),
                                  if (!isSignupScreen)
                                    Container(
                                      margin: EdgeInsets.only(top: 3),
                                      height: 2,
                                      width: 55,
                                      color: Colors.orange,
                                    )
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (!isSignupScreen)
                          buildSigninSection(_size.width * 0.81)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            buildBottomHalfContainer(false,
                isCheckHeight(_size.height) + (_size.height * 0.25) - 45),
          ],
        ),
      ),
    );
  }

  double isCheckHeight(double height) {
    if (isSignupScreen) {
      return height * 0.48;
    } else {
      if (height < 700) {
        return height * 0.45;
      } else {
        return height * 0.33;
      }
    }
  }

  Container buildSigninSection(double width) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildTextField(Icons.mail_outline, "info@demouri.com", false, true,
              width, email, checkemail, errore),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  FluroRouters.router.navigateTo(
                    context,
                    LoginSignupScreen.routeName,
                    replace: true,
                  );
                },
                child: Text("Login?",
                    style: TextStyle(fontSize: 12, color: Palette.textColor1)),
              )
            ],
          )
        ],
      ),
    );
  }

  TextButton buildTextButton(
      IconData icon, String title, Color backgroundColor, double width) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
          side: BorderSide(width: 1, color: Colors.grey),
          minimumSize: Size(width, 40),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          primary: Colors.white,
          backgroundColor: backgroundColor),
      child: Row(
        children: [
          Icon(
            icon,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            title,
          )
        ],
      ),
    );
  }

  Widget buildBottomHalfContainer(bool showShadow, double height) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 700),
      curve: Curves.bounceInOut,
      top: height,
      right: 0,
      left: 0,
      child: Center(
        child: Container(
          height: 90,
          width: 90,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Color(0xFFDCF3F7),
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                if (showShadow)
                  BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    spreadRadius: 1.5,
                    blurRadius: 10,
                  )
              ]),
          child: !showShadow
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      submit();
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xFFFFCC80), Color(0xFFEF5350)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.3),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1))
                        ]),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                )
              : Center(),
        ),
      ),
    );
  }

  Widget buildTextField(
      IconData icon,
      String hintText,
      bool isPassword,
      bool isEmail,
      double width,
      TextEditingController controller,
      Function(String)? data,
      String err) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9.0),
      child: Container(
        width: width,
        decoration: BoxDecoration(
            color: Color(0xFFDCF3F7),
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: Color(0x70000000),
                offset: Offset(-2.2, 2.6),
                blurRadius: 2,
              ),
              BoxShadow(
                color: Color(0x85D3CFCF),
                offset: -Offset(3, 1.5),
                blurRadius: 2,
              ),
            ]),
        child: TextField(
          controller: controller,
          obscureText: isPassword,
          onChanged: data,
          keyboardType:
              isEmail ? TextInputType.emailAddress : TextInputType.text,
          decoration: err == ''
              ? InputDecoration(
                  prefixIcon: Icon(
                    icon,
                    color: Palette.iconColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFDCF3F7)),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.textColor1),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  hintText: hintText,
                  hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
                )
              : InputDecoration(
                  prefixIcon: Icon(
                    icon,
                    color: Palette.iconColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFDCF3F7)),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.textColor1),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  hintText: hintText,
                  errorText: err,
                  hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
                ),
        ),
      ),
    );
  }

  void checkemail(String value) {
    setState(() {
      String pattern =
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
          r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
          r"{0,253}[a-zA-Z0-9])?)*$";
      RegExp regex = RegExp(pattern);
      if (value == null || value.isEmpty)
        errore = '';
      else if (!regex.hasMatch(value)) {
        errore = '           Email chưa đúng định dạng';
      } else {
        errore = '';
      }
    });
  }
}

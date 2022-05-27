// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unnecessary_new, prefer_final_fields, avoid_print

import 'package:apporder/routes.dart';
import 'package:apporder/screens/forgot/forgot_screen.dart';
import 'package:apporder/screens/homes/homes_screen.dart';
import 'package:apporder/utils/custom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  bool isSignupScreen = false;
  bool isRememberMe = false;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  late SharedPreferences prefs;
  final TextEditingController emailS = TextEditingController();
  final TextEditingController passwordS = TextEditingController();
  final TextEditingController yourNameS = TextEditingController();
  final TextEditingController repasswordS = TextEditingController();
  String errore = '';
  String errorp = '';

  String erroru = '';
  String errorps = '';
  String errores = '';
  String errorpr = '';
  void signup() async {
    UserCredential? result;
    try {
      if (yourNameS.text.isEmpty) {
        erroru = '           Vui lòng nhập name';
      }
      if (emailS.text.isEmpty) {
        errores = '           Vui lòng nhập email';
      }
      if (passwordS.text.isEmpty) {
        errorps = '           Vui lòng nhập password';
      }
      if (repasswordS.text.isEmpty) {
        errorpr = '           Vui lòng nhập lại password';
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
            .doc("listid");
        FirebaseFirestore.instance
            .collection("User")
            .doc(result.user!.uid)
            .collection("cart")
            .doc("listcart");
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
          FluroRouters.router
              .navigateTo(context, HomesScreen.routeName, replace: true);
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        setState(() {
          errorps = '           Mật khẩu quá yếu.';
        });
      } else if (e.code == 'email-already-in-use') {
        setState(() {
          errores = '           Tài khoản email đã tồn tại.';
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void submit() async {
    try {
      if (email.text.isEmpty) {
        errore = '           Vui lòng nhập email';
      }
      if (password.text.isEmpty) {
        errorp = '           Vui lòng nhập password';
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
            FluroRouters.router
                .navigateTo(context, HomesScreen.routeName, replace: true);
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          errore = '           Không tìm thấy email người dùng.';
        });
      } else if (e.code == 'wrong-password') {
        setState(() {
          errorp = '           Sai mật khẩu.';
        });
      }
    }
  }

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
    // Responsive.keys.currentState?.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
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
                  color: Color.fromARGB(255, 109, 219, 223).withOpacity(.85),
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
                            : "Signin to Continue",
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
                                    "LOGIN",
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
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignupScreen = true;
                                });
                              },
                              child: Column(
                                children: [
                                  Text(
                                    "SIGNUP",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: isSignupScreen
                                            ? Palette.activeColor
                                            : Palette.textColor1),
                                  ),
                                  if (isSignupScreen)
                                    Container(
                                      margin: EdgeInsets.only(top: 3),
                                      height: 2,
                                      width: 55,
                                      color: Colors.orange,
                                    )
                                ],
                              ),
                            )
                          ],
                        ),
                        if (isSignupScreen)
                          buildSignupSection(_size.width * 0.81),
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
            Positioned(
              top: MediaQuery.of(context).size.height - 100,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  Text(isSignupScreen ? "Or Signup with" : "Or Signin with"),
                  Container(
                    margin: EdgeInsets.only(right: 20, left: 20, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildTextButton(FontAwesomeIcons.facebookF, "Facebook",
                            Palette.facebookColor, _size.width * 0.35),
                        buildTextButton(FontAwesomeIcons.googlePlusG, "Google",
                            Palette.googleColor, _size.width * 0.35),
                      ],
                    ),
                  )
                ],
              ),
            )
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
          buildTextField(Icons.lock_outline, "**********", true, false, width,
              password, checkpass, errorp),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  FluroRouters.router.navigateTo(
                    context,
                    ForgotScreen.routeName,
                    replace: true,
                  );
                },
                child: Text("Forgot Password?",
                    style: TextStyle(fontSize: 12, color: Palette.textColor1)),
              )
            ],
          )
        ],
      ),
    );
  }

  Container buildSignupSection(double width) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildTextField(FontAwesomeIcons.userAlt, "Your Name", false, false,
              width, yourNameS, checkname, erroru),
          buildTextField(FontAwesomeIcons.envelope, "Email", false, true, width,
              emailS, checkemails, errores),
          buildTextField(FontAwesomeIcons.lock, "Password", true, false, width,
              passwordS, checkpasss, errorps),
          buildTextField(FontAwesomeIcons.lock, "Re-Password", true, false,
              width, repasswordS, checkpassr, errorpr),
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
                            borderRadius: BorderRadius.circular(15)),
                        child: Icon(
                          FontAwesomeIcons.userCircle,
                          color: isMale ? Colors.white : Palette.iconColor,
                        ),
                      ),
                      Text(
                        "Male",
                        style: TextStyle(color: Palette.textColor1),
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
                            borderRadius: BorderRadius.circular(15)),
                        child: Icon(
                          FontAwesomeIcons.userCircle,
                          color: isMale ? Palette.iconColor : Colors.white,
                        ),
                      ),
                      Text(
                        "Female",
                        style: TextStyle(color: Palette.textColor1),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 200,
            margin: EdgeInsets.only(top: 20),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "By pressing 'Submit' you agree to our ",
                  style: TextStyle(color: Palette.textColor2),
                  children: [
                    TextSpan(
                      //recognizer: ,
                      text: "term & conditions",
                      style: TextStyle(color: Colors.orange),
                    ),
                  ]),
            ),
          ),
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
                      !isSignupScreen ? submit() : signup();
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

  void checkpass(String value) {
    setState(() {
      String pattern = r"\s";
      RegExp regex = RegExp(pattern);
      if (value == '' || value.isEmpty)
        errorp = '';
      else if (regex.hasMatch(value)) {
        errorp = '           Password chứa khoảng trắng';
      } else if (value.length <= 6) {
        errorp = '           Password phải lớn hơn 6 ký tự';
      } else {
        errorp = '';
      }
    });
  }

  void checkname(String value) {
    setState(() {
      if (value == '' || value.isEmpty)
        erroru = '';
      else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)) {
        erroru = 'Tên không được chứa ký tự đặc biệt';
      } else {
        erroru = '';
      }
    });
  }

  void checkemails(String value) {
    setState(() {
      String pattern =
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
          r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
          r"{0,253}[a-zA-Z0-9])?)*$";
      RegExp regex = RegExp(pattern);
      if (value == null || value.isEmpty)
        errores = '';
      else if (!regex.hasMatch(value)) {
        errores = '           Email chưa đúng định dạng';
      } else {
        errores = '';
      }
    });
  }

  void checkpasss(String value) {
    setState(() {
      String pattern = r"\s";
      RegExp regex = RegExp(pattern);
      if (value == '' || value.isEmpty)
        errorps = '';
      else if (regex.hasMatch(value)) {
        errorps = '           Password chứa khoảng trắng';
      } else if (value.length <= 6) {
        errorps = '           Password phải lớn hơn 6 ký tự';
      } else {
        errorps = '';
      }
    });
  }

  void checkpassr(String value) {
    setState(() {
      String pattern = r"\s";
      RegExp regex = RegExp(pattern);
      if (value == '' || value.isEmpty)
        errorpr = '';
      else if (regex.hasMatch(value)) {
        errorpr = '           Passwork chứa khoảng trắng';
      } else if (value.length <= 6) {
        errorpr = '           Passwork phải lớn hơn 6 ký tự';
      } else if (repasswordS.text != passwordS.text) {
        errorpr = '           Repassword không trùng khớp';
      } else {
        errorpr = '';
      }
    });
  }
}

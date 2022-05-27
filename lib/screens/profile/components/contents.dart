// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:apporder/models/user.dart';
import 'package:apporder/provider/product_provider.dart';
import 'package:apporder/provider/cart_provider.dart';
import 'package:apporder/routes.dart';
import 'package:apporder/screens/bill/bill_screen.dart';
import 'package:apporder/screens/favourite/favourite.dart';
import 'package:apporder/screens/homes/homes_screen.dart';
import 'package:apporder/screens/login_signup/loginsignup_page.dart';
import 'package:apporder/screens/profile/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/utils/custom.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Contents extends StatefulWidget {
  const Contents({Key? key}) : super(key: key);

  @override
  _ContentsState createState() => _ContentsState();
}

late ProductProvider productProvider;
late CartProvider testdata;

class _ContentsState extends State<Contents> {
  String _uid = '';
  final TextEditingController emailS = TextEditingController();
  final TextEditingController passwordS = TextEditingController();
  final TextEditingController yourNameS = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController phone = TextEditingController();
  late DocumentReference<Map<String, dynamic>> likeRef;
  String geder = '';
  String pathavt = "";
  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser == null) {
      Timer.run(() {
        FluroRouters.router
            .navigateTo(context, LoginSignupScreen.routeName, replace: false);
      });
    } else {
      getCurrentUserUid().then(updateUid);
      if (FirebaseAuth.instance.currentUser != null) {
        likeRef = FirebaseFirestore.instance
            .collection("User")
            .doc(FirebaseAuth.instance.currentUser!.uid);
      }
    }
    super.initState();

    if (FirebaseAuth.instance.currentUser != null) {
      getCurrentUserUid().then((value) => {
            _uid = value,
            if (value.isEmpty || FirebaseAuth.instance.currentUser == null)
              {
                Timer.run(() {
                  FluroRouters.router.navigateTo(
                      context, LoginSignupScreen.routeName,
                      replace: true);
                })
              }
          });
    }
  }

  Future<String> getCurrentUserUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid').toString();
  }

  void updateUid(String uid) {
    setState(() {
      this._uid = uid;
    });
  }

  Future deleteShareprefence() async {
    FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("avt");
    await prefs.remove("uid");
    await prefs.remove("cart");
    await prefs.remove("count");
  }

  Future<void> _resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      productProvider = Provider.of<ProductProvider>(context);
      testdata = Provider.of<CartProvider>(context, listen: false);
      return Container(
        color: Color(0xffe3e9ef),
        padding: EdgeInsets.symmetric(
            horizontal: Responsive.isDesktop(context) ? 50.0 : 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              height: Responsive.isDesktop(context) ? 850 : 1200,
              child: Stack(
                children: [
                  Positioned(
                    child: SizedBox(
                      height: 180,
                      child: Container(
                        color: Color(0xFF2C3C4E),
                      ),
                    ),
                  ),
                  Responsive.isDesktop(context)
                      ? Positioned(
                          top: 180 / 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  "Thông Tin Hồ Sơ",
                                  style: TextStyle(
                                      fontSize: 24, color: Color(0xFFEEEEEE)),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 440,
                                child: Container(
                                  width:
                                      Responsive.getSize(context).width * 0.25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(6),
                                      bottomLeft: Radius.circular(6),
                                      bottomRight: Radius.circular(6),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 25, left: 13, bottom: 30),
                                        child: StreamBuilder(
                                            stream: productProvider
                                                .getUserData(
                                                    id: FirebaseAuth.instance
                                                        .currentUser!.uid)
                                                .asStream(),
                                            builder: (context,
                                                AsyncSnapshot<List<UserModel>>
                                                    snapshot) {
                                              if (!snapshot.hasData) {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                              pathavt = snapshot.data![0].avt;
                                              if (geder == '') {
                                                geder = "tp";
                                                productProvider.addGenders(
                                                    snapshot.data![0].gender);
                                              }
                                              return Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 45.0,
                                                    backgroundImage:
                                                        NetworkImage(pathavt),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: (Responsive.getSize(
                                                                        context)
                                                                    .width *
                                                                0.25) *
                                                            0.5,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(snapshot
                                                                .data![0].name),
                                                            Text(
                                                              snapshot.data![0]
                                                                  .email,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              softWrap: false,
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              );
                                            }),
                                      ),
                                      Container(
                                        width:
                                            Responsive.getSize(context).width *
                                                0.25,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 13, vertical: 20),
                                          child: InkWell(
                                            onTap: () {
                                              FluroRouters.router.navigateTo(
                                                  context, BillScreen.routeName,
                                                  replace: true);
                                            },
                                            child: Text(
                                              'Đơn hàng',
                                            ),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                color: Color(0xFFA8A8A8)),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            Responsive.getSize(context).width *
                                                0.25,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 13, vertical: 20),
                                          child: InkWell(
                                            onTap: () {
                                              FluroRouters.router.navigateTo(
                                                  context,
                                                  FavouriteScreen.routeName,
                                                  replace: true);
                                            },
                                            child: Text(
                                              'Sản phẩm yêu thích',
                                            ),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                color: Color(0xFFA8A8A8)),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            Responsive.getSize(context).width *
                                                0.25,
                                        height: 50,
                                        color: Color(0xFFf6f9fc),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 13, top: 15, bottom: 15),
                                          child: Text("Cài đặt tài khoản"),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            Responsive.getSize(context).width *
                                                0.25,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 13, vertical: 20),
                                          child: Text(
                                            'Thông tin cá nhân',
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                color: Color(0xFFA8A8A8)),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 13, vertical: 20),
                                        child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                deleteShareprefence();
                                                FluroRouters.router.navigateTo(
                                                    context,
                                                    HomesScreen.routeName,
                                                    replace: true);
                                              });
                                            },
                                            child: Text("Đăng xuất")),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ))
                      : Positioned(
                          top: 180 / 3.5,
                          right: 25,
                          left: 25,
                          child: SizedBox(
                            height: 150,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(6),
                                  bottomLeft: Radius.circular(6),
                                  bottomRight: Radius.circular(6),
                                  topLeft: Radius.circular(6),
                                ),
                                color: Colors.white,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 5, bottom: 10),
                                    child: StreamBuilder(
                                        stream: productProvider
                                            .getUserData(
                                                id: FirebaseAuth
                                                    .instance.currentUser!.uid)
                                            .asStream(),
                                        builder: (context,
                                            AsyncSnapshot<List<UserModel>>
                                                snapshot) {
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                          pathavt = snapshot.data![0].avt;
                                          if (geder == '') {
                                            geder = "tp";
                                            productProvider.addGenders(
                                                snapshot.data![0].gender);
                                          }
                                          return Column(
                                            children: [
                                              CircleAvatar(
                                                radius: 35.0,
                                                backgroundImage:
                                                    NetworkImage(pathavt),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(snapshot.data![0].name),
                                            ],
                                          );
                                        }),
                                  ),
                                  Row(
                                    children: [
                                      Spacer(),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            FluroRouters.router.navigateTo(
                                                context, BillScreen.routeName,
                                                replace: true);
                                          });
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: Color(0xffe7e7e7),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 3,
                                                  color: Color(0xffa6a6a6),
                                                  offset: Offset(2, 2),
                                                ),
                                                BoxShadow(
                                                  blurRadius: 3,
                                                  color: Color(0xffffffff),
                                                  offset: Offset(-2, -2),
                                                ),
                                              ],
                                              gradient: LinearGradient(
                                                stops: [0, 1],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  Color(0xffd0d0d0),
                                                  Color(0xfff7f7f7)
                                                ],
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                5,
                                              ))),
                                          child: Center(
                                            child: Text(
                                              'Đơn hàng',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 30),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            FluroRouters.router.navigateTo(
                                                context,
                                                FavouriteScreen.routeName,
                                                replace: true);
                                          });
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 120,
                                          decoration: BoxDecoration(
                                              color: Color(0xffe7e7e7),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 3,
                                                  color: Color(0xffa6a6a6),
                                                  offset: Offset(2, 2),
                                                ),
                                                BoxShadow(
                                                  blurRadius: 3,
                                                  color: Color(0xffffffff),
                                                  offset: Offset(-2, -2),
                                                ),
                                              ],
                                              gradient: LinearGradient(
                                                stops: [0, 1],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  Color(0xffd0d0d0),
                                                  Color(0xfff7f7f7)
                                                ],
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                5,
                                              ))),
                                          child: Center(
                                            child: Text(
                                              'Sản phẩm yêu thích',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  Responsive.isDesktop(context)
                      ? Positioned(
                          top: 220,
                          right: 40,
                          child: SizedBox(
                            height: 600,
                            child: StreamBuilder(
                                stream: productProvider
                                    .getUserData(
                                        id: FirebaseAuth
                                            .instance.currentUser!.uid)
                                    .asStream(),
                                builder: (context,
                                    AsyncSnapshot<List<UserModel>> snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  pathavt = snapshot.data![0].avt;
                                  return Container(
                                    width: Responsive.getSize(context).width *
                                            0.7 -
                                        100,
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(20),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 45.0,
                                                backgroundImage:
                                                    NetworkImage(pathavt),
                                              ),
                                              SizedBox(
                                                width: 25,
                                              ),
                                              RaisedButton.icon(
                                                onPressed: () async {
                                                  FilePickerResult? result =
                                                      await FilePicker.platform
                                                          .pickFiles();
                                                  if (result != null) {
                                                    PlatformFile file =
                                                        result.files.first;
                                                    String dir = FirebaseAuth
                                                        .instance
                                                        .currentUser!
                                                        .uid;
                                                    String name = file.name;
                                                    List<String> newname =
                                                        name.split(".");
                                                    String base64 =
                                                        uint8ListTob64(
                                                            file.bytes!);
                                                    String url =
                                                        "https://tyhoang.ga/images/api_image.php";
                                                    final response = await http
                                                        .post(Uri.parse(url),
                                                            body: {
                                                          "base64": base64,
                                                          "name": name,
                                                          "directory": dir
                                                        });
                                                    if (response.body
                                                            .toString() ==
                                                        "1") {
                                                      setState(() {
                                                        pathavt =
                                                            "https://www.tyhoang.ga/images/uploads/" +
                                                                dir +
                                                                "/" +
                                                                newname[0] +
                                                                ".png";
                                                        testdata
                                                            .addLink(pathavt);
                                                        if (FirebaseAuth
                                                                .instance
                                                                .currentUser !=
                                                            null) {
                                                          likeRef.update({
                                                            "avtar": pathavt
                                                          });
                                                        }
                                                      });
                                                    }
                                                  } else {
                                                    return;
                                                  }
                                                },
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5.0))),
                                                label: Text(
                                                  'Change avatar',
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                ),
                                                icon: Icon(
                                                  Icons.change_circle_outlined,
                                                  color: Colors.blue,
                                                ),
                                                textColor: Colors.white,
                                                splashColor: Colors.red,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Color(0xFFA8A8A8)),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(20),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 15.0),
                                                    child: Text("Full Name:"),
                                                  ),
                                                  buildTextField(
                                                      FontAwesomeIcons.userAlt,
                                                      snapshot.data![0].name,
                                                      false,
                                                      false,
                                                      (Responsive.getSize(context)
                                                                      .width *
                                                                  0.7 -
                                                              100) *
                                                          0.4,
                                                      yourNameS,
                                                      true),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 15.0),
                                                    child: Text("Email:"),
                                                  ),
                                                  buildTextField(
                                                      FontAwesomeIcons.envelope,
                                                      snapshot.data![0].email,
                                                      false,
                                                      true,
                                                      (Responsive.getSize(context)
                                                                      .width *
                                                                  0.7 -
                                                              100) *
                                                          0.4,
                                                      emailS,
                                                      false),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 15.0),
                                                    child: Text(
                                                        "Change Password:"),
                                                  ),
                                                  RaisedButton(
                                                    onPressed: () {
                                                      _resetPassword(snapshot
                                                          .data![0].email);
                                                    },
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5.0))),
                                                    child: Text(
                                                      'Send mail',
                                                      style: TextStyle(
                                                          color: Colors.blue),
                                                    ),
                                                    textColor: Colors.white,
                                                    splashColor: Colors.red,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(20),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 15.0),
                                                    child: Text(
                                                        "Change Number-Phone:"),
                                                  ),
                                                  buildTextField(
                                                      FontAwesomeIcons.userAlt,
                                                      snapshot.data![0].phone ==
                                                              ''
                                                          ? "(+84)"
                                                          : snapshot
                                                              .data![0].phone,
                                                      false,
                                                      false,
                                                      (Responsive.getSize(context)
                                                                      .width *
                                                                  0.7 -
                                                              100) *
                                                          0.4,
                                                      phone,
                                                      true),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 15.0),
                                                    child:
                                                        Text("Change Address:"),
                                                  ),
                                                  buildTextField(
                                                      FontAwesomeIcons.envelope,
                                                      snapshot.data![0]
                                                                  .address ==
                                                              ''
                                                          ? "Duy Sơn, Duy Xuyên, Quảng Nam"
                                                          : snapshot
                                                              .data![0].address,
                                                      false,
                                                      true,
                                                      (Responsive.getSize(context)
                                                                      .width *
                                                                  0.7 -
                                                              100) *
                                                          0.4,
                                                      address,
                                                      true),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10, left: 10),
                                                    child: Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              productProvider
                                                                  .addGenders(
                                                                      'Male');
                                                            });
                                                          },
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                width: 30,
                                                                height: 30,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            8),
                                                                decoration: BoxDecoration(
                                                                    color: productProvider.getGender() ==
                                                                            'Male'
                                                                        ? Palette
                                                                            .textColor2
                                                                        : Colors
                                                                            .transparent,
                                                                    border: Border.all(
                                                                        width:
                                                                            1,
                                                                        color: productProvider.getGender() ==
                                                                                'Male'
                                                                            ? Colors
                                                                                .transparent
                                                                            : Palette
                                                                                .textColor1),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15)),
                                                                child: Icon(
                                                                  FontAwesomeIcons
                                                                      .userCircle,
                                                                  color: productProvider
                                                                              .getGender() ==
                                                                          'Male'
                                                                      ? Colors
                                                                          .white
                                                                      : Palette
                                                                          .iconColor,
                                                                ),
                                                              ),
                                                              Text(
                                                                "Male",
                                                                style: TextStyle(
                                                                    color: Palette
                                                                        .textColor1),
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
                                                              productProvider
                                                                  .addGenders(
                                                                      'Female');
                                                            });
                                                          },
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                width: 30,
                                                                height: 30,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            8),
                                                                decoration: BoxDecoration(
                                                                    color: productProvider.getGender() !=
                                                                            'Female'
                                                                        ? Colors
                                                                            .transparent
                                                                        : Palette
                                                                            .textColor2,
                                                                    border: Border.all(
                                                                        width:
                                                                            1,
                                                                        color: productProvider.getGender() !=
                                                                                'Female'
                                                                            ? Palette
                                                                                .textColor1
                                                                            : Colors
                                                                                .transparent),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15)),
                                                                child: Icon(
                                                                  FontAwesomeIcons
                                                                      .userCircle,
                                                                  color: productProvider
                                                                              .getGender() !=
                                                                          'Female'
                                                                      ? Palette
                                                                          .iconColor
                                                                      : Colors
                                                                          .white,
                                                                ),
                                                              ),
                                                              Text(
                                                                "Female",
                                                                style: TextStyle(
                                                                    color: Palette
                                                                        .textColor1),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Center(
                                          child: RaisedButton(
                                            onPressed: () {
                                              setState(() {
                                                if (!address.text.isEmpty ||
                                                    !phone.text.isEmpty ||
                                                    !yourNameS.text.isEmpty) {
                                                  if (yourNameS.text.isEmpty) {
                                                    yourNameS.text =
                                                        snapshot.data![0].name;
                                                  }
                                                  if (phone.text.isEmpty) {
                                                    phone.text =
                                                        snapshot.data![0].phone;
                                                  }
                                                  if (address.text.isEmpty) {
                                                    address.text = snapshot
                                                        .data![0].address;
                                                  }
                                                  likeRef.update({
                                                    "UserName": yourNameS.text,
                                                    "address": address.text,
                                                    "phone": phone.text,
                                                    "UserGender": productProvider.getGender(),
                                                  });
                                                  FluroRouters.router
                                                      .navigateTo(
                                                    context,
                                                    ProfileScreen.routeName,
                                                    replace: true,
                                                  );
                                                } else {
                                                  yourNameS.text =
                                                      snapshot.data![0].name;
                                                  phone.text =
                                                      snapshot.data![0].phone;
                                                  address.text =
                                                      snapshot.data![0].address;
                                                  likeRef.update({
                                                    "UserName": yourNameS.text,
                                                    "address": address.text,
                                                    "phone": phone.text,
                                                    "UserGender": productProvider.getGender(),
                                                  });
                                                  FluroRouters.router
                                                      .navigateTo(
                                                    context,
                                                    ProfileScreen.routeName,
                                                    replace: true,
                                                  );
                                                }
                                              });
                                            },
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0))),
                                            child: Text(
                                              'Save Change',
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                            textColor: Colors.white,
                                            splashColor: Colors.red,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        )
                      : Positioned(
                          top: 220,
                          right: 15,
                          left: 15,
                          child: SizedBox(
                            height: 850,
                            child: StreamBuilder(
                                stream: productProvider
                                    .getUserData(
                                        id: FirebaseAuth
                                            .instance.currentUser!.uid)
                                    .asStream(),
                                builder: (context,
                                    AsyncSnapshot<List<UserModel>> snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  pathavt = snapshot.data![0].avt;
                                  return Container(
                                    width: Responsive.getSize(context).width *
                                        0.95,
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(20),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 45.0,
                                                backgroundImage:
                                                    NetworkImage(pathavt),
                                              ),
                                              SizedBox(
                                                width: 25,
                                              ),
                                              RaisedButton.icon(
                                                onPressed: () async {
                                                  FilePickerResult? result =
                                                      await FilePicker.platform
                                                          .pickFiles(
                                                              withData: true);
                                                  if (result != null) {
                                                    PlatformFile file =
                                                        result.files.first;
                                                    String dir = FirebaseAuth
                                                        .instance
                                                        .currentUser!
                                                        .uid;
                                                    String name = file.name;
                                                    List<String> newname =
                                                        name.split(".");
                                                    String base64 =
                                                        uint8ListTob64(
                                                            file.bytes!);
                                                    String url =
                                                        "https://tyhoang.ga/images/api_image.php";
                                                    final response = await http
                                                        .post(Uri.parse(url),
                                                            body: {
                                                          "base64": base64,
                                                          "name": name,
                                                          "directory": dir
                                                        });
                                                    if (response.body
                                                            .toString() ==
                                                        "1") {
                                                      setState(() {
                                                        pathavt =
                                                            "https://www.tyhoang.ga/images/uploads/" +
                                                                dir +
                                                                "/" +
                                                                newname[0] +
                                                                ".png";
                                                        testdata
                                                            .addLink(pathavt);
                                                        if (FirebaseAuth
                                                                .instance
                                                                .currentUser !=
                                                            null) {
                                                          likeRef.update({
                                                            "avtar": pathavt
                                                          });
                                                        }
                                                      });
                                                    }
                                                  } else {
                                                    return;
                                                  }
                                                },
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5.0))),
                                                label: Text(
                                                  'Change avatar',
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                ),
                                                icon: Icon(
                                                  Icons.change_circle_outlined,
                                                  color: Colors.blue,
                                                ),
                                                textColor: Colors.white,
                                                splashColor: Colors.red,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Color(0xFFA8A8A8)),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 15.0),
                                                child: Text("Full Name:"),
                                              ),
                                              buildTextField(
                                                  FontAwesomeIcons.userAlt,
                                                  snapshot.data![0].name,
                                                  false,
                                                  false,
                                                  Responsive.getSize(context)
                                                          .width *
                                                      0.95,
                                                  yourNameS,
                                                  true),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 15.0),
                                                child: Text("Email:"),
                                              ),
                                              buildTextField(
                                                  FontAwesomeIcons.envelope,
                                                  snapshot.data![0].email,
                                                  false,
                                                  true,
                                                  Responsive.getSize(context)
                                                          .width *
                                                      0.95,
                                                  emailS,
                                                  false),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 15.0),
                                                child: Text("Change Password:"),
                                              ),
                                              RaisedButton(
                                                onPressed: () {
                                                  _resetPassword(
                                                      snapshot.data![0].email);
                                                },
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5.0))),
                                                child: Text(
                                                  'Send mail',
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                ),
                                                textColor: Colors.white,
                                                splashColor: Colors.red,
                                                color: Colors.white,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 15.0),
                                                child: Text("Number-Phone:"),
                                              ),
                                              buildTextField(
                                                  FontAwesomeIcons.userAlt,
                                                  snapshot.data![0].phone == ''
                                                      ? "(+84)"
                                                      : snapshot.data![0].phone,
                                                  false,
                                                  false,
                                                  Responsive.getSize(context)
                                                          .width *
                                                      0.95,
                                                  phone,
                                                  true),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 15.0),
                                                child: Text("Address:"),
                                              ),
                                              buildTextField(
                                                  FontAwesomeIcons.envelope,
                                                  snapshot.data![0].address ==
                                                          ''
                                                      ? "Duy Sơn, Duy Xuyên, Quảng Nam"
                                                      : snapshot
                                                          .data![0].address,
                                                  false,
                                                  true,
                                                  Responsive.getSize(context)
                                                          .width *
                                                      0.95,
                                                  address,
                                                  true),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10, left: 10),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          productProvider
                                                              .addGenders(
                                                                  'Male');
                                                        });
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 30,
                                                            height: 30,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 8),
                                                            decoration: BoxDecoration(
                                                                color: productProvider.getGender() ==
                                                                        'Male'
                                                                    ? Palette
                                                                        .textColor2
                                                                    : Colors
                                                                        .transparent,
                                                                border: Border.all(
                                                                    width: 1,
                                                                    color: productProvider.getGender() ==
                                                                            'Male'
                                                                        ? Colors
                                                                            .transparent
                                                                        : Palette
                                                                            .textColor1),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                            child: Icon(
                                                              FontAwesomeIcons
                                                                  .userCircle,
                                                              color: productProvider
                                                                          .getGender() ==
                                                                      'Male'
                                                                  ? Colors.white
                                                                  : Palette
                                                                      .iconColor,
                                                            ),
                                                          ),
                                                          Text(
                                                            "Male",
                                                            style: TextStyle(
                                                                color: Palette
                                                                    .textColor1),
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
                                                          productProvider
                                                              .addGenders(
                                                                  'Female');
                                                        });
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 30,
                                                            height: 30,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 8),
                                                            decoration: BoxDecoration(
                                                                color: productProvider.getGender() ==
                                                                        'Female'
                                                                    ? Colors
                                                                        .transparent
                                                                    : Palette
                                                                        .textColor2,
                                                                border: Border.all(
                                                                    width: 1,
                                                                    color: productProvider.getGender() ==
                                                                            'Female'
                                                                        ? Palette
                                                                            .textColor1
                                                                        : Colors
                                                                            .transparent),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                            child: Icon(
                                                              FontAwesomeIcons
                                                                  .userCircle,
                                                              color: productProvider
                                                                          .getGender() ==
                                                                      'Female'
                                                                  ? Palette
                                                                      .iconColor
                                                                  : Colors
                                                                      .white,
                                                            ),
                                                          ),
                                                          Text(
                                                            "Female",
                                                            style: TextStyle(
                                                                color: Palette
                                                                    .textColor1),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Center(
                                          child: RaisedButton(
                                            onPressed: () {
                                              setState(() {
                                                if (!address.text.isEmpty ||
                                                    !phone.text.isEmpty ||
                                                    !yourNameS.text.isEmpty) {
                                                  if (yourNameS.text.isEmpty) {
                                                    yourNameS.text =
                                                        snapshot.data![0].name;
                                                  }
                                                  if (phone.text.isEmpty) {
                                                    phone.text =
                                                        snapshot.data![0].phone;
                                                  }
                                                  if (address.text.isEmpty) {
                                                    address.text = snapshot
                                                        .data![0].address;
                                                  }
                                                  likeRef.update({
                                                    "UserName": yourNameS.text,
                                                    "address": address.text,
                                                    "phone": phone.text,
                                                    "UserGender":
                                                        productProvider
                                                            .getGender(),
                                                  });
                                                  FluroRouters.router
                                                      .navigateTo(
                                                    context,
                                                    ProfileScreen.routeName,
                                                    replace: true,
                                                  );
                                                } else {
                                                  yourNameS.text =
                                                      snapshot.data![0].name;
                                                  phone.text =
                                                      snapshot.data![0].phone;
                                                  address.text =
                                                      snapshot.data![0].address;
                                                likeRef.update({
                                                    "UserName": yourNameS.text,
                                                    "address": address.text,
                                                    "phone": phone.text,
                                                    "UserGender":
                                                        productProvider
                                                            .getGender(),
                                                  });
                                                  FluroRouters.router
                                                      .navigateTo(
                                                    context,
                                                    ProfileScreen.routeName,
                                                    replace: true,
                                                  );}
                                              });
                                            },
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0))),
                                            child: Text(
                                              'Save Change',
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                            textColor: Colors.white,
                                            splashColor: Colors.red,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget buildTextField(
      IconData icon,
      String hintText,
      bool isPassword,
      bool isEmail,
      double width,
      TextEditingController controller,
      bool checkT) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9.0),
      child: Container(
        width: width,
        decoration: BoxDecoration(
            color: Color(0xFFEBEBEB),
            borderRadius: BorderRadius.circular(6),
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
          enabled: checkT,
          controller: controller,
          obscureText: isPassword,
          keyboardType:
              isEmail ? TextInputType.emailAddress : TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Palette.iconColor,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFEBEBEB)),
              borderRadius: BorderRadius.all(Radius.circular(35.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFEBEBEB)),
              borderRadius: BorderRadius.all(Radius.circular(35.0)),
            ),
            contentPadding: EdgeInsets.all(10),
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
          ),
        ),
      ),
    );
  }

  String uint8ListTob64(Uint8List uint8list) {
    String base64String = base64Encode(uint8list);
    String header = "data:image/png;base64,";
    return header + base64String;
  }
}

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_this, prefer_is_empty, await_only_futures, avoid_function_literals_in_foreach_calls, sized_box_for_whitespace, deprecated_member_use, prefer_is_not_empty

import 'dart:async';

import 'package:apporder/models/cart.dart';
import 'package:apporder/provider/cart_provider.dart';
import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/routes.dart';
import 'package:apporder/screens/bill/bill_screen.dart';
import 'package:apporder/screens/login_signup/loginsignup_page.dart';
import 'package:apporder/utils/custom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Contents extends StatefulWidget {
  final List<CartModel> snapshot;
  final String codebill;
  final String name;
  final String phone;
  final String address;
  const Contents(
      {Key? key,
      required this.snapshot,
      required this.codebill,
      required this.name,
      required this.phone,
      required this.address})
      : super(key: key);

  @override
  _ContentsState createState() => _ContentsState();
}

late CartProvider testdata;

class _ContentsState extends State<Contents> {
  late SharedPreferences prefs;
  List<CartModel> myList = [];
  Future<List<CartModel>>? data;
  final TextEditingController yourNameS = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController phone = TextEditingController();
  bool cartdata = false;
  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser == null) {
      Timer.run(() {
        FluroRouters.router
            .navigateTo(context, LoginSignupScreen.routeName, replace: true);
      });
    } else {
      this.myList = widget.snapshot;
    }
    super.initState();
    data = categoryList();
  }

  Future<List<CartModel>> categoryList() async {
    return await myList;
  }

  Future<void> addcardShare(CartModel product) async {
    if (myList.length > 0) {
      myList.forEach((element) {
        if (element.id == product.id) {
          element.quantity += 1;
          if (FirebaseAuth.instance.currentUser != null) {
            FirebaseFirestore.instance
                .collection("User")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("bill")
                .doc(widget.codebill)
                .update({"item": getItemcart(), "price": getPricecart()});

            CollectionReference likeRef = FirebaseFirestore.instance
                .collection("User")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("bill")
                .doc(widget.codebill)
                .collection("cart");
            likeRef.doc(product.id).update(CartModel.toMap(product));
          }
        }
      });
    }
  }

  Future<void> removecardShare(CartModel product) async {
    if (myList.length > 0) {
      myList.forEach((element) {
        if (element.id == product.id) {
          if (element.quantity > 1) {
            element.quantity -= 1;
            if (FirebaseAuth.instance.currentUser != null) {
              FirebaseFirestore.instance
                  .collection("User")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("bill")
                  .doc(widget.codebill)
                  .update({"item": getItemcart(), "price": getPricecart()});
              CollectionReference likeRef = FirebaseFirestore.instance
                  .collection("User")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("bill")
                  .doc(widget.codebill)
                  .collection("cart");
              likeRef.doc(product.id).update(CartModel.toMap(product));
            }
          }
        }
      });
    }
  }

  Future<void> deletecardShare(CartModel product) async {
    int index = 0;
    myList.asMap().forEach((key, value) {
      if (value.id == product.id) index = key;
    });
    myList.removeAt(index);
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseFirestore.instance
          .collection("User")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("bill")
          .doc(widget.codebill)
          .update({"item": getItemcart(), "price": getPricecart()});
      CollectionReference likeRef = FirebaseFirestore.instance
          .collection("User")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("bill")
          .doc(widget.codebill)
          .collection("cart");
      likeRef.doc(product.id).delete();
    }
  }

  String getItemcart() {
    dynamic item = 0;
    if (myList.length > 0) {
      myList.forEach((element) {
        item += element.quantity;
      });
    }
    return item.toString();
  }

  num getPricecart() {
    dynamic item = 0;
    if (myList.length > 0) {
      myList.forEach((element) {
        item += (element.price * element.quantity);
      });
    }
    return item;
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      testdata = Provider.of<CartProvider>(context, listen: false);
      return Container(
        padding: EdgeInsets.symmetric(
            horizontal: Responsive.isDesktop(context) ? 140.0 : 0),
        child: StreamBuilder(
            stream: data!.asStream(),
            builder: (context, AsyncSnapshot<List<CartModel>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (myList.isEmpty) {
                return Center(
                    child: Text("Chưa có sản phẩm nào trong giỏ"));
              }
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  if (myList.length > 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        padding: EdgeInsets.only(top: 10, right: 10, left: 10),
                        height: 600,
                        color: Colors.blue,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 500,
                              child: Container(
                                width: Responsive.getSize(context).width * 0.95,
                                color: Colors.white,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                              widget.name,
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
                                            child: Text("Number-Phone:"),
                                          ),
                                          buildTextField(
                                              FontAwesomeIcons.userAlt,
                                              widget.phone,
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
                                              widget.address,
                                              false,
                                              true,
                                              Responsive.getSize(context)
                                                      .width *
                                                  0.95,
                                              address,
                                              true),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Center(
                                      child: SizedBox(
                                        width: 230,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RaisedButton(
                                              onPressed: () {
                                                setState(() {
                                                  FluroRouters.router
                                                      .navigateTo(context,
                                                          BillScreen.routeName,
                                                          replace: true);
                                                });
                                              },
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              5.0))),
                                              child: Text(
                                                'Back',
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ),
                                              textColor: Colors.white,
                                              splashColor: Colors.red,
                                              color: Colors.white,
                                            ),
                                            RaisedButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (!address.text.isEmpty ||
                                                      !phone.text.isEmpty ||
                                                      !yourNameS.text.isEmpty) {
                                                    if (yourNameS
                                                        .text.isEmpty) {
                                                      yourNameS.text =
                                                          widget.name;
                                                    }
                                                    if (phone.text.isEmpty) {
                                                      phone.text = widget.phone;
                                                    }
                                                    if (address.text.isEmpty) {
                                                      address.text =
                                                          widget.address;
                                                    }
                                                    CollectionReference
                                                        likeRef =
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection("User")
                                                            .doc(FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid)
                                                            .collection("bill");
                                                    likeRef
                                                        .doc(widget.codebill)
                                                        .update({
                                                      "name": yourNameS.text,
                                                      "address": address.text,
                                                      "phone": phone.text,
                                                    });
                                                    FluroRouters.router
                                                        .navigateTo(
                                                      context,
                                                      BillScreen.routeName,
                                                      replace: true,
                                                    );
                                                  }
                                                });
                                              },
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              5.0))),
                                              child: Text(
                                                'Save Change',
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
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Item Price"),
                                Text(getItemcart())
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Subtotal"),
                                Text(NumberFormat.currency(locale: 'vi')
                                    .format(getPricecart()))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  Container(
                    height: myList.length > 0 ? 500 : 150,
                    child: ListView.builder(
                      itemCount: myList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Container(
                            width: Responsive.getSize(context).width,
                            height: 120,
                            decoration: BoxDecoration(
                                color: Color(0xB2E4E4E4),
                                border: Border.all(
                                  color: Color(0xFFFFFFFF),
                                ),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xDA8A8989),
                                      blurRadius: 1.0,
                                      offset: Offset(1, 1))
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          myList.elementAt(index).image,
                                          fit: BoxFit.cover,
                                          height: 100,
                                          width: 100,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(myList.elementAt(index).name),
                                        Text(NumberFormat.currency(locale: 'vi')
                                            .format(
                                                myList.elementAt(index).price)
                                            .toString()),
                                        Text(
                                            "size: ${myList.elementAt(index).size}"),
                                      ],
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            // color: Color(0xE7FFA9A9),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0xCBE2E2E2),
                                                offset: Offset(1, 3),
                                                blurRadius: 10,
                                              ),
                                            ]),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    color: Color(0xFFF8F8F8),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color:
                                                            Color(0xCBE2E2E2),
                                                        offset: Offset(1, 3),
                                                        blurRadius: 10,
                                                      ),
                                                    ]),
                                                child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        testdata.removeCount();
                                                        removecardShare(myList
                                                            .elementAt(index));
                                                      });
                                                    },
                                                    child: Icon(Icons.remove))),
                                            Text(myList
                                                .elementAt(index)
                                                .quantity
                                                .toString()),
                                            Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    color: Color(0xFFF8F8F8),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color:
                                                            Color(0xCBE2E2E2),
                                                        offset: Offset(1, 3),
                                                        blurRadius: 10,
                                                      ),
                                                    ]),
                                                child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        addcardShare(myList
                                                            .elementAt(index));
                                                      });
                                                    },
                                                    child: Icon(Icons.add))),
                                          ],
                                        ),
                                      ),
                                      Text(NumberFormat.currency(locale: 'vi')
                                          .format(myList
                                                  .elementAt(index)
                                                  .price *
                                              myList.elementAt(index).quantity)
                                          .toString()),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            deletecardShare(
                                                myList.elementAt(index));
                                          });
                                        },
                                        child: Icon(
                                          MdiIcons.delete,
                                          size: 20,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }),
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
}

// https://tamnguyen.com.vn/thiet-ke-website-do-an-vie-food.html

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_this, prefer_is_empty, await_only_futures, avoid_function_literals_in_foreach_calls, sized_box_for_whitespace, deprecated_member_use

import 'dart:async';

import 'package:apporder/models/bill.dart';
import 'package:apporder/models/screenarguments.dart';
import 'package:apporder/provider/product_provider.dart';
import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/routes.dart';
import 'package:apporder/screens/detailbill/detailbill_screen.dart';
import 'package:apporder/screens/login_signup/loginsignup_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class Contents extends StatefulWidget {
  const Contents({Key? key}) : super(key: key);

  @override
  _ContentsState createState() => _ContentsState();
}

late ProductProvider productdata;

class _ContentsState extends State<Contents> {
  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser == null) {
      Timer.run(() {
        FluroRouters.router
            .navigateTo(context, LoginSignupScreen.routeName, replace: true);
      });
    }
    super.initState();
  }

  Future<void> deletebill(String id) async {
    if (FirebaseAuth.instance.currentUser != null) {
      CollectionReference likeRef = FirebaseFirestore.instance
          .collection("User")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("bill");
      likeRef.doc(id).collection('cart').get().then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          ds.reference.delete();
        }
      });
      likeRef.doc(id).delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    productdata = Provider.of<ProductProvider>(context, listen: false);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Responsive.isDesktop(context) ? 140.0 : 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: 500,
            child: StreamBuilder(
                stream: productdata.getBillData().asStream(),
                builder: (context, AsyncSnapshot<List<BillModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.data!.isEmpty) {
                    return Center(child: Text("Chưa có đơn hàng nào"));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        "https://tyhoang.ga/images/uploads/bill.png",
                                        fit: BoxFit.cover,
                                        height: 80,
                                        width: 80,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                          "Mã đơn: ${snapshot.data!.elementAt(index).codebill}"),
                                      Text(
                                          "Ngày đặt: ${snapshot.data!.elementAt(index).date}"),
                                      Text(
                                          "Mã bưu phẩm: ${snapshot.data!.elementAt(index).postcode}"),
                                      Text(
                                          "Giá đơn: ${NumberFormat.currency(locale: 'vi').format(snapshot.data!.elementAt(index).price)}"),
                                    ],
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(snapshot.data!
                                                .elementAt(index)
                                                .status
                                                .toString() ==
                                            "0"
                                        ? "Chưa duyệt"
                                        : "Đã duyệt"),
                                    Text(
                                        "Item: ${snapshot.data!.elementAt(index).item}"),
                                    // Text(NumberFormat.currency(locale: 'vi')
                                    //     .format(myList.elementAt(index).price *
                                    //         myList.elementAt(index).quantity)
                                    //     .toString()),
                                    Container(
                                      width: snapshot.data!
                                                  .elementAt(index)
                                                  .status
                                                  .toString() ==
                                              "0"
                                          ? 50
                                          : 100,
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
                                      child: snapshot.data!
                                                  .elementAt(index)
                                                  .status
                                                  .toString() ==
                                              "0"
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      deletebill(snapshot.data!
                                                          .elementAt(index)
                                                          .codebill);
                                                    });
                                                  },
                                                  child: Icon(
                                                    MdiIcons.delete,
                                                    size: 20,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      FluroRouters.router
                                                          .navigateTo(
                                                              context,
                                                              DetailbillScreen
                                                                  .routeName,
                                                              routeSettings:
                                                                  RouteSettings(
                                                                arguments:
                                                                    DetailbillArguments(
                                                                  snapshot: snapshot
                                                                      .data!
                                                                      .elementAt(
                                                                          index)
                                                                      .cart,
                                                                  codebill: snapshot
                                                                      .data!
                                                                      .elementAt(
                                                                          index)
                                                                      .codebill,
                                                                  name: snapshot
                                                                      .data!
                                                                      .elementAt(
                                                                          index)
                                                                      .name,
                                                                  phone: snapshot
                                                                      .data!
                                                                      .elementAt(
                                                                          index)
                                                                      .phone,
                                                                  address: snapshot
                                                                      .data!
                                                                      .elementAt(
                                                                          index)
                                                                      .address,
                                                                ),
                                                              ),
                                                              replace: true);
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.edit,
                                                    size: 20,
                                                  ),
                                                )
                                              ],
                                            )
                                          : Center(
                                              child: Text(snapshot.data!
                                                  .elementAt(index)
                                                  .phoneship)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}

// https://tamnguyen.com.vn/thiet-ke-website-do-an-vie-food.html

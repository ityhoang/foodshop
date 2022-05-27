// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_this, await_only_futures, prefer_is_empty, avoid_function_literals_in_foreach_calls, deprecated_member_use


import 'package:apporder/models/cart.dart';
import 'package:apporder/models/screenarguments.dart';
import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/routes.dart';
import 'package:apporder/screens/admin/screens/viewbill/viewbill_screen.dart';
import 'package:apporder/utils/custom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class Contents extends StatefulWidget {
  final List<CartModel> snapshot;
  final String codebill;
  final String name;
  final String phone;
  final String phoneship;
  final String address;
  final String id;
  const Contents(
      {Key? key,
      required this.snapshot,
      required this.codebill,
      required this.name,
      required this.phone,
      required this.address,
      required this.phoneship,
      required this.id})
      : super(key: key);

  @override
  _ContentsState createState() => _ContentsState();
}

class _ContentsState extends State<Contents> {
  List<CartModel> myList = [];
  Future<List<CartModel>>? data;
  final TextEditingController yourNameS = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController phonesh = TextEditingController();
  @override
  void initState() {
    this.myList = widget.snapshot;
    super.initState();
    data = categoryList();
  }

  Future<List<CartModel>> categoryList() async {
    return await myList;
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
              return Center(child: Text("Chưa có sản phẩm nào trong giỏ"));
            }
            return SizedBox(
              height: 550,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    if (myList.length > 0)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          padding:
                              EdgeInsets.only(top: 10, right: 10, left: 10),
                          height: 650,
                          color: Colors.blue,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 550,
                                child: Container(
                                  width:
                                      Responsive.getSize(context).width * 0.95,
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
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
                                                false),
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
                                                false),
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
                                                false),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 15.0),
                                              child: Text("Phone Shipper:"),
                                            ),
                                            buildTextField(
                                                FontAwesomeIcons.userAlt,
                                                widget.phoneship == ''
                                                    ? "(+84)"
                                                    : widget.phoneship,
                                                false,
                                                false,
                                                Responsive.getSize(context)
                                                        .width *
                                                    0.95,
                                                phonesh,
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
                                                    FluroRouters.router.navigateTo(
                                                        context,
                                                        ViewbillScreen
                                                            .routeName,
                                                        routeSettings: RouteSettings(
                                                            arguments:
                                                                ViewbillArguments(
                                                                    id: widget
                                                                        .id)),
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
                                                    if (!phonesh.text.isEmpty) {
                                                      CollectionReference
                                                          likeRef =
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "User")
                                                              .doc(widget.id)
                                                              .collection(
                                                                  "bill");
                                                      likeRef
                                                          .doc(widget.codebill)
                                                          .update({
                                                        "status": 1,
                                                        "phoneship":
                                                            phonesh.text,
                                                      });
                                                      FluroRouters.router.navigateTo(
                                                          context,
                                                          ViewbillScreen
                                                              .routeName,
                                                          routeSettings: RouteSettings(
                                                              arguments:
                                                                  ViewbillArguments(
                                                                      id: widget
                                                                          .id)),
                                                          replace: true);
                                                    }
                                                  });
                                                },
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5.0))),
                                                child: widget.phoneship == ''
                                                    ? Text(
                                                        'Duyệt đơn',
                                                        style: TextStyle(
                                                            color: Colors.blue),
                                                      )
                                                    : Text(
                                                        'Update',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Item Price"),
                                  Text(getItemcart())
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                          Text(NumberFormat.currency(
                                                  locale: 'vi')
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
                                              Text(myList
                                                  .elementAt(index)
                                                  .quantity
                                                  .toString()),
                                            ],
                                          ),
                                        ),
                                        Text(NumberFormat.currency(locale: 'vi')
                                            .format(
                                                myList.elementAt(index).price *
                                                    myList
                                                        .elementAt(index)
                                                        .quantity)
                                            .toString()),
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
                ),
              ),
            );
          }),
    );
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

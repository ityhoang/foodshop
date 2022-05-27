// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:ui';

import 'package:apporder/models/bill.dart';
import 'package:apporder/models/screenarguments.dart';
import 'package:apporder/provider/product_provider.dart';
import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/routes.dart';
import 'package:apporder/screens/admin/screens/detailview/detailview_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class Contents extends StatefulWidget {
  final String id;
  const Contents({Key? key, required this.id}) : super(key: key);

  @override
  _ContentsState createState() => _ContentsState();
}

late ProductProvider productdata;

class _ContentsState extends State<Contents> {
  @override
  void initState() {
    super.initState();
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
                stream: productdata.getBillId(widget.id).asStream(),
                builder: (context, AsyncSnapshot<List<BillModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.data!.isEmpty) {
                    return Center(child: Text("Chưa có đơn hàng nào"));
                  }
                  return SizedBox(
                    height: 700,
                    child: ListView.builder(
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        FluroRouters.router
                                                            .navigateTo(
                                                                context,
                                                                DetailviewScreen
                                                                    .routeName,
                                                                routeSettings:
                                                                    RouteSettings(
                                                                  arguments:
                                                                      DetailbillvArguments(
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
                                                                    phoneship: snapshot
                                                                        .data!
                                                                        .elementAt(
                                                                            index)
                                                                        .phoneship,
                                                                    id: widget
                                                                        .id,
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
                                                child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    FluroRouters.router
                                                        .navigateTo(
                                                            context,
                                                            DetailviewScreen
                                                                .routeName,
                                                            routeSettings:
                                                                RouteSettings(
                                                              arguments:
                                                                  DetailbillvArguments(
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
                                                                phoneship: snapshot
                                                                    .data!
                                                                    .elementAt(
                                                                        index)
                                                                    .phoneship,
                                                                id: widget.id,
                                                              ),
                                                            ),
                                                            replace: true);
                                                  });
                                                },
                                                child: Text(snapshot.data!
                                                    .elementAt(index)
                                                    .phoneship),
                                              )),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

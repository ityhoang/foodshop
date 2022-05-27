// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:ui';

import 'package:apporder/models/news.dart';
import 'package:apporder/models/screenarguments.dart';
import 'package:apporder/models/user.dart';
import 'package:apporder/provider/product_provider.dart';
import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/routes.dart';
import 'package:apporder/screens/admin/screens/listnews/listnews_screen.dart';
import 'package:apporder/screens/admin/screens/viewbill/viewbill_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Contents extends StatefulWidget {
  const Contents({Key? key}) : super(key: key);

  @override
  _ContentsState createState() => _ContentsState();
}

late ProductProvider productProvider;

class _ContentsState extends State<Contents> {
  late DocumentReference<Map<String, dynamic>> likeRef;
  Map<String, dynamic> data = {};
  @override
  void initState() {
    ProductProvider initproductProvider =
        Provider.of<ProductProvider>(context, listen: false);
    getCallAllFunction(initproductProvider);
    super.initState();
  }

  void getCallAllFunction(ProductProvider initproductProvider) {
    initproductProvider.getUserList();
  }

  Future<String> getCurrentUserUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid') ?? '';
  }

  Future<int> getbill(String id) async {
    int bill = 0;
    await FirebaseFirestore.instance
        .collection("User")
        .doc(id)
        .collection("bill")
        .get()
        .then((value) => bill = value.docs.length);
    return bill;
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Responsive.isDesktop(context) ? 50.0 : 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
              height: 500,
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.mouse,
                    PointerDeviceKind.touch,
                  },
                ),
                child: StreamBuilder<List<News>>(
                  stream: productProvider.getAllNewsData().asStream(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return showproduct(snapshot.data!.elementAt(index));
                        });
                  },
                ),
              )),
        ],
      ),
    );
  }

  Widget showproduct(News e) {
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
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      e.image,
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Title: " + e.title),
                    Text("Hot: " + e.hot.toString()),
                    Text("Star: " + e.star.toString()),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 50,
                    height: 30,
                    decoration: BoxDecoration(
                        // color: Color(0xE7FFA9A9),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xCBE2E2E2),
                            offset: Offset(1, 3),
                            blurRadius: 10,
                          ),
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              FirebaseFirestore.instance
                                  .collection("news")
                                  .doc(e.id)
                                  .delete();
                              FluroRouters.router.navigateTo(
                                context,
                                ListnewsScreen.routeName,
                                replace: true,
                              );
                            });
                          },
                          child: Icon(
                            MdiIcons.delete,
                            size: 20,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {});
                          },
                          child: Icon(
                            Icons.edit,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

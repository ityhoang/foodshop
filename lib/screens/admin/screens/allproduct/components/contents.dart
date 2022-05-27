// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors


import 'package:apporder/models/product.dart';
import 'package:apporder/provider/product_provider.dart';
import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/routes.dart';
import 'package:apporder/screens/admin/screens/allproduct/allproduct_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_list_tabview/scrollable_list_tabview.dart';
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
    initproductProvider.getFoodData();
    initproductProvider.getDessertData();
    initproductProvider.getDrinkData();
    initproductProvider.getSnackData();
    initproductProvider.getVegesData();
  }

  Future<String> getCurrentUserUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid') ?? '';
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
            child: ScrollableListTabView(
              tabHeight: 48,
              bodyAnimationDuration: const Duration(milliseconds: 150),
              tabAnimationCurve: Curves.easeOut,
              tabAnimationDuration: const Duration(milliseconds: 200),
              style: GoogleFonts.abhayaLibre(),
              tabs: [
                ScrollableListTab(
                  tab: ListTab(
                      label: Text('Dessert'),
                      icon: Icon(FontAwesomeIcons.iceCream),
                      showIconOnList: true),
                  body: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Center(
                        child: Wrap(
                          children: productProvider.getdessertList
                              .map(
                                (e) => showproduct(e, "dessert"),
                              )
                              .toList(),
                        ),
                      )
                    ],
                  ),
                ),
                ScrollableListTab(
                  tab: ListTab(
                    label: Text('Snack'),
                    icon: Icon(FontAwesomeIcons.cookie),
                    showIconOnList: true,
                  ),
                  body: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Center(
                        child: Wrap(
                          children: productProvider.getsnackList
                              .map(
                                (e) => showproduct(e, "snack"),
                              )
                              .toList(),
                        ),
                      )
                    ],
                  ),
                ),
                ScrollableListTab(
                  tab: ListTab(
                    label: Text('Food'),
                    icon: Icon(FontAwesomeIcons.utensils),
                    showIconOnList: true,
                  ),
                  body: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Center(
                        child: Wrap(
                          children: productProvider.getfoodList
                              .map(
                                (e) => showproduct(e, "food"),
                              )
                              .toList(),
                        ),
                      )
                    ],
                  ),
                ),
                ScrollableListTab(
                  tab: ListTab(
                    label: Text('Veges'),
                    icon: Icon(FontAwesomeIcons.carrot),
                    showIconOnList: true,
                  ),
                  body: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Center(
                        child: Wrap(
                          children: productProvider.getvegesList
                              .map(
                                (e) => showproduct(e, "veges"),
                              )
                              .toList(),
                        ),
                      )
                    ],
                  ),
                ),
                ScrollableListTab(
                  tab: ListTab(
                      label: Text('Drink'),
                      icon: Icon(FontAwesomeIcons.wineGlass),
                      showIconOnList: true),
                  body: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Center(
                        child: Wrap(
                          children: productProvider.getdrinkList
                              .map(
                                (e) => showproduct(e, "drink"),
                              )
                              .toList(),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget showproduct(Product e, String name) {
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
                      e.image[0],
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
                    Text(e.name),
                    Text(e.like == 1 ? "show" : "hide"),
                    Text(NumberFormat.currency(locale: 'vi')
                        .format(e.price)
                        .toString()),
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
                              CollectionReference likeRef = FirebaseFirestore
                                  .instance
                                  .collection("categoryicon")
                                  .doc("A8JoMU51G5b0O2bdLqTf")
                                  .collection(name);
                              likeRef
                                  .doc(e.id)
                                  .collection('listImage')
                                  .get()
                                  .then((snapshot) {
                                for (DocumentSnapshot ds in snapshot.docs) {
                                  ds.reference.delete();
                                }
                              });
                              likeRef.doc(e.id).delete();
                              FluroRouters.router.navigateTo(
                                context,
                                AllProductScreen.routeName,
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

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, curly_braces_in_flow_control_structures, unused_field, avoid_function_literals_in_foreach_calls, prefer_is_empty, avoid_unnecessary_containers

import 'dart:convert';
import 'dart:ui';

import 'package:apporder/models/cart.dart';
import 'package:apporder/models/news.dart';
import 'package:apporder/models/product.dart';
import 'package:apporder/models/screenarguments.dart';
import 'package:apporder/provider/product_provider.dart';
import 'package:apporder/provider/cart_provider.dart';
import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/routes.dart';
import 'package:apporder/screens/detailnews/detailnews_screen.dart';
import 'package:apporder/screens/login_signup/loginsignup_page.dart';
import 'package:apporder/screens/product/product_screend.dart';
import 'package:apporder/screens/products/products_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Contents extends StatefulWidget {
  final News? snapshot;
  const Contents({Key? key, this.snapshot}) : super(key: key);

  @override
  _ContentsState createState() => _ContentsState();
}

late ProductProvider productProvider;
late CartProvider testdata;

class _ContentsState extends State<Contents> {
  Map<String, dynamic> data1 = {};
  List<int> check = [-1];
  List _isSelected = [];
  int count = 1;
  final CarouselController _controller = CarouselController();
  DocumentReference<Map<String, dynamic>>? newsRef;
  int _current = 0;
  String _uid = '';
  late List<String> images = [];
  late SharedPreferences prefs;
  Future settingSharepre() async {
    return await SharedPreferences.getInstance();
  }

  Future<String> getList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('cart') ?? '';
  }

  List<CartModel> ty = [];
  bool checkcart = true;
  Future<void> setcardShare(Product product) async {
    getList().then((value) => {
          if (value.isNotEmpty)
            {
              ty = (json.decode(value) as List<dynamic>)
                  .map<CartModel>((item) => CartModel.fromJson(item))
                  .toList(),
              if (ty.isNotEmpty)
                {
                  ty.forEach((element) {
                    if (element.id == product.id) {
                      element.quantity += count;
                      element.size = size;
                      checkcart = false;
                    }
                  }),
                  if (checkcart)
                    {
                      ty.add(CartModel(
                        image: product.image.elementAt(0),
                        id: product.id,
                        size: size,
                        name: product.name,
                        price: product.price,
                        quantity: count,
                      ))
                    }
                }
              else
                {
                  ty.add(CartModel(
                    image: product.image.elementAt(0),
                    id: product.id,
                    size: size,
                    name: product.name,
                    price: product.price,
                    quantity: count,
                  ))
                },
              if (ty.isNotEmpty)
                {
                  settingSharepre().then(
                    (value) => {
                      prefs = value,
                      prefs.setString('cart', CartModel.encode(ty)),
                    },
                  )
                }
            }
          else
            {
              ty.add(CartModel(
                image: product.image.elementAt(0),
                id: product.id,
                size: size,
                name: product.name,
                price: product.price,
                quantity: count,
              )),
              if (ty.isNotEmpty)
                {
                  settingSharepre().then(
                    (value) => {
                      prefs = value,
                      prefs.setString('cart', CartModel.encode(ty)),
                    },
                  )
                }
            }
        });
  }

  @override
  void initState() {
    ProductProvider initproductProvider =
        Provider.of<ProductProvider>(context, listen: false);
    getCallAllFunction(initproductProvider);
    getCurrentUserUid().then(updateUid);
    getCurrentUserUid().then((value) => {
          if (value.isNotEmpty || FirebaseAuth.instance.currentUser != null)
            {
              newsRef = FirebaseFirestore.instance
                  .collection("User")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("news")
                  .doc("listnews")
            }
        });

    super.initState();
    getCurrentUserUid().then((value) => {
          if (value.isNotEmpty || FirebaseAuth.instance.currentUser != null)
            {
              newsRef!.get().then((value) => {
                    if (value.data()!.isNotEmpty)
                      data1 = value.data() as Map<String, dynamic>
                  })
            }
        });
  }

  void updateUid(String uid) {
    setState(() {
      this._uid = uid;
    });
  }

  Future<String> getCurrentUserUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid') ?? '';
  }

  void getCallAllFunction(ProductProvider initproductProvider) {
    initproductProvider.getFoodData();
    initproductProvider.getDessertData();
    initproductProvider.getDrinkData();
    initproductProvider.getSnackData();
    initproductProvider.getVegesData();
    initproductProvider.getLikeData();
  }

  int seletedIndex = 0;

  List<Map<String, String>> menuData = [
    {"text": "Food", "icon": "images/key.png","name": "keyboard"},
    {"text": "Drink", "icon": "images/speaker.png","name": "Speaker"},
    {"text": "Veges", "icon": "images/headphones.png","name": "Earphone"},
    {"text": "Dessert", "icon": "images/mouse.png","name": "Mouse"},
    {"text": "Snack", "icon": "images/phone.png","name": "Phone"},
  ];

  List<bool> sized = [true, false, false, false];
  int sizeIndex = 0;
  String size = 'S';
  void getSize() {
    if (sizeIndex == 0) {
      setState(() {
        size = "S";
      });
    } else if (sizeIndex == 1) {
      setState(() {
        size = "M";
      });
    } else if (sizeIndex == 2) {
      setState(() {
        size = "L";
      });
    } else if (sizeIndex == 3) {
      setState(() {
        size = "XL";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    testdata = Provider.of<CartProvider>(context, listen: false);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Responsive.isDesktop(context) ? 140.0 : 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Responsive.isDesktop(context)
              ? Container()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Explore Catagories",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22.0,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                FluroRouters.router.navigateTo(
                                    context, ProductsScreen.routeName,
                                    replace: true);
                              },
                              child: Text(
                                "See All",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: menuData.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => {
                                setState(
                                  () => {
                                    seletedIndex = index,
                                    if (menuData[index]['text'] == "Food")
                                      FluroRouters.router.navigateTo(
                                          context, ProductScreen.routeName,
                                          routeSettings: RouteSettings(
                                              arguments: ScreenArguments(
                                                  name: "Food",
                                                  snapshot: productProvider
                                                      .getfoodList)),
                                          replace: true),
                                    if (menuData[index]['text'] == "Drink")
                                      FluroRouters.router.navigateTo(
                                          context, ProductScreen.routeName,
                                          routeSettings: RouteSettings(
                                              arguments: ScreenArguments(
                                                  name: "Drink",
                                                  snapshot: productProvider
                                                      .getdrinkList)),
                                          replace: true),
                                    if (menuData[index]['text'] == "Veges")
                                      FluroRouters.router.navigateTo(
                                          context, ProductScreen.routeName,
                                          routeSettings: RouteSettings(
                                              arguments: ScreenArguments(
                                                  name: "Veges",
                                                  snapshot: productProvider
                                                      .getvegesList)),
                                          replace: true),
                                    if (menuData[index]['text'] == "Snack")
                                      FluroRouters.router.navigateTo(
                                          context, ProductScreen.routeName,
                                          routeSettings: RouteSettings(
                                              arguments: ScreenArguments(
                                                  name: "Snack",
                                                  snapshot: productProvider
                                                      .getsnackList)),
                                          replace: true),
                                    if (menuData[index]['text'] == "Dessert")
                                      FluroRouters.router.navigateTo(
                                          context, ProductScreen.routeName,
                                          routeSettings: RouteSettings(
                                              arguments: ScreenArguments(
                                                  name: "Dessert",
                                                  snapshot: productProvider
                                                      .getdessertList)),
                                          replace: true),
                                  },
                                ),
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 15.0),
                                child: SizedBox(
                                  width: 80,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: listMenu(
                                        Responsive.getSize(context),
                                        menuData[index]['icon'],
                                        seletedIndex == index,
                                        menuData[index]['name']),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
          Container(
            height: Responsive.isDesktop(context)
                ? 1250
                : Responsive.isTablet(context)
                    ? 1250
                    : 1350,
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: [
                Responsive.isDesktop(context)
                    ? Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              width: Responsive.getSize(context).width,
                              height: 50,
                              color: Colors.black38,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Menu"),
                                  InkWell(
                                      onTap: () {
                                        FluroRouters.router.navigateTo(
                                          context,
                                          ProductsScreen.routeName,
                                          replace: true,
                                        );
                                      },
                                      child: Icon(MdiIcons.menu))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 406,
                              child: ListView.builder(
                                itemCount: menuData.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () => {
                                      setState(
                                        () => {
                                          seletedIndex = index,
                                          if (menuData[index]['text'] == "Food")
                                            FluroRouters.router.navigateTo(
                                                context,
                                                ProductScreen.routeName,
                                                routeSettings: RouteSettings(
                                                    arguments: ScreenArguments(
                                                        name: "Food",
                                                        snapshot:
                                                            productProvider
                                                                .getfoodList)),
                                                replace: true),
                                          if (menuData[index]['text'] ==
                                              "Drink")
                                            FluroRouters.router.navigateTo(
                                                context,
                                                ProductScreen.routeName,
                                                routeSettings: RouteSettings(
                                                    arguments: ScreenArguments(
                                                        name: "Drink",
                                                        snapshot:
                                                            productProvider
                                                                .getdrinkList)),
                                                replace: true),
                                          if (menuData[index]['text'] ==
                                              "Veges")
                                            FluroRouters.router.navigateTo(
                                                context,
                                                ProductScreen.routeName,
                                                routeSettings: RouteSettings(
                                                    arguments: ScreenArguments(
                                                        name: "Veges",
                                                        snapshot:
                                                            productProvider
                                                                .getvegesList)),
                                                replace: true),
                                          if (menuData[index]['text'] ==
                                              "Snack")
                                            FluroRouters.router.navigateTo(
                                                context,
                                                ProductScreen.routeName,
                                                routeSettings: RouteSettings(
                                                    arguments: ScreenArguments(
                                                        name: "Snack",
                                                        snapshot:
                                                            productProvider
                                                                .getsnackList)),
                                                replace: true),
                                          if (menuData[index]['text'] ==
                                              "Dessert")
                                            FluroRouters.router.navigateTo(
                                                context,
                                                ProductScreen.routeName,
                                                routeSettings: RouteSettings(
                                                    arguments: ScreenArguments(
                                                        name: "Dessert",
                                                        snapshot: productProvider
                                                            .getdessertList)),
                                                replace: true),
                                        },
                                      ),
                                    },
                                    onHover: (ischeck) {
                                      setState(() {
                                        if (ischeck) {
                                          check.clear();
                                          check.add(index);
                                        } else {
                                          check.remove(index);
                                          check.add(-1);
                                        }
                                      });
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: Container(
                                        height: 70,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: check.elementAt(0) ==
                                                          index
                                                      ? Colors.white
                                                      : Color(0xDAC2C2C2f),
                                                  offset: Offset(4.0, 4.0),
                                                  blurRadius: 5.0,
                                                  spreadRadius: 1.0),
                                              BoxShadow(
                                                  color: Colors.white,
                                                  offset: Offset(-4.0, -4.0),
                                                  blurRadius: 5.0,
                                                  spreadRadius: 1.0),
                                            ]),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: Image.asset(
                                                  menuData[index]['icon']
                                                      .toString(),
                                                  fit: BoxFit.cover,
                                                  width: 30,
                                                  height: 30,
                                                ),
                                              ),
                                              Spacer(),
                                              Text(menuData[index]['name']
                                                  .toString()),
                                              Spacer(
                                                flex: 8,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                Expanded(
                  flex: 7,
                  child: Padding(
                    padding: Responsive.isDesktop(context)
                        ? EdgeInsets.only(left: 10.0)
                        : EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 200,
                            width: 500,
                            padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                            child: CachedNetworkImage(
                              imageUrl: widget.snapshot!.image,
                              imageBuilder: (context, imageProvider) =>
                                  SizedBox(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => Center(
                                  child: SizedBox(
                                child: CircularProgressIndicator(),
                                width: 200,
                                height: 200,
                              )),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            )),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text(widget.snapshot!.title.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              )),
                        ),
                        SizedBox(
                          height: 350,
                          child: SingleChildScrollView(
                            child: Text(
                              widget.snapshot!.contents,
                              textScaleFactor: 1.3,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        StreamBuilder<QuerySnapshot<dynamic>>(
                            stream: FirebaseFirestore.instance
                                .collection("chanel")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return Container(
                                child: Image.network(
                                  snapshot.data!.docs.elementAt(0).get("image"),
                                  fit: BoxFit.cover,
                                  width: Responsive.getSize(context).width,
                                  height: 200,
                                ),
                              );
                            }),
                        SizedBox(height: 20),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Tin Tức Sản Phẩm",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  )),
                              Divider(
                                thickness: 2,
                                color: Color(0xFF8A8A8A),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 250,
                          child: ScrollConfiguration(
                            behavior: ScrollConfiguration.of(context).copyWith(
                              dragDevices: {
                                PointerDeviceKind.mouse,
                                PointerDeviceKind.touch,
                              },
                            ),
                            child: StreamBuilder<List<News>>(
                                stream:
                                    productProvider.getAllNewsData().asStream(),
                                builder: (context,
                                    AsyncSnapshot<List<News>> snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (data1.isEmpty) {
                                    snapshot.data!.forEach((element) {
                                      data1[element.id] = element.star;
                                    });
                                  } else {
                                    snapshot.data!.forEach((element) {
                                      if (!data1.containsKey(element.id)) {
                                        data1[element.id] = element.star;
                                      }
                                    });
                                  }
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Container(
                                          width: 200,
                                          height: 250,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0x3D7A7A7A),
                                                  width: 2)),
                                          child: Stack(
                                            children: [
                                              Center(
                                                child: CachedNetworkImage(
                                                  imageUrl: snapshot.data!
                                                      .elementAt(index)
                                                      .image,
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Column(
                                                    children: [
                                                      Center(
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              FluroRouters
                                                                  .router
                                                                  .navigateTo(
                                                                context,
                                                                DetailnewsScreen
                                                                    .routeName,
                                                                routeSettings: RouteSettings(
                                                                    arguments: DetailnewsArguments(
                                                                        snapshot: snapshot
                                                                            .data!
                                                                            .elementAt(index))),
                                                                replace: true,
                                                              );
                                                            });
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image:
                                                                    imageProvider,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                            height: 140,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 10,
                                                                horizontal: 2),
                                                        height: 80,
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              snapshot.data!
                                                                  .elementAt(
                                                                      index)
                                                                  .contents,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            Spacer(),
                                                            buildRate(
                                                                id: snapshot
                                                                    .data!
                                                                    .elementAt(
                                                                        index)
                                                                    .id),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  placeholder: (context, url) =>
                                                      CircularProgressIndicator(),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                              ),
                                              snapshot.data!
                                                          .elementAt(index)
                                                          .hot ==
                                                      1
                                                  ? Positioned(
                                                      top: 0,
                                                      left: 0,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Container(
                                                          width: 45,
                                                          height: 25,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: Colors.white,
                                                          ),
                                                          child: Center(
                                                              child:
                                                                  Text("Hot")),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }),
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> listMenu(Size _size, String? icon, bool ischeck, String? label) {
    return <Widget>[
      Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: ischeck ? Color(0xFFfc6a57) : Color(0xFFffe8e5),
        ),
        child: Center(
          child: Image.asset(
            "./${icon!}",
            // icon!,
            height: 50,
            width: 50,
            color: ischeck ? Colors.white : Colors.black87,
          ),
        ),
      ),
      Text(
        label!,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
          color: ischeck ? Color(0xFFfc6a57) : Colors.black87,
        ),
      ),
    ];
  }

  Widget buildRate({required String id}) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(
            5,
            (index) => GestureDetector(
              onTap: () {
                if (FirebaseAuth.instance.currentUser != null) {
                  setState(() {
                    newsRef!.update({id: (index + 1)});
                    data1[id] = (index + 1);
                  });
                } else {
                  FluroRouters.router.navigateTo(
                      context, LoginSignupScreen.routeName,
                      replace: true);
                }
              },
              child: ((index + 1) <= data1[id])
                  ? Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 13,
                    )
                  : Icon(
                      Icons.star,
                      color: Colors.grey,
                      size: 13,
                    ),
            ),
          ),
        ],
      );
}

// https://tamnguyen.com.vn/thiet-ke-website-do-an-vie-food.html

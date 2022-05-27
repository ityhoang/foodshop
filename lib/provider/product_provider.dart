// ignore_for_file: avoid_function_literals_in_foreach_calls, curly_braces_in_flow_control_structures, unnecessary_string_interpolations, empty_catches, avoid_print, unused_field

import 'dart:async';

import 'package:apporder/models/bill.dart';
import 'package:apporder/models/cart.dart';
import 'package:apporder/models/news.dart';
import 'package:apporder/models/product.dart';
import 'package:apporder/models/sliders.dart';
import 'package:apporder/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductProvider with ChangeNotifier {
  late Product foodData;

  List<Product> food = [];

  late Product dessertData;
  List<Product> dessert = [];

  late Product drinkData;
  List<Product> drink = [];

  late Product snackData;
  List<Product> snack = [];

  late Product vegesData;
  List<Product> veges = [];

  late Product allData;
  List<Product> alldata = [];

  late News allnewsData;
  List<News> allnewsdata = [];

  late Product likeData;
  List<Product> like = [];

  late Product loveData;
  List<Product> love = [];

  late String idloveData;
  List<String> idlove = [];

  late Sliders slidersData;
  List<Sliders> sliders = [];

  late CartModel checkOutModel;
  late CartModel cartnew;
  List<CartModel> checkOutModelList = [];

  late UserModel user;
  List<UserModel> users = [];
  String _uid = "";

  late BillModel billnew;

  String _gender = "";
  String get gender => _gender;

  Future<List<Product>> getFoodList() async {
    List<Product> newList = [];
    late Product listData;
    CollectionReference data = FirebaseFirestore.instance
        .collection("categoryicon")
        .doc("A8JoMU51G5b0O2bdLqTf")
        .collection("food");
    QuerySnapshot shirtSnapShot = await data.get();
    shirtSnapShot.docs.forEach(
      (element) {
        List<String> img = [];
        img.add(element.get("image"));
        Future<QuerySnapshot> images = getListImage(data: data, id: element.id);

        images.then((value) => value.docs.forEach((element) {
              if (element.get("image").toString().isNotEmpty)
                img.add(element.get("image"));
            }));
        listData = Product(
          image: img,
          name: element.get("name"),
          price: element.get("price"),
          numlike: element.get("number_like"),
          like: element.get("like"),
          content: element.get("content"),
          id: element.id,
          catoname: "food",
        );
        newList.add(listData);
      },
    );
    return newList;
  }

  Future<void> getFoodData() async {
    List<Product> newList = [];

    CollectionReference data = FirebaseFirestore.instance
        .collection("categoryicon")
        .doc("A8JoMU51G5b0O2bdLqTf")
        .collection("food");
    QuerySnapshot shirtSnapShot = await data.get();
    shirtSnapShot.docs.forEach(
      (element) {
        List<String> img = [];
        img.add(element.get("image"));
        Future<QuerySnapshot> images = getListImage(data: data, id: element.id);

        images.then((value) => value.docs.forEach((element) {
              if (element.get("image").toString().isNotEmpty)
                img.add(element.get("image"));
            }));
        foodData = Product(
          image: img,
          name: element.get("name"),
          price: element.get("price"),
          numlike: element.get("number_like"),
          like: element.get("like"),
          content: element.get("content"),
          id: element.id,
          catoname: "food",
        );
        newList.add(foodData);
      },
    );
    food = newList;
    notifyListeners();
  }

  List<Product> get getfoodList {
    return food;
  }

  Future<List<Product>> getDessertList() async {
    List<Product> newList = [];
    late Product listData;
    CollectionReference data = FirebaseFirestore.instance
        .collection("categoryicon")
        .doc("A8JoMU51G5b0O2bdLqTf")
        .collection("dessert");
    QuerySnapshot shirtSnapShot = await data.get();
    shirtSnapShot.docs.forEach(
      (element) {
        List<String> img = [];
        img.add(element.get("image"));
        Future<QuerySnapshot> images = getListImage(data: data, id: element.id);

        images.then((value) => value.docs.forEach((element) {
              if (element.get("image").toString().isNotEmpty)
                img.add(element.get("image"));
            }));
        listData = Product(
          image: img,
          name: element.get("name"),
          price: element.get("price"),
          numlike: element.get("number_like"),
          like: element.get("like"),
          content: element.get("content"),
          id: element.id,
          catoname: "dessert",
        );
        newList.add(listData);
      },
    );
    return newList;
  }

  Future<void> getDessertData() async {
    List<Product> newList = [];
    CollectionReference data = FirebaseFirestore.instance
        .collection("categoryicon")
        .doc("A8JoMU51G5b0O2bdLqTf")
        .collection("dessert");
    QuerySnapshot shirtSnapShot = await data.get();
    shirtSnapShot.docs.forEach(
      (element) {
        List<String> img = [];
        img.add(element.get("image"));
        Future<QuerySnapshot> images = getListImage(data: data, id: element.id);

        images.then((value) => value.docs.forEach((element) {
              if (element.get("image").toString().isNotEmpty)
                img.add(element.get("image"));
            }));
        dessertData = Product(
          image: img,
          name: element.get("name"),
          price: element.get("price"),
          numlike: element.get("number_like"),
          like: element.get("like"),
          content: element.get("content"),
          id: element.id,
          catoname: "dessert",
        );
        newList.add(dessertData);
      },
    );
    dessert = newList;
    notifyListeners();
  }

  List<Product> get getdessertList {
    return dessert;
  }

  Future<List<Product>> getDrinkList() async {
    List<Product> newList = [];
    late Product listData;
    CollectionReference data = FirebaseFirestore.instance
        .collection("categoryicon")
        .doc("A8JoMU51G5b0O2bdLqTf")
        .collection("drink");
    QuerySnapshot shirtSnapShot = await data.get();
    shirtSnapShot.docs.forEach(
      (element) {
        List<String> img = [];
        img.add(element.get("image"));
        Future<QuerySnapshot> images = getListImage(data: data, id: element.id);

        images.then((value) => value.docs.forEach((element) {
              if (element.get("image").toString().isNotEmpty)
                img.add(element.get("image"));
            }));
        listData = Product(
          image: img,
          name: element.get("name"),
          price: element.get("price"),
          numlike: element.get("number_like"),
          like: element.get("like"),
          content: element.get("content"),
          id: element.id,
          catoname: "drink",
        );
        newList.add(listData);
      },
    );
    return newList;
  }

  Future<void> getDrinkData() async {
    List<Product> newList = [];

    CollectionReference data = FirebaseFirestore.instance
        .collection("categoryicon")
        .doc("A8JoMU51G5b0O2bdLqTf")
        .collection("drink");
    QuerySnapshot shirtSnapShot = await data.get();
    shirtSnapShot.docs.forEach(
      (element) {
        List<String> img = [];
        img.add(element.get("image"));
        Future<QuerySnapshot> images = getListImage(data: data, id: element.id);

        images.then((value) => value.docs.forEach((element) {
              if (element.get("image").toString().isNotEmpty)
                img.add(element.get("image"));
            }));
        drinkData = Product(
          image: img,
          name: element.get("name"),
          price: element.get("price"),
          numlike: element.get("number_like"),
          like: element.get("like"),
          content: element.get("content"),
          id: element.id,
          catoname: "drink",
        );
        newList.add(drinkData);
      },
    );
    drink = newList;
    notifyListeners();
  }

  List<Product> get getdrinkList {
    return drink;
  }

  Future<List<Product>> getSnackList() async {
    List<Product> newList = [];
    late Product listData;
    CollectionReference data = FirebaseFirestore.instance
        .collection("categoryicon")
        .doc("A8JoMU51G5b0O2bdLqTf")
        .collection("snack");
    QuerySnapshot shirtSnapShot = await data.get();

    shirtSnapShot.docs.forEach(
      (element) {
        List<String> img = [];
        img.add(element.get("image"));

        Future<QuerySnapshot> images = getListImage(data: data, id: element.id);

        images.then((value) => value.docs.forEach((element) {
              if (element.get("image").toString().isNotEmpty)
                img.add(element.get("image"));
            }));
        listData = Product(
          image: img,
          name: element.get("name"),
          price: element.get("price"),
          numlike: element.get("number_like"),
          like: element.get("like"),
          content: element.get("content"),
          id: element.id,
          catoname: "snack",
        );
        newList.add(listData);
      },
    );
    return newList;
  }

  Future<void> getSnackData() async {
    List<Product> newList = [];
    CollectionReference data = FirebaseFirestore.instance
        .collection("categoryicon")
        .doc("A8JoMU51G5b0O2bdLqTf")
        .collection("snack");
    QuerySnapshot shirtSnapShot = await data.get();

    shirtSnapShot.docs.forEach(
      (element) {
        List<String> img = [];
        img.add(element.get("image"));

        Future<QuerySnapshot> images = getListImage(data: data, id: element.id);

        images.then((value) => value.docs.forEach((element) {
              if (element.get("image").toString().isNotEmpty)
                img.add(element.get("image"));
            }));
        snackData = Product(
          image: img,
          name: element.get("name"),
          price: element.get("price"),
          numlike: element.get("number_like"),
          like: element.get("like"),
          content: element.get("content"),
          id: element.id,
          catoname: "snack",
        );
        newList.add(snackData);
      },
    );
    snack = newList;
    notifyListeners();
  }

  List<Product> get getsnackList {
    return snack;
  }

  Future<List<Product>> getVegesList() async {
    List<Product> newList = [];
    late Product listData;
    CollectionReference data = FirebaseFirestore.instance
        .collection("categoryicon")
        .doc("A8JoMU51G5b0O2bdLqTf")
        .collection("veges");
    QuerySnapshot shirtSnapShot = await data.get();
    shirtSnapShot.docs.forEach(
      (element) {
        List<String> img = [];
        img.add(element.get("image"));

        Future<QuerySnapshot> images = getListImage(data: data, id: element.id);

        images.then((value) => value.docs.forEach((element) {
              if (element.get("image").toString().isNotEmpty)
                img.add(element.get("image"));
            }));
        listData = Product(
          image: img,
          name: element.get("name"),
          price: element.get("price"),
          numlike: element.get("number_like"),
          like: element.get("like"),
          content: element.get("content"),
          id: element.id,
          catoname: "veges",
        );
        newList.add(listData);
      },
    );
    return newList;
  }

  Future<void> getVegesData() async {
    List<Product> newList = [];
    CollectionReference data = FirebaseFirestore.instance
        .collection("categoryicon")
        .doc("A8JoMU51G5b0O2bdLqTf")
        .collection("veges");
    QuerySnapshot shirtSnapShot = await data.get();
    shirtSnapShot.docs.forEach(
      (element) {
        List<String> img = [];
        img.add(element.get("image"));

        Future<QuerySnapshot> images = getListImage(data: data, id: element.id);

        images.then((value) => value.docs.forEach((element) {
              if (element.get("image").toString().isNotEmpty)
                img.add(element.get("image"));
            }));
        vegesData = Product(
          image: img,
          name: element.get("name"),
          price: element.get("price"),
          numlike: element.get("number_like"),
          like: element.get("like"),
          content: element.get("content"),
          id: element.id,
          catoname: "veges",
        );
        newList.add(vegesData);
      },
    );
    veges = newList;
    notifyListeners();
  }

  List<Product> get getvegesList {
    return veges;
  }

  Future<List<Product>> getAllData() async {
    List<Product> newList = [];
    List<String> nameList = ["veges", "snack", "food", "drink", "dessert"];
    for (var name in nameList) {
      CollectionReference data = FirebaseFirestore.instance
          .collection("categoryicon")
          .doc("A8JoMU51G5b0O2bdLqTf")
          .collection("$name");
      QuerySnapshot shirtSnapShot = await data.get();
      shirtSnapShot.docs.forEach(
        (element) {
          if (element.get('like').toString() == "1") {
            List<String> img = [];
            img.add(element.get("image"));

            Future<QuerySnapshot> images =
                getListImage(data: data, id: element.id);

            images.then((value) => value.docs.forEach((element) {
                  if (element.get("image").toString().isNotEmpty)
                    img.add(element.get("image"));
                }));
            allData = Product(
              image: img,
              name: element.get("name"),
              price: element.get("price"),
              numlike: element.get("number_like"),
              like: element.get("like"),
              content: element.get("content"),
              id: element.id,
              catoname: name,
            );
            newList.add(allData);
          }
        },
      );
    }
    alldata = newList;
    return newList;
  }

  Future<List<Product>> getLikeData() async {
    List<Product> newList = [];
    List<String> nameList = ["veges", "snack", "food", "drink", "dessert"];
    for (var name in nameList) {
      CollectionReference data = FirebaseFirestore.instance
          .collection("categoryicon")
          .doc("A8JoMU51G5b0O2bdLqTf")
          .collection("$name");
      QuerySnapshot shirtSnapShot = await data.get();
      shirtSnapShot.docs.forEach(
        (element) {
          if (element.get('like').toString() == "1") {
            List<String> img = [];
            img.add(element.get("image"));

            Future<QuerySnapshot> images =
                getListImage(data: data, id: element.id);

            images.then((value) => value.docs.forEach((element) {
                  if (element.get("image").toString().isNotEmpty) {
                    img.add(element.get("image"));
                  }
                }));
            likeData = Product(
              image: img,
              name: element.get("name"),
              price: element.get("price"),
              numlike: element.get("number_like"),
              like: element.get("like"),
              content: element.get("content"),
              id: element.id,
              catoname: name,
            );
            newList.add(likeData);
          }
        },
      );
    }
    like = newList;
    return newList;
  }

  List<Product> get getlikeList {
    return like;
  }

  Future<QuerySnapshot> getListImage(
      {required CollectionReference data, required String id}) {
    return data.doc(id).collection("listImage").get();
  }

  void checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _uid = prefs.getString('uid').toString();
    notifyListeners();
  }

  void getCheckOutData({
    required int quantity,
    required num price,
    required String name,
    required String size,
    required String image,
    required String id,
  }) {
    bool check = true;
    if (checkOutModelList.isNotEmpty) {
      checkOutModelList.forEach((element) {
        if (element.id == id) {
          element.quantity += quantity;
          if (FirebaseAuth.instance.currentUser != null) {
            CollectionReference likeRef = FirebaseFirestore.instance
                .collection("User")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("cart");
            likeRef.doc(element.id).set(CartModel.toMap(element));
          }
          check = false;
        }
      });
      if (check) {
        checkOutModel = CartModel(
          size: size,
          price: price,
          name: name,
          image: image,
          quantity: quantity,
          id: id,
        );
        if (FirebaseAuth.instance.currentUser != null) {
          CollectionReference likeRef = FirebaseFirestore.instance
              .collection("User")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("cart");
          likeRef.doc(checkOutModel.id).set(CartModel.toMap(checkOutModel));
        }
        checkOutModelList.add(checkOutModel);
      }
    } else {
      checkOutModel = CartModel(
        size: size,
        price: price,
        name: name,
        image: image,
        quantity: quantity,
        id: id,
      );
      if (FirebaseAuth.instance.currentUser != null) {
        CollectionReference likeRef = FirebaseFirestore.instance
            .collection("User")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("cart");
        likeRef.doc(checkOutModel.id).set(CartModel.toMap(checkOutModel));
      }
      checkOutModelList.add(checkOutModel);
    }
  }

  List<CartModel> get getCheckOutModelList {
    return List.from(checkOutModelList);
  }

  Future<void> getidloveData({required String id}) async {
    List<String> newList = [];
    try {
      CollectionReference data = FirebaseFirestore.instance
          .collection("User")
          .doc("$id")
          .collection("like");
      QuerySnapshot shirtSnapShot = await data.get();
      shirtSnapShot.docs.forEach((element) {
        idloveData = element.get("idproduct");
        newList.add(idloveData);
      });
    } catch (e) {}
    idlove = newList;
    notifyListeners();
  }

  List<String> get getidloveList {
    return idlove;
  }

  Future<void> getListLove({required List<String> listId}) async {
    List<Product> newList = [];
    List<String> nameList = ["veges", "snack", "food", "drink", "dessert"];
    for (var name in nameList) {
      CollectionReference data = FirebaseFirestore.instance
          .collection("categoryicon")
          .doc("A8JoMU51G5b0O2bdLqTf")
          .collection("$name");
      QuerySnapshot shirtSnapShot = await data.get();
      shirtSnapShot.docs.forEach(
        (element) {
          listId.forEach((elements) {
            if (element.id == elements) {
              List<String> img = [];
              img.add(element.get("image"));

              Future<QuerySnapshot> images =
                  getListImage(data: data, id: element.id);

              images.then((value) => value.docs.forEach((element) {
                    if (element.get("image").toString().isNotEmpty)
                      img.add(element.get("image"));
                  }));
              loveData = Product(
                image: img,
                name: element.get("name"),
                price: element.get("price"),
                numlike: element.get("number_like"),
                like: element.get("like"),
                content: element.get("content"),
                id: element.id,
                catoname: name,
              );
              newList.add(loveData);
            }
          });
        },
      );
    }
    love = newList;
    notifyListeners();
  }

  List<Product> get getloveList {
    return love;
  }

  Future<String> getName({required String id}) async {
    String addname = '';
    List<String> nameList = ["veges", "snack", "food", "drink", "dessert"];
    for (var name in nameList) {
      CollectionReference data = FirebaseFirestore.instance
          .collection("categoryicon")
          .doc("A8JoMU51G5b0O2bdLqTf")
          .collection("$name");
      QuerySnapshot shirtSnapShot = await data.get();
      shirtSnapShot.docs.forEach((element) {
        if (element.id == id) {
          addname = name;
        }
      });
    }
    return addname;
  }

  Future<void> addLove({required String id, required String idproduct}) async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc("$id")
        .collection("like")
        .doc("$idproduct")
        .set({
          'idproduct': idproduct,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> deleteLove(
      {required String id, required String idproduct}) async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc("$id")
        .collection("like")
        .doc("$idproduct")
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<List<Product>> getListLoves({required List<String> listId}) async {
    List<Product> newList = [];
    List<String> nameList = ["veges", "snack", "food", "drink", "dessert"];

    for (var name in nameList) {
      CollectionReference data = FirebaseFirestore.instance
          .collection("categoryicon")
          .doc("A8JoMU51G5b0O2bdLqTf")
          .collection("$name");
      QuerySnapshot shirtSnapShot = await data.get();
      shirtSnapShot.docs.forEach(
        (element) {
          listId.forEach((elements) {
            if (element.id == elements) {
              List<String> img = [];
              img.add(element.get("image"));
              Future<QuerySnapshot> images =
                  getListImage(data: data, id: element.id);

              images.then((value) => value.docs.forEach((element) {
                    if (element.get("image").toString().isNotEmpty)
                      img.add(element.get("image"));
                  }));
              loveData = Product(
                image: img,
                name: element.get("name"),
                price: element.get("price"),
                numlike: element.get("number_like"),
                like: element.get("like"),
                content: element.get("content"),
                id: element.id,
                catoname: name,
              );
              newList.add(loveData);
            }
          });
        },
      );
    }

    return newList;
  }

  Future<List<News>> getAllNewsData() async {
    List<News> newList = [];
    CollectionReference data = FirebaseFirestore.instance.collection("news");
    QuerySnapshot shirtSnapShot = await data.get();
    shirtSnapShot.docs.forEach(
      (element) {
        allnewsData = News(
          contents: element.get("content"),
          image: element.get("image"),
          star: element.get("star"),
          hlihgts: element.get("highlights"),
          hot: element.get("hot"),
          id: element.id,
          title: element.get("title"),
        );
        newList.add(allnewsData);
      },
    );
    allnewsdata = newList;
    return newList;
  }

  Future<List<Sliders>> getSliderData() async {
    List<Sliders> newList = [];
    CollectionReference data =
        FirebaseFirestore.instance.collection("imageslider");
    QuerySnapshot shirtSnapShot = await data.get();
    shirtSnapShot.docs.forEach(
      (element) {
        slidersData = Sliders(
          image: element.get("image"),
          name: element.get("name"),
          id: element.id,
        );
        newList.add(slidersData);
      },
    );
    sliders = newList;
    return newList;
  }

  Future<List<UserModel>> getUserData({required String id}) async {
    List<UserModel> newList = [];
    UserModel user;
    CollectionReference data = FirebaseFirestore.instance.collection("User");
    QuerySnapshot shirtSnapShot = await data.get();
    shirtSnapShot.docs.forEach(
      (element) {
        if (element.id == id) {
          user = UserModel(
              email: element.get("UserEmail"),
              gender: element.get("UserGender"),
              name: element.get("UserName"),
              id: id,
              avt: element.get("avtar"),
              address: element.get("address"),
              phone: element.get("phone"));
          newList.add(user);
        }
      },
    );
    return newList;
  }

  Future<List<UserModel>> getUserList() async {
    List<UserModel> newList = [];
    UserModel user;
    CollectionReference data = FirebaseFirestore.instance.collection("User");
    QuerySnapshot shirtSnapShot = await data.get();
    shirtSnapShot.docs.forEach(
      (element) {
        user = UserModel(
            email: element.get("UserEmail"),
            gender: element.get("UserGender"),
            name: element.get("UserName"),
            id: element.id,
            avt: element.get("avtar"),
            address: element.get("address"),
            phone: element.get("phone"));
        newList.add(user);
      },
    );
    return newList;
  }

  Future<void> getAvtData({required String id}) async {
    List<UserModel> newList = [];
    CollectionReference data = FirebaseFirestore.instance.collection("User");
    QuerySnapshot shirtSnapShot = await data.get();
    shirtSnapShot.docs.forEach(
      (element) {
        if (element.id == id) {
          user = UserModel(
              email: element.get("UserEmail"),
              gender: element.get("UserGender"),
              name: element.get("UserName"),
              id: id,
              avt: element.get("avtar"),
              address: element.get("address"),
              phone: element.get("phone"));
          newList.add(user);
        }
      },
    );
    users = newList;
    notifyListeners();
  }

  String get getavt {
    return users.elementAt(0).avt;
  }

  Future<void> getSlidersData() async {
    List<Sliders> newList = [];
    CollectionReference data =
        FirebaseFirestore.instance.collection("imageslider");
    QuerySnapshot shirtSnapShot = await data.get();
    shirtSnapShot.docs.forEach(
      (element) {
        slidersData = Sliders(
          image: element.get("image"),
          name: element.get("name"),
          id: element.id,
        );
        newList.add(slidersData);
      },
    );
    sliders = newList;
  }

  List<Sliders> get getslidersList {
    return sliders;
  }

  Future<List<BillModel>> getBillData() async {
    List<BillModel> newList = [];

    CollectionReference data = FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("bill");
    QuerySnapshot shirtSnapShot = await data.get();
    shirtSnapShot.docs.forEach(
      (element) {
        List<CartModel> cartlt = [];
        Future<QuerySnapshot> snapShot =
            data.doc(element.id).collection("cart").get();
        snapShot.then((value) => value.docs.forEach((e) {
              cartnew = CartModel(
                size: e.get("size"),
                price: e.get("price"),
                name: e.get("name"),
                image: e.get("image"),
                quantity: e.get("quantity"),
                id: e.get("id"),
              );
              cartlt.add(cartnew);
            }));
        billnew = BillModel(
            address: element.get("address"),
            codebill: element.get("codebill"),
            date: element.get("date"),
            phone: element.get("phone"),
            name: element.get("name"),
            postcode: element.get("postcode"),
            status: element.get("status"),
            price: element.get("price"),
            item: element.get("item"),
            phoneship: element.get("phoneship"),
            cart: cartlt);
        newList.add(billnew);
      },
    );
    return newList;
  }

  Future<List<BillModel>> getBillId(String id) async {
    List<BillModel> newList = [];
    CollectionReference data = FirebaseFirestore.instance
        .collection("User")
        .doc(id)
        .collection("bill");
    QuerySnapshot shirtSnapShot = await data.get();
    shirtSnapShot.docs.forEach(
      (element) {
        List<CartModel> cartlt = [];
        Future<QuerySnapshot> snapShot =
            data.doc(element.id).collection("cart").get();
        snapShot.then((value) => value.docs.forEach((e) {
              cartnew = CartModel(
                size: e.get("size"),
                price: e.get("price"),
                name: e.get("name"),
                image: e.get("image"),
                quantity: e.get("quantity"),
                id: e.get("id"),
              );
              cartlt.add(cartnew);
            }));
        billnew = BillModel(
            address: element.get("address"),
            codebill: element.get("codebill"),
            date: element.get("date"),
            phone: element.get("phone"),
            name: element.get("name"),
            postcode: element.get("postcode"),
            status: element.get("status"),
            price: element.get("price"),
            item: element.get("item"),
            phoneship: element.get("phoneship"),
            cart: cartlt);
        newList.add(billnew);
      },
    );
    return newList;
  }

  // getAvatarUrlForProfile() async {
  //   Reference ref = FirebaseStorage.instance
  //       .ref()
  //       .child("images")
  //       .child('/listmenu')
  //       .child("snack1.jpg");

  //   //get image url from firebase storage
  //   var url = await ref.getDownloadURL();

  //   // put the URL in the state, so that the UI gets rerendered
  //   print(url);
  // }
  String getGender() {
    getGenders();
    return _gender;
  }

  void getGenders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _gender = prefs.getString('gender') ?? "";
    notifyListeners();
  }
  void addGenders(String gender) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _gender = gender;
    prefs.setString("gender", _gender);
    notifyListeners();
  }
}

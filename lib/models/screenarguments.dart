import 'package:apporder/models/cart.dart';
import 'package:apporder/models/news.dart';
import 'package:apporder/models/product.dart';
import 'package:flutter/material.dart';

class ScreenArguments {
  final List<Product> snapshot;
  final String name;
  ScreenArguments({required this.snapshot, required this.name});
}

class DetailArguments {
  final Product snapshot;
  DetailArguments({required this.snapshot});
}

class DetailnewsArguments {
  final News snapshot;
  DetailnewsArguments({required this.snapshot});
}

class DetailbillArguments {
  final List<CartModel> snapshot;
  final String codebill;
  final String name;
  final String phone;
  final String address;
  DetailbillArguments(
      {required this.snapshot,
      required this.codebill,
      required this.name,
      required this.phone,
      required this.address});
}

class DetailbillvArguments {
  final List<CartModel> snapshot;
  final String codebill;
  final String name;
  final String phone;
  final String phoneship;
  final String address;
  final String id;
  DetailbillvArguments(
      {required this.snapshot,
      required this.codebill,
      required this.name,
      required this.phone,
      required this.address,
      required this.phoneship,
      required this.id});
}

class ViewbillArguments {
  final String id;
  ViewbillArguments({required this.id});
}

class ShareKeys {
  late GlobalKey<ScaffoldState> keys;
  ShareKeys({required this.keys});
}

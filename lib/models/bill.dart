// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:apporder/models/cart.dart';

class BillModel {
  final String address;
  final String codebill;
  final String date;
  var phone;
  var name;
  var postcode;
  var status;
  var price;
  var item;
  var phoneship;
  List<CartModel> cart;
  BillModel({
    required this.address,
    required this.codebill,
    required this.date,
    required this.phone,
    required this.name,
    required this.postcode,
    required this.status,
    required this.price,
    required this.item,
    required this.phoneship,
    required this.cart,
  });
}

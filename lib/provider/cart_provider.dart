// ignore_for_file: await_only_futures, prefer_final_fields

import 'package:apporder/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  num _count = 0;
  num _counts = 0;
  String _link = "";
  String _links = "";
  String get link => _link;
  num get count => _count;
  String _login = "";
  String get login => _login;
 

  List<CartModel> myList = [];
  void addCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _count++;
    prefs.setInt("count", _count.toInt());
    notifyListeners();
  }

  void removeCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_count > 1) {
      _count--;
      prefs.setInt("count", _count.toInt());
    }
    notifyListeners();
  }

  void removeCounts(num count) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_count > 0) {
      _count -= count;
      if (_count <= 0) {
        _count = 0;
      }
      prefs.setInt("count", _count.toInt());
    }
    notifyListeners();
  }

  void addCounts(num count) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _count += count;
    prefs.setInt("count", _count.toInt());
    notifyListeners();
  }

  num getCount() {
    getList();
    return _count = _counts;
  }

  void getList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counts = prefs.getInt('count') ?? 0;
    notifyListeners();
  }

  void addLink(String avt) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("avt", avt);
    notifyListeners();
  }

  String getLink() {
    getLinks();
    return _link = _links;
  }

  void getLinks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _links = prefs.getString('avt') ?? "";
    notifyListeners();
  }

  String checkLogin() {
    getLogin();
    return _login;
  }
  void getLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _login = prefs.getString('uid') ?? "";
    notifyListeners();
  }

  
}

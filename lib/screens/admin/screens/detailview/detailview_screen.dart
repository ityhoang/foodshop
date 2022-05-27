// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:apporder/models/cart.dart';
import 'package:apporder/models/screenarguments.dart';
import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/routes.dart';
import 'package:apporder/screens/admin/screens/user/user_screen.dart';
import 'package:apporder/screens/admin/screens/detailview/components/body.dart';
import 'package:flutter/material.dart';

class DetailviewScreen extends StatefulWidget {
  const DetailviewScreen({Key? key}) : super(key: key);
  static String routeName = "/admin/detailview";
  @override
  _DetailviewScreenState createState() => _DetailviewScreenState();
}

class _DetailviewScreenState extends State<DetailviewScreen> {
  GlobalKey<ScaffoldState> keys = GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    super.dispose();
  }

  List<CartModel> snapshot = [];
  String codebill = '';
  String name = '';
  String phone = '';
  String phoneship = '';
  String address = '';
  String id = '';
  Future<void> getName(context) async {
    try {
      final args =
          ModalRoute.of(context)!.settings.arguments as DetailbillvArguments;
      snapshot = args.snapshot;
      codebill = args.codebill;
      name = args.name;
      phone = args.phone;
      address = args.address;
      phoneship = args.phoneship;
      id = args.id;
    } catch (e) {
      Timer.run(() {
        FluroRouters.router
            .navigateTo(context, UserScreen.routeName, replace: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getName(context);
    return Responsive(
      desktop: Body(
          snapshot: snapshot,
          codebill: codebill,
          name: name,
          phone: phone,
          address: address,
          phoneship: phoneship,
          id: id,
          keys: keys),
      tablet: Body(
          snapshot: snapshot,
          codebill: codebill,
          name: name,
          phone: phone,
          address: address,
          phoneship: phoneship,
          id: id,
          keys: keys),
      mobile: Body(
          snapshot: snapshot,
          codebill: codebill,
          name: name,
          phone: phone,
          address: address,
          phoneship: phoneship,
          id: id,
          keys: keys),
      keys: keys,
    );
  }
}

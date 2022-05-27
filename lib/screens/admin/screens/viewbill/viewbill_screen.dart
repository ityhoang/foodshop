// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:apporder/models/screenarguments.dart';
import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/routes.dart';
import 'package:apporder/screens/admin/screens/user/user_screen.dart';
import 'package:apporder/screens/admin/screens/viewbill/components/body.dart';
import 'package:flutter/material.dart';

class ViewbillScreen extends StatefulWidget {
  const ViewbillScreen({Key? key}) : super(key: key);
  static String routeName = "/admin/bill";
  @override
  _ViewbillScreenState createState() => _ViewbillScreenState();
}

class _ViewbillScreenState extends State<ViewbillScreen> {
  GlobalKey<ScaffoldState> keys = GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    super.dispose();
  }

  String id = '';
  Future<void> getName(context) async {
    try {
      final args =
          ModalRoute.of(context)!.settings.arguments as ViewbillArguments;
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
      desktop: Body(keys: keys, id: id),
      tablet: Body(keys: keys, id: id),
      mobile: Body(keys: keys, id: id),
      keys: keys,
    );
  }
}

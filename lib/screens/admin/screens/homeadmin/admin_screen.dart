// ignore_for_file: prefer_const_constructors

import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/screens/admin/screens/homeadmin/components/body.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);
  static String routeName = "/admin";
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  GlobalKey<ScaffoldState> keys = GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      desktop: Body(keys: keys),
      tablet: Body(keys: keys),
      mobile: Body(keys: keys),
      keys: keys,
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/screens/admin/screens/user/components/body.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);
  static String routeName = "/admin/user";
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
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

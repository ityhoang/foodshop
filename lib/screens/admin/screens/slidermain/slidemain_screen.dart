// ignore_for_file: prefer_const_constructors

import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/screens/admin/screens/slidermain/components/body.dart';
import 'package:flutter/material.dart';

class SlidermainScreen extends StatefulWidget {
  const SlidermainScreen({Key? key}) : super(key: key);
  static String routeName = "/admin/slider";
  @override
  _SlidermainScreenState createState() => _SlidermainScreenState();
}

class _SlidermainScreenState extends State<SlidermainScreen> {
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

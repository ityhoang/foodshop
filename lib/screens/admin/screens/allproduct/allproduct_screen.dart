// ignore_for_file: prefer_const_constructors

import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/screens/admin/screens/allproduct/components/body.dart';
import 'package:flutter/material.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({Key? key}) : super(key: key);
  static String routeName = "/admin/products";
  @override
  _AllProductScreenState createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
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

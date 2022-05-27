// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/screens/forgot/components/body.dart';
import 'package:apporder/screens/forgot/components/bodys.dart';
import 'package:flutter/material.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({Key? key}) : super(key: key);
  static String routeName = "/forgotpass";
  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  GlobalKey<ScaffoldState> keys = GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      desktop: Bodys(),
      tablet: Bodys(),
      mobile: Body(),
      keys: keys,
    );
  }
}

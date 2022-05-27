// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:apporder/components/silde_menu.dart';
import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/screens/admin/screens/homeadmin/components/header.dart';
import 'package:apporder/screens/admin/screens/homeadmin/components/contents.dart';
import 'package:apporder/utils/color_constant.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  final GlobalKey<ScaffoldState> keys;
  const Body({Key? key, required this.keys}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(),
              ),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Column(
                        children: [
                          Header(),
                          SizedBox(height: defaultPadding),
                          Contents(),
                        ],
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}

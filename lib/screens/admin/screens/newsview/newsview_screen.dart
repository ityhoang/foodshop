// ignore_for_file: prefer_const_constructors

import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/screens/admin/screens/newsview/components/body.dart';
import 'package:flutter/material.dart';

class NewsviewScreen extends StatefulWidget {
  const NewsviewScreen({Key? key}) : super(key: key);
  static String routeName = "/admin/newsview";
  @override
  _NewsviewScreenState createState() => _NewsviewScreenState();
}

class _NewsviewScreenState extends State<NewsviewScreen> {
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

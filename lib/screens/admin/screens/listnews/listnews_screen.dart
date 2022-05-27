// ignore_for_file: prefer_const_constructors

import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/screens/admin/screens/listnews/components/body.dart';
import 'package:flutter/material.dart';

class ListnewsScreen extends StatefulWidget {
  const ListnewsScreen({Key? key}) : super(key: key);
  static String routeName = "/admin/listnews";
  @override
  _ListnewsScreenState createState() => _ListnewsScreenState();
}

class _ListnewsScreenState extends State<ListnewsScreen> {
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

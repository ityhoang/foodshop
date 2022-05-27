import 'package:apporder/routes.dart';
import 'package:apporder/screens/admin/screens/allproduct/allproduct_screen.dart';
import 'package:apporder/screens/admin/screens/homeadmin/admin_screen.dart';
import 'package:apporder/screens/admin/screens/listnews/listnews_screen.dart';
import 'package:apporder/screens/admin/screens/newsview/newsview_screen.dart';
import 'package:apporder/screens/admin/screens/slidermain/slidemain_screen.dart';
import 'package:apporder/screens/admin/screens/user/user_screen.dart';
import 'package:apporder/screens/homes/homes_screen.dart';
import 'package:apporder/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: defaultPadding * 3,
                ),
                // Image.asset(
                //   "assets/images/logo.png",
                //   scale: 5,
                // ),
                SizedBox(
                  height: defaultPadding,
                ),
                Text("Admin - Application")
              ],
            )),
            DrawerListTile(
              title: "News",
              svgSrc: "assets/icons/menu_dashbord.svg",
              press: () {
                FluroRouters.router.navigateTo(
                  context,
                  ListnewsScreen.routeName,
                  replace: true,
                );
              },
            ),
            DrawerListTile(
              title: "Add News",
              svgSrc: "assets/icons/menu_tran.svg",
              press: () {
                FluroRouters.router.navigateTo(
                  context,
                  NewsviewScreen.routeName,
                  replace: true,
                );
              },
            ),
            DrawerListTile(
              title: "Update Slider",
              svgSrc: "assets/icons/menu_task.svg",
              press: () {
                FluroRouters.router.navigateTo(
                  context,
                  SlidermainScreen.routeName,
                  replace: true,
                );
              },
            ),
            DrawerListTile(
              title: "Add Product",
              svgSrc: "assets/icons/menu_doc.svg",
              press: () {
                FluroRouters.router.navigateTo(
                  context,
                  AdminHomeScreen.routeName,
                  replace: true,
                );
              },
            ),
            DrawerListTile(
              title: "Product",
              svgSrc: "assets/icons/menu_store.svg",
              press: () {
                FluroRouters.router.navigateTo(
                  context,
                  AllProductScreen.routeName,
                  replace: true,
                );
              },
            ),
            DrawerListTile(
              title: "Users",
              svgSrc: "assets/icons/menu_notification.svg",
              press: () {
                FluroRouters.router.navigateTo(
                  context,
                  UserScreen.routeName,
                  replace: true,
                );
              },
            ),
            DrawerListTile(
              title: "Home",
              svgSrc: "assets/icons/menu_profile.svg",
              press: () {
                FluroRouters.router.navigateTo(
                  context,
                  HomesScreen.routeName,
                  replace: true,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Color(0xFF272727),
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Color(0xFF272727)),
      ),
    );
  }
}

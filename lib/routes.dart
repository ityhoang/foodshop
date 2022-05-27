// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:apporder/screens/admin/screens/allproduct/allproduct_screen.dart';
import 'package:apporder/screens/admin/screens/detailview/detailview_screen.dart';
import 'package:apporder/screens/admin/screens/homeadmin/admin_screen.dart';
import 'package:apporder/screens/admin/screens/listnews/listnews_screen.dart';
import 'package:apporder/screens/admin/screens/newsview/newsview_screen.dart';
import 'package:apporder/screens/admin/screens/slidermain/slidemain_screen.dart';
import 'package:apporder/screens/admin/screens/user/user_screen.dart';
import 'package:apporder/screens/admin/screens/viewbill/viewbill_screen.dart';
import 'package:apporder/screens/bill/bill_screen.dart';
import 'package:apporder/screens/cart/cart_screen.dart';
import 'package:apporder/screens/detailbill/detailbill_screen.dart';
import 'package:apporder/screens/detailnews/detailnews_screen.dart';
import 'package:apporder/screens/details/chitietscreen.dart';
import 'package:apporder/screens/favourite/favourite.dart';
import 'package:apporder/screens/forgot/forgot_screen.dart';
import 'package:apporder/screens/homes/homes_screen.dart';
import 'package:apporder/screens/login_signup/loginsignup_page.dart';
import 'package:apporder/screens/payment/payment.dart';
import 'package:apporder/screens/product/product_screend.dart';
import 'package:apporder/screens/products/products_screen.dart';
import 'package:apporder/screens/profile/profile_screen.dart';
import 'package:apporder/screens/splash/splash_screen.dart';
import 'package:fluro/fluro.dart';

// final Map<String, WidgetBuilder> routes = {
//   SplashScreen.routeName: (context) => SplashScreen(),
//   LoginSignupScreen.routeName: (context) => LoginSignupScreen(),
//   TestScreen.routeName: (context) => TestScreen(),
//   HomesScreen.routeName: (context) => HomesScreen(),
//   HomeScreen.routeName: (context) => HomeScreen(),
// };

class FluroRouters {
  static FluroRouter router = FluroRouter();
  static Handler _splash = Handler(
    handlerFunc: (context, Map<String, dynamic> params) {
      return SplashScreen();
    },
  );
  static Handler _loginsignup = Handler(
    handlerFunc: (context, Map<String, dynamic> params) {
      return LoginSignupScreen();
    },
  );
  static Handler _homes = Handler(
    handlerFunc: (context, Map<String, dynamic> params) {
      return HomesScreen();
    },
  );
  static Handler _details = Handler(
    handlerFunc: (context, Map<String, dynamic> params) {
      return ChitietScreen();
    },
  );
  static Handler _cart = Handler(
    handlerFunc: (context, Map<String, dynamic> params) {
      return CartScreen();
    },
  );
  static Handler _products = Handler(
    handlerFunc: (context, Map<String, dynamic> params) {
      return ProductsScreen();
    },
  );
  static Handler _product = Handler(
    handlerFunc: (context, Map<String, dynamic> params) {
      return ProductScreen();
    },
  );
  static Handler _favourite = Handler(
    handlerFunc: (context, Map<String, dynamic> params) {
      return FavouriteScreen();
    },
  );
  static Handler _payment = Handler(
    handlerFunc: (context, Map<String, dynamic> params) {
      return PaymentScreen();
    },
  );
  static Handler _profile = Handler(
    handlerFunc: (context, Map<String, dynamic> params) {
      return ProfileScreen();
    },
  );
  static Handler _bill = Handler(
    handlerFunc: (context, Map<String, dynamic> params) {
      return BillScreen();
    },
  );
  static Handler _detailbill = Handler(
    handlerFunc: (context, Map<String, dynamic> params) {
      return DetailbillScreen();
    },
  );
  static Handler _detailnews = Handler(
    handlerFunc: (context, Map<String, dynamic> params) {
      return DetailnewsScreen();
    },
  );
  static Handler _adminhome = Handler(
    handlerFunc: (context, Map<String, dynamic> params) {
      return AdminHomeScreen();
    },
  );
  static Handler _adminproduct = Handler(
    handlerFunc: (context, Map<String, dynamic> params) {
      return AllProductScreen();
    },
  );
  static Handler _user = Handler(
    handlerFunc: (context, Map<String, dynamic> params) {
      return UserScreen();
    },
  );
  static Handler _viewbill = Handler(
    handlerFunc: (context, Map<String, dynamic> params) {
      return ViewbillScreen();
    },
  );
  static Handler _detailview = Handler(
    handlerFunc: (context, Map<String, dynamic> params) {
      return DetailviewScreen();
    },
  );
  static Handler _slidermain = Handler(
    handlerFunc: (context, Map<String, dynamic> params) {
      return SlidermainScreen();
    },
  );
  static Handler _newsview = Handler(
    handlerFunc: (context, Map<String, dynamic> params) {
      return NewsviewScreen();
    },
  );
  static Handler _listnews = Handler(
    handlerFunc: (context, Map<String, dynamic> params) {
      return ListnewsScreen();
    },
  );
  static Handler _forgot = Handler(
    handlerFunc: (context, Map<String, dynamic> params) {
      return ForgotScreen();
    },
  );

  // static Handler _page1 = Handler(
  //     handlerFunc: (BuildContext context, Map<String, dynamic> params) => Page1(
  //           params['param1'][0],
  //           params['param2'][0],
  //         ));

  // static Handler _page2 = Handler(
  //     handlerFunc: (BuildContext context, Map<String, dynamic> params) => Page2(
  //           params['param1'][0],
  //           params['param1'][1],
  //           params['param2'][0],
  //         ));

  static void setupRouter() {
    router.define(
      '/',
      handler: _splash,
    );
    router.define(
      SplashScreen.routeName,
      handler: _splash,
    );
    router.define(
      HomesScreen.routeName,
      handler: _homes,
    );
    router.define(
      LoginSignupScreen.routeName,
      handler: _loginsignup,
    );
    router.define(
      ChitietScreen.routeName,
      handler: _details,
    );
    router.define(
      CartScreen.routeName,
      handler: _cart,
    );
    router.define(
      ProductsScreen.routeName,
      handler: _products,
    );
    router.define(
      ProductScreen.routeName,
      handler: _product,
    );
    router.define(
      FavouriteScreen.routeName,
      handler: _favourite,
    );
    router.define(
      PaymentScreen.routeName,
      handler: _payment,
    );
    router.define(
      ProfileScreen.routeName,
      handler: _profile,
    );
    router.define(
      BillScreen.routeName,
      handler: _bill,
    );
    router.define(
      DetailbillScreen.routeName,
      handler: _detailbill,
    );
    router.define(
      DetailnewsScreen.routeName,
      handler: _detailnews,
    );
    router.define(
      AdminHomeScreen.routeName,
      handler: _adminhome,
    );
    router.define(
      AllProductScreen.routeName,
      handler: _adminproduct,
    );
    router.define(
      UserScreen.routeName,
      handler: _user,
    );
    router.define(
      ViewbillScreen.routeName,
      handler: _viewbill,
    );
    router.define(
      DetailviewScreen.routeName,
      handler: _detailview,
    );
    router.define(
      SlidermainScreen.routeName,
      handler: _slidermain,
    );
    router.define(
      NewsviewScreen.routeName,
      handler: _newsview,
    );
    router.define(
      ListnewsScreen.routeName,
      handler: _listnews,
    );
    router.define(
      ForgotScreen.routeName,
      handler: _forgot,
    );

    // router.define(
    //   'page1/:param1/:param2',
    //   handler: _page1,
    //   transitionType: TransitionType.inFromBottom,
    // );

    // router.define(
    //   'page2',
    //   handler: _page2,
    //   transitionType: TransitionType.inFromLeft,
    // );
  }
}

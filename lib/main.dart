import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tkjidi/Home/main_Home.dart';
import 'package:tkjidi/Account/main_Account.dart';
import 'package:tkjidi/News/main_News.dart';
import 'package:provide/provide.dart';
import 'package:tkjidi/provider/supCategoly.dart';
import 'package:fluro/fluro.dart';
import 'package:tkjidi/routes/application.dart';
import 'package:tkjidi/routes/routes.dart';
import 'package:tkjidi/provider/productDetailProvider.dart';
void main(){
  var supcate = SupCategoly();
  var productDetail = ProductDetailProvider();
  var provi = Providers();
  provi
  ..provide(Provider<SupCategoly>.value(supcate))
  ..provide(Provider<ProductDetailProvider>.value(productDetail));
  runApp(ProviderNode(child: MyApp(), providers: provi,));

  if(Platform.isAndroid){
    SystemUiOverlayStyle style = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      ///这是设置状态栏的图标和字体的颜色 
      ///Brightness.light  一般都是显示为白色
      ///Brightness.dark 一般都是显示为黑色
      statusBarIconBrightness: Brightness.light
    );
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static List<Widget> _list  = <Widget>[
    Main_Home(),CategolyList(),Main_Account(),
  ];
  int selectIndex = 0;
  void _onItemTapped(int index){
    setState(() {
     selectIndex = index; 
    });
  }
  @override
  Widget build(BuildContext context) {
    final route = Router();
    Routes.configuerRoutes(route);
    Application.router = route;

    return MaterialApp(
      onGenerateRoute: Application.router.generator,
      home: Scaffold(
        
        body: _list.elementAt(selectIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),title: Text("9.9包邮")),
            BottomNavigationBarItem(icon: Icon(Icons.list),title: Text("分类")),
            BottomNavigationBarItem(icon: Icon(Icons.account_balance),title: Text("我的")),
          ],
          selectedItemColor: Colors.lightBlue,
          unselectedItemColor: Colors.grey[600],
          currentIndex: selectIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:tkjidi/Home/main_Home.dart';
import 'package:tkjidi/Account/main_Account.dart';
import 'package:tkjidi/News/main_News.dart';
import 'package:provide/provide.dart';
import 'package:tkjidi/provider/supCategoly.dart';
void main(){
  var supcate = SupCategoly();
  var provi = Providers();
  provi
  ..provide(Provider<SupCategoly>.value(supcate));

  runApp(ProviderNode(child: MyApp(), providers: provi,));
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
    
    return MaterialApp(
      home: Scaffold(
        
        body: _list.elementAt(selectIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),title: Text("9.9包邮")),
            BottomNavigationBarItem(icon: Icon(Icons.list),title: Text("种草")),
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
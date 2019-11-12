import 'package:flutter/material.dart';
class Products_List extends StatelessWidget {
  final String balbal;
  Products_List(this.balbal);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('data===>$balbal'),
      ),
    );
  }
}
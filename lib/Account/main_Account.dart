import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:tkjidi/provider/supCategoly.dart';
class Main_Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Provide<SupCategoly>(
        builder: (context,child,sumPro){
          return Text('${sumPro.selectCIndex}',style: TextStyle(fontSize: 38),);
        },
      ),
    );
  }
}
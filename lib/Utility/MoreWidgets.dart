import 'package:flutter/material.dart';
/*
* 生成常用的AppBar
*/
Widget buildAppBar(BuildContext context, String text,
{double fontSize: 18.0,
double height: 50.0,
double elevation: 0.5,
Widget leading,
bool centerTitle: false,
List<Widget> actions}) 
{
return PreferredSize(
child: GestureDetector(
child: AppBar(
  backgroundColor: Colors.transparent,
elevation: elevation, //阴影
centerTitle: centerTitle,
title: Text(text, style: TextStyle(fontSize: fontSize)),
leading: leading,
actions: actions,
)),
preferredSize: Size.fromHeight(height));
}

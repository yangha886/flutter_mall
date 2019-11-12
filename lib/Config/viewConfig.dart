import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
double ssSetWidth(double width){
  return ScreenUtil().setWidth(width);
}
double ssSetHeigth(double height){
  return ScreenUtil().setHeight(height);
}
double ssSp(double sp){
  return ScreenUtil().setSp(sp);
}
//灰线
class greyLineUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      height: ssSetHeigth(10),
      constraints: BoxConstraints.expand(height: 10),
    );
  }
}
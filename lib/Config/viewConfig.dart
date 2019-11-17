import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tkjidi/Request/httpRequest.dart';
double ssSetWidth(double width){
  return ScreenUtil().setWidth(width);
}
double ssSetHeigth(double height){
  return height/2;
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
      color: Colors.grey[100],
      height: ssSetHeigth(10),
      constraints: BoxConstraints.expand(height: 10),
    );
  }
}
CachedNetworkImage returnImageWithUrl(String url){
  return CachedNetworkImage(
    placeholder: (context, url) => CircularProgressIndicator(),
    imageUrl: fixImgUrl(url),
    errorWidget: (context, url, error) => const Icon(Icons.error),
  );
}
void showToast(String str){
  Fluttertoast.showToast(
                  msg: str,
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIos: 1,
                  backgroundColor: Colors.black87,
                  textColor: Colors.white,
                  fontSize: ssSp(28),
                  gravity: ToastGravity.CENTER
                );
}
import 'package:flutter/material.dart';
import '../Models/productDetailInfoModel.dart';
import 'package:tkjidi/Config/viewConfig.dart';
class productDetail_bottomView extends StatelessWidget {
  ProductDetailInfoModel model;
  productDetail_bottomView(this.model);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ssSetHeigth(140),
      width: ssSetWidth(750),
      margin: EdgeInsets.only(bottom: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 0.5,color: Colors.grey[300])
        )
      ),
      child: Row(
        children: <Widget>[
          IconButton(icon: Icon(Icons.add_circle),),
          IconButton(icon: Icon(Icons.add_a_photo),),
          IconButton(icon: Icon(Icons.add_alarm),),
          Text("底部视图三个按钮还没做")
        ],
      ),
    );
  }
}
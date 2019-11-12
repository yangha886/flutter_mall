import 'package:flutter/material.dart';
import '../Models/productDetailInfoModel.dart';
import 'package:tkjidi/Config/viewConfig.dart';

class ProductDetail_InfoView extends StatelessWidget {
  ProductDetailInfoModel model;
  ProductDetail_InfoView(this.model);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ssSetWidth(750),
      child: Column(
        children: <Widget>[
          _productDesTitleView(),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: model.detailPics.length,
            itemBuilder: (context,index){
              return Image.network(model.detailPics[index],fit: BoxFit.cover,);
            },
          )
        ],
      )
    );
  }
  //宝贝描述标题
  Widget _productDesTitleView(){
    return Container(
      height: ssSetHeigth(80),
      width: ssSetWidth(750),
      padding: EdgeInsets.only(top: 10),
      child: Text('-宝贝详情-',textAlign: TextAlign.center,),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Colors.grey[200]
          )
        )
      ),
    );
  }
}
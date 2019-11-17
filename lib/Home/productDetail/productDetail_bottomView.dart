import 'package:flutter/material.dart';
import 'package:tkjidi/Config/httpConfig.dart';
import 'package:tkjidi/Request/httpRequest.dart';
import '../Models/productDetailInfoModel.dart';
import 'package:tkjidi/Config/viewConfig.dart';
import 'package:url_launcher/url_launcher.dart';
class productDetail_bottomView extends StatelessWidget {
  ProductDetailInfoModel model;
  productDetail_bottomView(this.model);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ssSetHeigth(130),
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
          Container(
            padding: EdgeInsets.fromLTRB(60, 5, 60, 5),
            child: InkWell(
              onTap: (){
                showToast('收藏功能暂未实现');
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.favorite_border),
                  Text('收藏',style: TextStyle(fontSize: ssSp(24),color: Colors.black45),),
                ],
              ),
            )
          ),
          Container(
            width: ssSetWidth(225),
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20)),
              child: InkWell(
                child: _returnStackView(model.originalPrice.toString(), true),
                onTap: (){
                  getPrivilege(true);
                },
              ),
            ),
          ),
          Container(
            width: ssSetWidth(225),
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: ClipRRect(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),topRight: Radius.circular(20)),
              child: InkWell(
                onTap: (){
                  getPrivilege(false);
                },
                child: Container(
                  color: Colors.orange,
                  child: _returnStackView(model.actualPrice.toString(), false),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  Future getPrivilege(bool isLeft) async{
    Map query = {"appKey":appkey,"version":"v1.1.1","goodsId":model.goodsId};
    var rawData = await httpRequest().request(getPrivilegePath, query);
    if (isLeft) {
      launch(rawData['data']['itemUrl']);
    }else
    {
      launch(rawData['data']['couponClickUrl']);
    }
    print('转链地址:---->$rawData');
  }
  Widget _returnStackView(String price,bool isLeft){
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [isLeft?Colors.amber[400]:Colors.deepOrange,isLeft?Colors.amber[900]:Colors.deepOrange],
            )
          ),
        ),
        Positioned(
          left: 30,
          right: 30,
          top: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('¥',style: TextStyle(fontSize: ssSp(20),color: Colors.white),),
                  Text(price,style: TextStyle(fontSize: ssSp(34),color: Colors.white),)
                ],
              ),
              Text(isLeft?'不领券':'领券购买',style: TextStyle(color: Colors.white,fontSize: ssSp(22)),),
            ],
          ),
        ),
      ],
    );
  }
}
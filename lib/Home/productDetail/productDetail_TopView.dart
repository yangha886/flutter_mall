import 'package:flutter/material.dart';
import 'package:tkjidi/Config/viewConfig.dart';
import 'package:tkjidi/Home/Models/productDetailInfoModel.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:tkjidi/Request/httpRequest.dart';
class ProductDetail_TopView extends StatelessWidget {
  ProductDetailInfoModel model;
  ProductDetail_TopView(this.model);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _productPicView(),
          _productTitleView(),
          _productPriceView(),
          greyLineUI(),
          _editerDescView(),
          greyLineUI(),
          _productStoreView(),
          greyLineUI()
        ],
      ),
    );
  }
  //商品轮播图
  Widget _productPicView(){
    return Container(
      height: ssSetHeigth(800),
      width: ssSetWidth(750),
      color: Colors.white,
      child: Swiper(
            itemCount: model.imgs.length,
            itemBuilder: (context,index){
              String imgUrl = fixImgUrl(model.imgs[index].toString());
              return Image.network(imgUrl,fit: BoxFit.cover,);
            },
            pagination: SwiperPagination(),
            autoplay: true,
          ),
    );
  }
  //商品名称
  Widget _productTitleView(){
    return Container(
      width: ssSetWidth(750),
      padding: EdgeInsets.only(left: 10,top: 7),
      color: Colors.white,
      child: Container(
        width: ssSetWidth(750),
        child: Text(model.dtitle,style: TextStyle(fontSize: ssSp(30)),textAlign: TextAlign.left,),
      ),
    );
  }
  //商品价格
  Widget _productPriceView(){
    String monthSales = fixImgUrl(model.monthSales.toString());
    if (monthSales.length > 3){
      monthSales = "${(model.monthSales/10000).toStringAsFixed(2)}万";
    }
    return Container(
      padding: EdgeInsets.only(top: 10),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(padding: EdgeInsets.only(left: 10),child: Text('优惠价:¥${model.actualPrice.toString()}',style: TextStyle(fontSize: ssSp(36),color: Colors.deepOrangeAccent),),),
                  Container(padding: EdgeInsets.only(left: 10),child: Text('${model.shopType==0?"淘宝":"天猫"}价:¥${model.originalPrice}',style: TextStyle(fontSize: ssSp(22),color: Colors.black45,decoration: TextDecoration.lineThrough),),),
                ],
              ),
            )
          ),
          Container(
            padding: EdgeInsets.only(right: 10),
            child: Text("已售:$monthSales",style: TextStyle(fontSize: ssSp(24),color: Colors.black54)),
          )
        ],
      ),
    );
  }
  //小编推荐
  Widget _editerDescView(){
    return Container(
      width: ssSetWidth(750),
      color: Colors.white,
      padding: EdgeInsets.only(top: 10,bottom: 10,right: 10),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10),
            width: ssSetWidth(160),
            height: ssSetHeigth(40),
            child: Text('小编推荐',),
          ),
          Container(
            width: ssSetWidth(560),
            child: Text('${model.desc}',style: TextStyle(fontSize: ssSp(24),color: Colors.black54),),
          )
        ],
      ),
    );
  }
  //商铺信息
  Widget _productStoreView(){
    return Container(
      height: ssSetHeigth(170),
      width: ssSetWidth(750),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10,left: 10),
            height: ssSetHeigth(90),
            child: Row(
              children: <Widget>[
                Image.network('https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3049244695,1357729986&fm=15&gp=0.jpg'),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(model.shopName),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _storeScoreView('宝贝描述', model.descScore),
                _storeScoreView('卖家服务', model.shipScore),
                _storeScoreView('物流服务', model.serviceScore),
              ],
            ),
          )
        ],
      ),
    );
  }
  //店铺评分
  Widget _storeScoreView(String text,double score){
    return Container(
      width: ssSetWidth(750/3),
      child: Text('$text: $score',textAlign: TextAlign.center,),
    );
  }
}
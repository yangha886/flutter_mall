import 'package:flutter/material.dart';
import 'package:tkjidi/Config/httpConfig.dart';
import 'package:tkjidi/Home/main_Home.dart';
import '../Models/guessLikeListModel.dart';
import 'package:tkjidi/Config/viewConfig.dart';
import 'package:tkjidi/Request/httpRequest.dart';
import 'package:provide/provide.dart';
import 'package:tkjidi/provider/productDetailProvider.dart';
class ProductDetail_guessLikeView extends StatelessWidget {
  int productId;
  ScrollController scrollController;
  ProductDetail_guessLikeView(this.productId,this.scrollController);
  Future<List<guessLikeInfoModel>> _getLikeList() async{
    Map query = {"appKey":appkey,"version":"v1.1.0","size":"20","id":"$productId"};
    var rawData = await httpRequest().request(guessYouLikePath, query);
    return guessLikeListModel.fromJson(rawData).data;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: ssSetWidth(750),
      child: Column(
        children: <Widget>[
          _guessLikeTitleView(),
          FutureBuilder(
            future: _getLikeList(),
            builder: (context,snapshot){
              if (snapshot.hasData){
                return _guessLikeGridView(snapshot.data);
              }else{
                return Text('');
              }
            },
          )
        ],
      ),
    );
  }
  Widget _guessLikeGridView(List<guessLikeInfoModel> list){
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
      ),
      itemCount: list.length,
      itemBuilder: (context,index){
        String monthSales = list[index].monthSales.toString();
        if (monthSales.length > 3){
          monthSales = "${(list[index].monthSales/10000).toStringAsFixed(2)}万";
        }

        return InkWell(
          onTap: (){
            scrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.ease);
            Provide.value<ProductDetailProvider>(context).setProductModel(list[index].id.toString());
            //Application.router.navigateTo(context, '/productDetailView?id=${model.id}');
          },
          child: Container(
            padding: EdgeInsets.only(top: 20,left: 10,right: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.5,color: Colors.grey[200]),
                left: BorderSide(width: 0.5,color: Colors.grey[200])
              )
            ),
            child: Column(
              children: <Widget>[
                Container(
                  height: ssSetWidth(260),
                  width: ssSetWidth(260),
                  child: returnImageWithUrl(list[index].mainPic),
                ),
                Container(
                  height: ssSetHeigth(85),
                  padding: EdgeInsets.only(top: 3),
                  child: Text(list[index].dtitle,textAlign: TextAlign.center,),
                ),
                Container(width: ssSetWidth(750/2 - 20),child: Text('优惠价:¥${list[index].actualPrice.toString()}',style: TextStyle(fontSize: ssSp(28),color: Colors.deepOrangeAccent),),),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('${list[index].shopType==0?"淘宝":"天猫"}价:¥${list[index].originalPrice}',style: TextStyle(fontSize: ssSp(22),color: Colors.black45,decoration: TextDecoration.lineThrough),),
                    ),
                    Text("已售:$monthSales")
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
  //猜你喜欢标题
  Widget _guessLikeTitleView(){
    return Container(
      height: ssSetHeigth(80),
      width: ssSetWidth(750),
      padding: EdgeInsets.only(top: 10),
      child: Text('-猜你喜欢-',textAlign: TextAlign.center,),
      decoration: BoxDecoration(
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
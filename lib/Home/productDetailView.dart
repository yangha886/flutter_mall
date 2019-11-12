import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:tkjidi/Config/viewConfig.dart';
import 'package:tkjidi/provider/productDetailProvider.dart';
import './productDetail/productDetail_TopView.dart';
import './productDetail/productDetail_InfoView.dart';
import './productDetail/productDetail_guessLikeView.dart';
import './productDetail/productDetail_bottomView.dart';
class ProductDetailView extends StatelessWidget {
  String productId;
  ProductDetailView(this.productId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品详情'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: Provide<ProductDetailProvider>(
          builder: (context,child,proInfo){
            if (proInfo.model != null){
              return Column(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          ProductDetail_TopView(proInfo.model),
                          ProductDetail_InfoView(proInfo.model),
                          ProductDetail_guessLikeView(proInfo.model.id),
                        ],
                      ),
                    ),
                  ),
                  productDetail_bottomView(proInfo.model),
                ],
              );
            }else
            {
              return Center(
                child: Text('加载中....'),
              );
            }
          },
        )
      ),

    );
  }
}
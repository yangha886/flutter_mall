import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:tkjidi/Config/viewConfig.dart';
import 'package:tkjidi/provider/productDetailProvider.dart';
import './productDetail/productDetail_TopView.dart';
import './productDetail/productDetail_InfoView.dart';
import './productDetail/productDetail_guessLikeView.dart';
import './productDetail/productDetail_bottomView.dart';
class ProductDetailView extends StatefulWidget {
  String productId;
  ProductDetailView(this.productId);
  @override
  _ProductDetailViewState createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  double toolbarOpacity=0;
  bool showToTopBtn = false;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener((){
      print(scrollController.offset);
      double t = scrollController.offset / 300;
      if (t<0) {
        t =0;
      }else if (t > 1){
        t =1;
      }
      setState(() {
       toolbarOpacity = t; 
      });
      if(scrollController.offset < 300 && showToTopBtn){
        setState(() {
        showToTopBtn = false;
      });
      }else if(scrollController.offset >= 300 && !showToTopBtn){
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Stack(
        children: <Widget>[
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: Container(
              child: Provide<ProductDetailProvider>(
                builder: (context,child,proInfo){
                  if (proInfo.model != null){
                    return Column(
                      children: <Widget>[
                        Expanded(
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              children: <Widget>[
                                ProductDetail_TopView(proInfo.model),
                                if (proInfo.model.detailPics.length> 0 && proInfo.model.detailPics.first.toString() != '') 
                                  ProductDetail_InfoView(proInfo.model),
                                ProductDetail_guessLikeView(proInfo.model.id,scrollController),
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
          ),
          Opacity(
            opacity: toolbarOpacity,
            child: Container(
              height: 98,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.amber[300],Colors.red[300],Colors.pink[300]],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight
                )
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 44,
                      width: 44,
                      margin: EdgeInsets.only(left: 10),
                      child: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),onPressed: (){Navigator.pop(context);},),
                    ),
                    Expanded(
                      child: Text('商品详情',textAlign: TextAlign.center,style: TextStyle(fontSize: ssSp(30),color: Colors.white),),
                    ),
                    Container(
                      height: 44,
                      width: 44,
                    ),
                  ],
                )
                ),
              ),
          ),
          Opacity(
            opacity: 1-toolbarOpacity,
            child: Container(
              height: 98,
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 44,
                      width: 44,
                      margin: EdgeInsets.only(left: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: Container(
                          color: Colors.black45,
                          child: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),onPressed: (){Navigator.pop(context);},),
                        ),
                      )
                    ),
                    Container(),
                  ],
                )
                ),
              ),
            ),
        ]
      ),
      floatingActionButton: !showToTopBtn
          ? null
          : Container(
            width: 44,
            height: 44,
            margin: EdgeInsets.only(right: 0,bottom: 80),
            child: FloatingActionButton(
              child: Icon(Icons.keyboard_arrow_up),
              backgroundColor: Colors.black38,
              onPressed: () {
                scrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.ease);
              },
            ),
          ),
      floatingActionButtonLocation: !showToTopBtn ? null: FloatingActionButtonLocation.endDocked,
    );
  }
}

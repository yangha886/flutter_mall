
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:tkjidi/routes/application.dart';
import 'package:tkjidi/News/products_list.dart';
import 'package:tkjidi/Home/productDetailView.dart';
Handler productListHandler = Handler(
  handlerFunc: (BuildContext context, Map<String,List<String>> parameters){
    String cid = parameters['id'].first;
    String title = parameters['title'].first;
    String type = parameters['type'].first;
    return Products_list(cid,title,type);
  }
);

Handler productDetailHandler = Handler(
  handlerFunc: (context,parameters){
    String productId = parameters['id'].first;
    return ProductDetailView(productId);
  }
);

import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:tkjidi/routes/application.dart';
import 'package:tkjidi/News/products_list.dart';
import 'package:tkjidi/Home/productDetailView.dart';
Handler productListHandler = Handler(
  handlerFunc: (BuildContext context, Map<String,List<String>> parameters){
    String balbal = parameters['id'].first;
    return Products_List(balbal);
  }
);

Handler productDetailHandler = Handler(
  handlerFunc: (context,parameters){
    String productId = parameters['id'].first;
    return ProductDetailView(productId);
  }
);
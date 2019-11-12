import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:tkjidi/News/products_list.dart';
import 'package:tkjidi/routes/route_handler.dart';
import 'package:tkjidi/routes/routes.dart';
class Routes {
  static String root = '/';
  static String productPath = '/productDetailList';
  static String productDetailPath = '/productDetailView';
  static void configuerRoutes(Router router){
    router.notFoundHandler = Handler(
      handlerFunc: (context,paramers){
        print("not found this router");
      }
    );
    router.define(productPath,handler: productListHandler);
    router.define(productDetailPath, handler: productDetailHandler);
  }
}
import 'package:flutter/material.dart';
import '../Home/Models/productDetailInfoModel.dart';
import '../Request/httpRequest.dart';
import '../Config/httpConfig.dart';
class ProductDetailProvider with ChangeNotifier{
  ProductDetailInfoModel model;
  setProductModel(String productId) async{
    Map query = {"appKey":appkey,"version":"v1.1.0","id":productId};
    var rawData = await httpRequest().request(productDetailPath, query);
    model = productDetailInfoDataModel.fromJson(rawData).data;
    notifyListeners();
  }
}
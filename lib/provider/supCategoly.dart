import 'package:flutter/material.dart';

class SupCategoly with ChangeNotifier{
  int selectCIndex = 0;
  Map supCateData ;
  changedCIndex(int index){
    selectCIndex = index;
    notifyListeners();
  }

  setSupcateData(Map data){
    supCateData = data;
    notifyListeners();
  }
}
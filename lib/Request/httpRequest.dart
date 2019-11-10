import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:tkjidi/Config/httpConfig.dart' as prefix0;
import 'dart:convert';
class httpRequest{
  
  //加密验签
  String getSign(Map parameter) { 
    var k = '23c4642e0e6b5ec356b8cd8af501cce5';
    String pairsString = returnQueryString(parameter);
    String sign = pairsString + "&key=$k";
    String signString = generateMd5(sign).toUpperCase();
    return signString;
  }
  //map拼接字段
  String returnQueryString(Map parameter){
    /// 存储所有key
    List<String> allKeys = [];
    parameter.forEach((key,value){
      allKeys.add(key);
    });
    /// key排序
    allKeys.sort((obj1,obj2){
      return obj1.compareTo(obj2);
    });
    /// 存储所有键值对
    List<String> pairs = [];
    /// 添加键值对
    allKeys.forEach((key){
      pairs.add("$key=${parameter[key]}");
    });
    /// 数组转string
    String pairsString = pairs.join("&");
    return pairsString;
  }
  //md5加密方法
  String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return digest.toString();
  }

  Future request(path,formData) async{
    String sign = httpRequest().getSign(formData);
    HttpClient client = HttpClient();
    Uri uri= Uri(
      scheme: prefix0.scheme,
      host: prefix0.host,
      path: path,
      query: httpRequest().returnQueryString(formData)+'&sign=$sign'
    );
    print(uri);
    HttpClientRequest request = await client.getUrl(uri);
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    Map rawData = json.decode(responseBody);
    if (rawData["code"].toString() == '0'){
      return rawData;
    }else{
      print("接口获取失败,失败原因===${rawData["msg"]}");
    }
  }
}
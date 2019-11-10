import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:tkjidi/Config/httpConfig.dart' as prefix0;
import 'package:tkjidi/Config/viewConfig.dart';
import 'package:tkjidi/Request/httpRequest.dart';
import 'package:flutter/material.dart';
import 'package:tkjidi/Home/Models/ninedotnineModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
class Main_Home extends StatefulWidget {
  @override
  _Main_HomeState createState() => _Main_HomeState();
}

class _Main_HomeState extends State<Main_Home> {
  
  List<ninedotnineModel> dataList = [];
  List catalogueList = [];
  Future <List> getCatalogueListData() async{
    Map query = {"appKey":prefix0.appkey,"version":"v1.1.0"};
    var val = await httpRequest().request(prefix0.cataloguepath, query);
    List rawList = val['data'] as List;
    return rawList;
  }
  //调用9.9包邮接口
  Future <List<ninedotnineModel>> getHomeData() async{
    Map query = {"appKey":prefix0.appkey,"version":"v1.1.0","pageSize":"20","pageId":"1","nineCid":"-1"};
    var val = await httpRequest().request(prefix0.ndnpath, query);
    List rawList = val['data']['list'] as List;
    bool show = false;
    var models = rawList.map((map){
      var model = map as Map;
      ninedotnineModel ndnModel = ninedotnineModel(model["id"], model["goodsId"], model["title"], model["dtitle"], model["originalPrice"], model["actualPrice"], model["shopType"], model["goldSellers"], model["monthSales"], model["twoHoursSales"], model["dailySales"], model["desc"], model["couponReceiveNum"], model["couponTotalNum"], model["couponPrice"], model["couponLine"], model["couponEndTime"], model["couponStartTime"], model["mainPic"], model["marketingMainPic"], model["shopName"], model["itemLink"]);
      return ndnModel;
    }).toList();
    return models;
    
  }
  void getNDNProductRequest() async{
    var models = await getHomeData();
    var cmodels = await getCatalogueListData();
    setState(() {
     dataList = models; 
     catalogueList = cmodels;
    });
  }
  //好像不能一个组件用两个setstate,会冲突,所以把活动获取接口放到9.9方法里了
  void getCatalogueListRequest() async{
    
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    getNDNProductRequest();
    getCatalogueListRequest();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750,height: 1334)..init(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("9.9包邮"),
        ),
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          topBanner(),
          greyLineUI(),
          gridView(),
          greyLineUI(),
          cataloguesView(catalogueList),
          ndnTitle(),
          ndnProductList(dataList),
        ],
      ),
      
    ),
      ),
    );
  }
}
//灰线
class greyLineUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      height: ssSetHeigth(10),
      constraints: BoxConstraints.expand(height: 10),
    );
  }
}
//广告牌
class adBanner extends StatelessWidget {
  final String bannerUrl;
  adBanner(this.bannerUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ssSetHeigth(100),
      width: ssSetWidth(750),
      child: Image.network(bannerUrl,fit: BoxFit.fill,),
    );
  }
}
//顶部活动页
class topBanner extends StatelessWidget {
  final List<String> bannerList = <String>["http://img.zcool.cn/community/01a21d575a17770000018c1bb53779.jpg","http://img.zcool.cn/community/01a21d575a17770000018c1bb53779.jpg","http://img.zcool.cn/community/01a21d575a17770000018c1bb53779.jpg"];
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemCount: bannerList.length,
        itemBuilder: (context,index){
          return Image.network(bannerList[index],fit: BoxFit.fill,);
        },
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}
//商品分类页
class gridView extends StatelessWidget {
  List<Map> gridList = <Map>[{"icon":Icons.home,"title":"居家百货"},{"icon":Icons.add,"title":"美食"},{"icon":Icons.add_a_photo,"title":"服饰"},{"icon":Icons.add_alarm,"title":"配饰"},{"icon":Icons.add_alert,"title":"美妆"},{"icon":Icons.add_box,"title":"内衣"},{"icon":Icons.add_call,"title":"母婴"},{"icon":Icons.add_location,"title":"箱包"},{"icon":Icons.add_location,"title":"数码配件"},{"icon":Icons.add_location,"title":"文娱车品"}];
  Widget _contextView(BuildContext context,Map item){
    return InkWell(
      onTap: ()=>{
        print("${item.toString()}")
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(item["icon"]),
          Text(item["title"]),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ssSetHeigth(350),
      width: ssSetWidth(750),
      padding: EdgeInsets.all(3),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.all(5),
        crossAxisCount: 5,
        children: gridList.map((item){
          return _contextView(context, item);
        }).toList(),
      )
    );
  }
}
//热门活动
class cataloguesView extends StatelessWidget {
  List cataoguesList= [];
  cataloguesView(this.cataoguesList);
  @override
  Widget build(BuildContext context) {
    if (cataoguesList.length == 0){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Column(
      children: cataoguesList.map((item){
        return catalogInfoNoStateTest(item);
      }).toList(),
    );
    //因为没有使用appbar所以导致listview第一行顶部会有一片空白padding,所以使用removePadding
    // return MediaQuery.removePadding(
    //   removeTop: true,
    //   context: context,
    //   child: ListView.builder(
    //     physics: NeverScrollableScrollPhysics(),
    //     shrinkWrap: true,
    //     itemCount: cataoguesList.length,
    //     itemBuilder: (context,index){
    //       return catalogInfoNoStateTest(cataoguesList[index]);
    //     },
    //   ),
    // );
  }
}
//单个热门活动模块
class catalogInfoNoStateTest extends StatelessWidget {
  final Map item;
  List<ninedotnineModel> productList;
  catalogInfoNoStateTest(this.item);
  Future <List<ninedotnineModel>> _getActivityProdctList() async{
    Map query = {"appKey":prefix0.appkey,"version":"v1.1.0","pageSize":"20","pageId":"1","activityId":"${item["activityId"]}"};
    var rawData = await httpRequest().request(prefix0.cataProductpath, query);
    List rawList = rawData["data"]["list"] as List;
    var models = rawList.map((map){
      var model = map as Map;
      ninedotnineModel ndnModel = ninedotnineModel(model["id"], model["goodsId"], model["title"], model["dtitle"], model["originalPrice"], model["actualPrice"], model["shopType"], model["goldSellers"], model["monthSales"], model["twoHoursSales"], model["dailySales"], model["desc"], model["couponReceiveNum"], model["couponTotalNum"], model["couponPrice"], model["couponLine"], model["couponEndTime"], model["couponStartTime"], model["mainPic"], model["marketingMainPic"], model["shopName"], model["itemLink"]);
      return ndnModel;
    }).toList();
    return models;
  }
 
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getActivityProdctList(),
      builder: (context, snapshot){
        if (snapshot.hasData){
          productList = snapshot.data as List;
          return Column(
            children: <Widget>[
              Container(
                height: ssSetHeigth(120),
                padding: EdgeInsets.all(1),
                child: Row(
                  children: <Widget>[
                    Image.network(item['goodsLabel'],fit: BoxFit.fill,),
                    Expanded(
                      child: Image.network(item['detailLabel'],fit:BoxFit.fill),
                    )
                    
                  ],
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 3,color: Colors.grey[200])
                  )
                ),
              ),
              catalogTitleView(item["activityName"]),
              //singleActivityProductView(productList[0]),
              Container(
                  height: ssSetHeigth(330),
                  width: ssSetWidth(750),
                  child: ListView.builder(
                    itemCount: productList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                      return singleActivityProductView(productList[index]);
                    },
                  )
                ),
              greyLineUI()
              
            ],
          );
          
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
//活动标题栏
class catalogTitleView extends StatelessWidget {
  final String title;
  catalogTitleView(this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ssSetWidth(750),
      height: ssSetHeigth(88),
      padding: EdgeInsets.fromLTRB(10, 10, 0, 5),
      child: Text(title,style: TextStyle(color: Colors.pink),),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1,color: Colors.grey[200]),
        )
      ),
    );
  }
}
//单个活动商品展示
class singleActivityProductView extends StatelessWidget {
  final ninedotnineModel model;
  singleActivityProductView(this.model);
  @override
  Widget build(BuildContext context) {
    
    String imgString = model.mainPic;
    //接口会返回//开头的错误图片地址,所以需要修正
    if (imgString.startsWith("//") == true){
      imgString = 'https:'+imgString;
    }
    return InkWell(
      onTap: (){},
      child: Container(
        height: ssSetHeigth(330),
        width: ssSetWidth(250),
        child: Column(
          children: <Widget>[
            
            Image.network(imgString),
            Text(model.actualPrice.toString()),
            Text(model.originalPrice.toString(),style: TextStyle(decoration: TextDecoration.lineThrough,fontSize: 12,color: Colors.black12),),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            right: BorderSide(width: 1,color: Colors.grey[200])
          )
        ),
      )
    );
  }
}
//9.9标题
class ndnTitle extends StatelessWidget {
  final String imgUrl = "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2760302280,3837125440&fm=26&gp=0.jpg";
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.network(imgUrl,fit: BoxFit.fill,),
    );
  }
}
//9.9商品列表
class ndnProductList extends StatelessWidget {
  List<ninedotnineModel> _dataList;
  ndnProductList(this._dataList);
  Widget _ndnProductCell(ninedotnineModel model){
    String imgString = model.mainPic;
    String monthSales = model.monthSales.toString();
    //接口会返回//开头的错误图片地址,所以需要修正
    if (imgString.startsWith("//") == true){
      imgString = 'https:'+imgString;
    }
    if (monthSales.length > 3){
      monthSales = "${(model.monthSales/10000).toStringAsFixed(2)}万";
    }
    return Container(
      color: Colors.white,
      height:  ssSetHeigth(340),
      width:  ssSetWidth(750),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              width: ssSetWidth(300),
              height: ssSetHeigth(300),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 0),
              child: Image.network(imgString,fit: BoxFit.fill),
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  width: ssSetWidth(430),
                  height: ssSetHeigth(160),
                  margin: EdgeInsets.only(top: 20),
                  child: Text(model.dtitle,maxLines: 2,style: TextStyle(fontSize: 16),),
                ),
                Container(
                  margin: EdgeInsets.all(4),
                  width: ssSetWidth(430),
                  height: ssSetHeigth(38),
                  child: Text('优惠价:¥${model.actualPrice}',style: TextStyle(color: Colors.pink,fontSize: 14),textAlign: TextAlign.left,),
                ),
                Container(
                  width: ssSetWidth(430),
                  height: ssSetHeigth(40),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text('淘宝价:¥${model.originalPrice}',style: TextStyle(decoration: TextDecoration.lineThrough,fontSize: 12,color: Colors.grey[600]),),
                      ),
                      Text('销量:$monthSales'),
                    ],
                  ),
                ),
                Container(
                  height: ssSetHeigth(1),
                  width: ssSetWidth(430),
                  margin: EdgeInsets.only(top: 10),
                  color: Colors.grey[200],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _dataList.length,
      itemBuilder: (context,index){
        return _ndnProductCell(_dataList[index]);
      },
    );
  }
}
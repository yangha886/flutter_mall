import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:fluro/fluro.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:provide/provide.dart';
import 'package:tkjidi/Account/main_Account.dart';
import 'package:tkjidi/Config/httpConfig.dart' as prefix0;
import 'package:tkjidi/Config/viewConfig.dart';
import 'package:tkjidi/Home/Models/ninedotnineModel.dart';
import 'package:tkjidi/Home/searchAppBar.dart';
import 'package:tkjidi/Request/httpRequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:tkjidi/provider/productDetailProvider.dart';
import 'package:tkjidi/routes/application.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
class Main_Home extends StatefulWidget {
  @override
  _Main_HomeState createState() => _Main_HomeState();
}
BuildContext homeContext;
//调用9.9包邮接口,商品列表页面可以共用所以单独拿出来
Future <ninedotnineListModel> getndnListData(String cid,int pageIndex) async{
  Map query = {"appKey":prefix0.appkey,"version":"v1.1.0","pageSize":"20","pageId":pageIndex,"nineCid":cid};
  var val = await httpRequest().request(prefix0.ndnpath, query);
  return ninedotnineListModel.fromJson(val);
}
GlobalKey<_Main_HomeState> _easyRefreshKey = new GlobalKey<_Main_HomeState>();
class _Main_HomeState extends State<Main_Home> {
  ninedotnineListModel dataList;
  List catalogueList = [];
  int nowPageIndex = 1;
  FocusNode _focusNode;
  TextEditingController _controller = TextEditingController();
  List<Map> gridList = <Map>[{"title":"精品","nineCid":"1"},{"title":"居家百货","nineCid":"1"},{"title":"美食","nineCid":"2"},{"title":"服饰","nineCid":"3"},{"title":"配饰","nineCid":"4"},{"title":"美妆","nineCid":"5"},{"title":"内衣","nineCid":"6"},{"title":"母婴","nineCid":"7"},{"title":"箱包","nineCid":"8"},{"title":"数码配件","nineCid":"9"},{"title":"文娱车品","nineCid":"10"}];
  
  Future <List> getCatalogueListData() async{
    Map query = {"appKey":prefix0.appkey,"version":"v1.1.0"};
    var val = await httpRequest().request(prefix0.cataloguepath, query);
    List rawList = val['data'] as List;
    
    return rawList;
  }
  
  void getNDNProductRequest(String cid,int pageIndex) async{
    var models = await getndnListData(cid,pageIndex);
    nowPageIndex = pageIndex;
    var cmodels = await getCatalogueListData();
    setState(() {
     dataList = models; 
     catalogueList = cmodels;
    });
  }
  @override
  void initState() {
    super.initState();
    getNDNProductRequest('-1',1);
  }
  
  void _checkInput(){

  }
  Widget returnNDNCataViewInkWell(int index){
    return Container(
      //width: ssSetWidth(80),
      padding: EdgeInsets.only(left: 10,right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: (){
              if (index == 0)return;
              Application.router.navigateTo(context, '/productDetailList?id=${gridList[index]['nineCid']}&title=${Uri.encodeComponent(gridList[index]['title'])}&type=nineProduct',transition:TransitionType.inFromRight);
              },
            child: Center(
              child: Text(gridList[index]["title"],textAlign: TextAlign.center,style: TextStyle(fontSize: index==0?18:14,color: index==0?Colors.white:Colors.white54),),
            ),
          ),
        ],
      )
    );
  }
  //导航栏搜索框下的分类组件
  Widget ndnCatagoryView(){
    return Container(
      width: ssSetWidth(750),
      height: ssSetHeigth(70),
      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: gridList.length,
        itemBuilder: (context,index){
          return returnNDNCataViewInkWell(index);
        },
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    homeContext = context;
    ScreenUtil.instance = ScreenUtil(width: 750,height: 1334)..init(context);
    return MaterialApp(
      
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: SearchAppBar(
          backGroundColor: [Colors.amber[300],Colors.red[300],Colors.pink[300]],
          focusNode: _focusNode,
          controller: _controller,
          height: ssSetHeigth(160),
          child: ndnCatagoryView(),
          evevation: 0,
          inputFormatters: [LengthLimitingTextInputFormatter(70)],
          onEditingComplete: ()=>_checkInput(),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              color: Colors.grey[100],
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: EasyRefresh(
                key: _easyRefreshKey,
                onLoad: () async{
                  nowPageIndex ++;
                  var data = await getndnListData('-1',nowPageIndex);
                  if (data != null) {
                    setState(() {
                      dataList.data.list.addAll(data.data.list);
                    });
                  }
                  
                },
                onRefresh: () async{
                  nowPageIndex =1;
                  var data = await getndnListData('-1',nowPageIndex);
                  if (data != null) {
                    setState(() {
                      dataList.data.list.clear();
                      dataList.data.list.addAll(data.data.list);
                    });
                  }
                },
                header: MaterialHeader(),
                footer: MaterialFooter(),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      topBanner(),
                      greyLineUI(),
                      if (catalogueList.length > 0)
                        cataloguesView(catalogueList),
                      ndnTitle(),
                      greyLineUI(),
                      if (dataList != null)
                        ndnProductList(dataList.data.list,true),
                    ],
                  ),
                ),
              )
            ),
          ],
        )
      ),
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
  //final List<String> bannerList = <String>["http://img.zcool.cn/community/01a21d575a17770000018c1bb53779.jpg","http://img.zcool.cn/community/01a21d575a17770000018c1bb53779.jpg","http://img.zcool.cn/community/01a21d575a17770000018c1bb53779.jpg"];
  Future<List> getBannerList() async{
    Map query = {"appKey":prefix0.appkey,"version":"v1.1.0"};
    var val = await httpRequest().request(prefix0.topBannerPath, query);
    List rawList = val['data'] as List;
    return rawList;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getBannerList(),
      builder: (context,snapshot){
        if (snapshot.hasData){
          List bannerList = snapshot.data as List;
          List bannerItem = [];
          for (var item in bannerList) {
            if ((item['banner'] as List).length > 0){
              bannerItem.add((item['banner'] as List).first) ;
            }
          }
          
          if (bannerItem.length ==0){
            bannerItem = ["http://img.zcool.cn/community/01a21d575a17770000018c1bb53779.jpg","http://img.zcool.cn/community/01a21d575a17770000018c1bb53779.jpg","http://img.zcool.cn/community/01a21d575a17770000018c1bb53779.jpg"];
          }
          return Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: ssSetHeigth(300),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(300, 30),bottomRight: Radius.elliptical(300, 30)),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.amber[300],Colors.red[300],Colors.pink[300]],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight
                      )
                    ),
                  ),
                ),
              ),
              Positioned(
                child: Container(
                  color: Colors.transparent,
                  height: ScreenUtil().setHeight(350),
                  width: ScreenUtil().setWidth(750),
                  child: Swiper(
                    itemCount: bannerItem.length,
                    itemBuilder: (context,index){
                      return Container(
                        padding: EdgeInsets.only(top: 8,bottom: 0,left: 13,right: 13),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(bannerItem[index],fit: BoxFit.fill,),
                        )
                      );
                    },
                    pagination: SwiperPagination(),
                    autoplay: true,
                  ),
                ),
              )
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

//热门活动
class cataloguesView extends StatelessWidget {
  List cataoguesList= [];
  cataloguesView(this.cataoguesList);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: cataoguesList.map((item){
        return catalogInfoNoStateTest(item);
      }).toList(),
    );
  }
}
//单个热门活动模块
class catalogInfoNoStateTest extends StatelessWidget {
  final Map item;
  catalogInfoNoStateTest(this.item);
  Future <ninedotnineListModel> _getActivityProdctList() async{
    Map query = {"appKey":prefix0.appkey,"version":"v1.1.0","pageSize":"20","pageId":"1","activityId":"${item["activityId"]}"};
    var rawData = await httpRequest().request(prefix0.cataProductpath, query);
    ninedotnineListModel model = ninedotnineListModel.fromJson(rawData);
    return model;
  }
 
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getActivityProdctList(),
      builder: (context, snapshot){
        if (snapshot.hasData){
          ninedotnineListModel ndnmodel = snapshot.data as ninedotnineListModel;
          String imgUrl = item['goodsLabel'];
          String imgdUrl = item['detailLabel'];
          print('单个活动热门');
          return Column(
            children: <Widget>[
              Container(
                height: ssSetHeigth(120),
                padding: EdgeInsets.all(1),
                child: Row(
                  children: <Widget>[
                    returnImageWithUrl(imgUrl),
                    Expanded(
                      child: returnImageWithUrl(imgdUrl),
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
                    itemCount: ndnmodel.data.list.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                      return singleActivityProductView(ndnmodel.data.list[index]);
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
  final productInfoModel model;
  singleActivityProductView(this.model);
  @override
  Widget build(BuildContext context) {
    
    String imgString = model.mainPic;
    print('单个活动商品');
    return InkWell(
      
      onTap: (){
        Provide.value<ProductDetailProvider>(context).setProductModel(model.id.toString());
        Application.router.navigateTo(context, '/productDetailView?id=${model.id}');
      },
      child: Container(
        height: ssSetHeigth(330),
        width: ssSetWidth(250),
        child: Column(
          children: <Widget>[
            
            returnImageWithUrl(imgString),
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
    return Container(
      padding: EdgeInsets.only(left: 13,right: 13),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(imgUrl,fit: BoxFit.fill,),
      )
    );
  }
}
//9.9商品列表
class ndnProductList extends StatelessWidget {
  List<productInfoModel> _dataList;
  bool isHome;
  BuildContext contextb;
  ndnProductList(this._dataList,this.isHome,{this.contextb});
  Widget _ndnProductCell(productInfoModel model,homeContext1){
    String monthSales = model.monthSales.toString();
    if (monthSales.length > 3){
      monthSales = "${(model.monthSales/10000).toStringAsFixed(2)}万";
    }
    return Container(
      color: Colors.white,
      height:  ssSetHeigth(280),
      width:  ssSetWidth(750),
      child: InkWell(
        onTap: (){
          Provide.value<ProductDetailProvider>(homeContext1).setProductModel(model.id.toString());
          Application.router.navigateTo(homeContext1, '/productDetailView?id=${model.id}',transition: TransitionType.inFromRight);
        },
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                width: ssSetHeigth(260),
                height: ssSetHeigth(260),
                padding: EdgeInsets.only(left: 20,top: 10,right: 10,bottom: 10),
                margin: EdgeInsets.only(bottom: 0),
                child: returnImageWithUrl(model.mainPic),
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    width: ssSetWidth(430),
                    height: ssSetHeigth(120),
                    margin: EdgeInsets.only(top: 10,left: 20,right: 10,bottom: 10),
                    child: Text(model.dtitle,maxLines: 2,style: TextStyle(fontSize: 16),),
                  ),
                  Container(
                    margin: EdgeInsets.all(4),
                    width: ssSetWidth(430),
                    height: ssSetHeigth(38),
                    child: Text('优惠价:¥${model.actualPrice}',style: TextStyle(color: Colors.pink,fontSize: ssSp(28)),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: ssSetWidth(430),
                    height: ssSetHeigth(40),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text('${model.shopType==0?"淘宝":"天猫"}价:¥${model.originalPrice}',style: TextStyle(decoration: TextDecoration.lineThrough,fontSize: 12,color: Colors.grey[600]),),
                        ),
                        Text('已售$monthSales',style: TextStyle(fontSize: ssSp(22)),),
                      ],
                    ),
                  ),
                  Container(
                    height: ssSetHeigth(1),
                    width: ssSetWidth(430),
                    margin: EdgeInsets.only(top: 10),
                    color: Colors.grey[300],
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    if (isHome) {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _dataList.length,
        itemBuilder: (context,index){
          return _ndnProductCell(_dataList[index],homeContext);
        },
      );
    }else
    {
      return ListView.builder(
        itemCount: _dataList.length,
        itemBuilder: (context,index){
          return _ndnProductCell(_dataList[index],contextb);
        },
      );
    }
    
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tkjidi/Config/httpConfig.dart';
import 'package:tkjidi/Config/viewConfig.dart';
import 'package:tkjidi/Home/Models/ninedotnineModel.dart';
import 'package:tkjidi/Home/searchAppBar.dart';
import 'package:tkjidi/Request/httpRequest.dart';
import '../Home/main_Home.dart';
class Products_list extends StatefulWidget {
  final String cid;
  final String title;
  final String type;
  Products_list(this.cid,this.title,this.type);
  @override
  _Products_listState createState() => _Products_listState();
}

class _Products_listState extends State<Products_list> {
  String sortType = "0";
  ninedotnineListModel dataList;
  int nowPageIndex = 1;
  int maxPageIndex;
  Future <ninedotnineListModel> getProductListData() async{
    Map query = {"appKey":appkey,"version":"v1.1.1","pageId":nowPageIndex.toString(),"sort":sortType,'subcid':widget.cid};
    var val = await httpRequest().request(getProductListPath, query);
    return ninedotnineListModel.fromJson(val);
  }

  void reloadProductList() async{
    ninedotnineListModel dList = await getProductListData();
    //maxPageIndex = (dList.data.totalNum % 100) > 0 ? ((dList.data.totalNum - (dList.data.totalNum % 100)) / 100)+1: (dList.data.totalNum % 100).toInt();
    setState(() {
      dataList = dList;
    });
  }

  void reloadndnProductList() async{
    ninedotnineListModel dList = await getndnListData(widget.cid,1);
    //maxPageIndex = (dList.data.totalNum % 100) > 0 ? ((dList.data.totalNum - (dList.data.totalNum % 100)) / 100)+1: (dList.data.totalNum % 100).toInt();
    setState(() {
      dataList = dList;
    });
  }

  @override
  void initState(){
    if (widget.type == "catagory") {
      reloadProductList();
    }else if (widget.type == "nineProduct"){
      reloadndnProductList();
    }
  }
  Widget getSortTool(){
    return Container(
      height: ssSetHeigth(80),
      width: ssSetWidth(750),
      color: Colors.red,
      child: Text('这里是排序/筛选工具栏'),
    );
  }
  FocusNode _focusNode;
  TextEditingController _controller = TextEditingController();
  void _checkInput(){

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
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
                      child: Text(widget.title,textAlign: TextAlign.center,style: TextStyle(fontSize: ssSp(30),color: Colors.white),),
                    ),
                    Container(
                      height: 44,
                      width: 44,
                    ),
                  ],
                )
                ),
              ),
            if (widget.type == "catagory") 
              getSortTool(),
            MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: Expanded(
                child: ndnProductList(dataList==null?[]:dataList.data.list, false,contextb: context,),
              )
            )
            
          ],
        )
      ),
    );
  }
}

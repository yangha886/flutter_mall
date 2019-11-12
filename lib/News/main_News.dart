import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:tkjidi/provider/supCategoly.dart';
import 'package:tkjidi/Config/httpConfig.dart';
import 'package:tkjidi/Config/viewConfig.dart';
import 'package:tkjidi/Request/httpRequest.dart';
import 'package:tkjidi/routes/application.dart';
class CategolyList extends StatelessWidget {
  List data = [];
  
  Future<List> _getCategolyList() async{
    Map query = {"appKey":appkey,"version":"v1.1.0"};
    var rawData = await httpRequest().request(supcatelogListPath, query);
    if (rawData != null)
      return rawData['data'] as List;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('分类'),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getCategolyList(),
          builder: (context,snapshot){
            if (snapshot.hasData){
              data = snapshot.data as List;
              return Row(
                children: <Widget>[
                  leftCatagolyList(data),
                  Provide<SupCategoly>(
                    builder: (context,child,supCate){
                      return rightCatagolyList(data[supCate.selectCIndex]['subcategories'],context);
                    },
                  )
                ],
              );
            }else{
              return Center(
                child:  Text('加载中...'),
              );
            }
          },
        )
      ),
    );
  }
}
class rightCatagolyList extends StatelessWidget {
  List data;
  BuildContext context;
  rightCatagolyList(this.data,this.context);
  Widget _rightInkWell(Map item){
    String imgurl = fixImgUrl(item['scpic']);
    return Container(
      height: ssSetHeigth(130),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: BorderDirectional(
          bottom: BorderSide(width: 0.5,color: Colors.grey[200]),
        )
      ),
      child: InkWell(
        onTap: (){
          print(item['subcname']);
          Application.router.navigateTo(context, '/productDetailList?id=${item['subcid']}');
        },
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(item['scpic'],fit: BoxFit.fill,),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(item['subcname']),
              ),
            ),
            Icon(Icons.keyboard_arrow_right,color: Colors.black54,),
            
          ],
        ),
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ssSetWidth(550),
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context,index){
          return _rightInkWell(data[index]);
        },
      ),
    );
  }
}
class leftCatagolyList extends StatelessWidget {
  List data;
  leftCatagolyList(this.data);
  Widget _leftInkWell(BuildContext context, int itemIndex,int selectedIndex){
    return InkWell(
      onTap: (){
        print('你选择了===>$selectedIndex');
        Provide.value<SupCategoly>(context).changedCIndex(itemIndex);
      },
      child:  Container(
        height: ssSetHeigth(80),
        padding: EdgeInsets.only(left: 8,top: 8),
        child: Text(data[itemIndex]['cname']),
        decoration: BoxDecoration(
          color: itemIndex==selectedIndex? Colors.grey[300]:Colors.white,
          border: Border(
            bottom: BorderSide(width: 0.5,color: Colors.grey[300]),
          )
        ),
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ssSetWidth(200),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(width: 0.5,color:  Colors.grey[300]),
          )
        ),
        child: Provide<SupCategoly>(
          builder: (context,child,supCate){
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context,index){
                return _leftInkWell(context,index,supCate.selectCIndex);
              },
            );
          },
        )
      )
    );
  }
}








































// import 'package:flutter/material.dart';
// import 'package:provide/provide.dart';
// import 'package:tkjidi/provider/sumProvider.dart';
// class Main_News extends StatefulWidget {
//   @override
//   _Main_NewsState createState() => _Main_NewsState();
// }

// class _Main_NewsState extends State<Main_News> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         textLabel(),
//         buttonV()
//       ],
//     );
//   }
// }

// class textLabel extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Provide<sumProvider>(
//         builder: (context, child, sumpro){
//           return Text('${sumpro.Num}',style: Theme.of(context).textTheme.display1,);
//         },
//       ),
//       //child: Text('data',style: Theme.of(context).textTheme.display1,),
//     );
//   }
// }

// class buttonV extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return RaisedButton(
//       onPressed: (){
//         Provide.value<sumProvider>(context).add();
//       },
//       child: Text('Click'),
//     );
//   }
// }
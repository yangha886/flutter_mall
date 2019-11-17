import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provide/provide.dart';
import 'package:tkjidi/provider/supCategoly.dart';
import 'package:tkjidi/Config/httpConfig.dart';
import 'package:tkjidi/Config/viewConfig.dart';
import 'package:tkjidi/Request/httpRequest.dart';
import 'package:tkjidi/routes/application.dart';
import 'package:tkjidi/Home/searchAppBar.dart';
class CategolyList extends StatelessWidget {
  List data = [];
  
  Future<List> _getCategolyList() async{
    Map query = {"appKey":appkey,"version":"v1.1.0"};
    var rawData = await httpRequest().request(supcatelogListPath, query);
    if (rawData != null)
      return rawData['data'] as List;
  }
  FocusNode _focusNode;
  TextEditingController _controller = TextEditingController();
  void _checkInput(){

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(
          focusNode: _focusNode,
          controller: _controller,
          height: 50,
          evevation: 0,
          inputFormatters: [LengthLimitingTextInputFormatter(70)],
          onEditingComplete: ()=>_checkInput(),
          backGroundColor: [Colors.amber[300],Colors.red[300],Colors.pink[300]],
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
    String imgurl = item['scpic'];
    return Container(
      //height: ssSetHeigth(130),
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: InkWell(
        onTap: (){
          Application.router.navigateTo(context, '/productDetailList?id=${item['subcid']}&title=${Uri.encodeComponent(item['subcname'])}&type=catagory',transition:TransitionType.inFromRight);
        },
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: returnImageWithUrl(imgurl),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 0),
                child: Text(item['subcname'],textAlign: TextAlign.center,),
              ),
            ),
            
          ],
        ),
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ssSetWidth(550),
      child: GridView.builder(
        itemBuilder: (context,index){
          return _rightInkWell(data[index]);
        },
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.85,
        ),
      )
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: ssSetWidth(8),
              height: ssSetHeigth(70),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: Container(
                  color: itemIndex!=selectedIndex?Colors.grey[200]: Colors.red,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 12),
              child: Text(data[itemIndex]['cname'],textAlign: TextAlign.center,style: TextStyle(color: itemIndex!=selectedIndex? Colors.black87:Colors.red)),
            )
            
          ],
        ),
        decoration: BoxDecoration(
          color: itemIndex!=selectedIndex? Colors.grey[200]:Colors.white,
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
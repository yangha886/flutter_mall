import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:tkjidi/Config/viewConfig.dart';
import 'package:tkjidi/routes/application.dart';
import 'package:tkjidi/provider/supCategoly.dart';

class Main_Account extends StatelessWidget {
  Widget get _topStack{
    return Stack(
            alignment:Alignment.topCenter ,
            fit: StackFit.loose, //未定位widget占满Stack整个空间
            children: <Widget>[
              Positioned(
                child: Container(
                  height: ssSetHeigth(355),
                  color: Colors.deepOrange,
                ),
              ),
              Positioned(
                left: 15,
                top: 15,
                child:  Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        height: ssSetHeigth(120),
                        width: ssSetWidth(120),
                        child: Image.network('https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=4269996377,924019096&fm=26&gp=0.jpg'),
                      )
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("用户名",style: TextStyle(fontSize: 18,color: Colors.white),),
                          Text("用户vip等级",style: TextStyle(fontSize: 14,color: Colors.orange),)
                        ],
                      ),
                    ),
                  ],
                )
              ),
              Positioned(
                right: 15,
                top: 15,
                child: IconButton(
                  icon: Icon(Icons.settings,color: Colors.white,),
                  onPressed: (){
                   
                  },
                )
              ),
              Positioned(
                top: 100,
                left: 15,
                right: 15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: ssSetHeigth(200),
                    color: Colors.orangeAccent,
                    child: Text("data"),
                  ),
                ),
              )
            
              
            ],
          );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: Container(
              height: ssSetHeigth(430),
              width: ssSetWidth(750),
              child: _topStack,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15,top: 0,right: 15),
            height: ssSetHeigth(200),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: EdgeInsets.only(left: 15,right: 15,top: 10),
                color: Colors.greenAccent,
                child: Row(
                  children: <Widget>[
                    Text("data"),
                    Text("data"),
                    Text("data"),
                    Text("data"),
                  ],
                ),
              ),
            ),
          )
          
        ],
      )

    );
  }
}
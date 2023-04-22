import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_live_chat/Modelo/UserChat.dart';
import 'package:flutter_live_chat/Values/ColorsApp.dart';
import 'package:flutter_live_chat/Widget/Card/UserCard.dart';
import 'package:flutter_live_chat/main.dart';

class HomePage extends StatefulWidget {
  UserChat userChat;
  HomePage(this.userChat);
  @override
  State createState() => HomePageState(this.userChat);
}

class HomePageState extends State<HomePage> with WidgetsBindingObserver {
  UserChat userChat;
  HomePageState(this.userChat);

  List<UserChat> userChats = [];

  @override
  void initState() {
    super.initState();
  }


  Future<Null> handleSignOut() async {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MyApp()),
            (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            tabs: [
              Tab(text:"CHATS",),
              Tab(text:"ESTADOS"),
              Tab(text:"LLAMADAS"),
            ],
          ),
          backgroundColor: greenApp,
          title: Text("MyChatApp",style: TextStyle(color: Colors.white),),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search,color: Colors.white,),
              onPressed: () {

              },
            ),
            IconButton(
                icon: Icon(Icons.exit_to_app,color: Colors.white,),
                onPressed: handleSignOut
            ),
          ],
        ),
        body: TabBarView(
          children: [
            listUsers(),
            new Container(
              width: 30.0,
              child: new Text('Estados'),
            ),

            new Container(
              width: 30.0,
              child: new Text('LLamadas'),
            ),
          ],
        )
      ),
    );
  }

  listUsers(){
    return ListView.builder(
      shrinkWrap: false,
      itemCount: userChats.length,
      padding: EdgeInsets.all(10.0),
      itemBuilder: (BuildContext context, int index) {
        return UserCard(userChat, userChats[index]);
      },
    );
  }

}

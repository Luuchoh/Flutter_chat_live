import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live_chat/DataBase/DataBase.dart';
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
  StreamSubscription<DatabaseEvent>? onAddedSubs;
  StreamSubscription<DatabaseEvent>? onChangeSubs;

  @override
  void initState() {
    onAddedSubs = DataBase.tableUser.onChildAdded.listen(onEntryAdded);
    onChangeSubs = DataBase.tableUser.onChildAdded.listen(onEntryChanged);
    updateOnline(true);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  onEntryAdded(DatabaseEvent event)async {
    UserChat newUser=UserChat.toUser(event.snapshot);
    if(mounted)
      setState(() {
        userChats.add(newUser);
      });
  }

  onEntryChanged(DatabaseEvent event) async{
    UserChat oldEntry = userChats.singleWhere((entry) {
      return entry.id == event.snapshot.key;
    });
    UserChat newUser = UserChat.toUser(event.snapshot);
    if(mounted)
      setState(() {
        userChats[userChats.indexOf(oldEntry)] = newUser;
      });
  }

  void dispose() {
    onAddedSubs?.cancel();
    onChangeSubs?.cancel();
    WidgetsBinding.instance.removeObserver(this);
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
        return buildItem(context, userChats[index]);
      },
    );
  }

  buildItem(BuildContext context, UserChat peer) {
    return (peer == null || userChat.id == peer.id)
        ? SizedBox.shrink()
        : UserCard(userChat, peer);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch(state) {
      case AppLifecycleState.resumed:
        updateOnline(true);
        break;
      case AppLifecycleState.paused:
        updateOnline(false);
        break;
      default:
        break;
    }
  }

  updateOnline(bool isOnline) {
    userChat.isOnline = isOnline;
    userChat.lastTime = DateTime.now().microsecondsSinceEpoch.toString();

    userChat.updateIsOnline();
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_live_chat/Common/Keys.dart';
import 'package:flutter_live_chat/Modelo/MessageChat.dart';
import 'package:flutter_live_chat/Modelo/UserChat.dart';
import 'package:flutter_live_chat/Widget/ChatAppBar.dart';
import 'package:flutter_live_chat/Widget/SentMessage.dart';

class ChatPage extends StatefulWidget {
  UserChat? user;
  UserChat? peer;

  ChatPage({Key? key, this.user, this.peer}) : super(key:Keys().chatState);

  @override
  State createState() => ChatState(this.user, this.peer);
}

class ChatState extends State<ChatPage> {
  UserChat? user;
  UserChat? peer;

  ChatState(this.user, this.peer);

  String groupChatId = "";
  int _limit = 20;
  final int _limitIncrement = 20;

  bool isShowSticker = false;

  final ScrollController listScrollController = ScrollController();

  final TextEditingController textEditingController = TextEditingController();
  List<MessageChat> messages = [];

  @override
  void initState() {
    super.initState();
    loadGroupChatId();
    listScrollController.addListener(_scrollListener);
    messages = MessageChat.getMessages();

  }

  loadGroupChatId() async {
    setState(() {
      groupChatId = (user!.id.hashCode <= peer!.id.hashCode)
          ? '${user?.id}-${peer?.id}'
          : '${peer?.id}-${user?.id}';
    });
  }

  _scrollListener() {
    if (listScrollController.offset >=
        listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      print("llegar al fondo");
      setState(() {
        _limit += _limitIncrement;
      });
    }
    if (listScrollController.offset <=
        listScrollController.position.minScrollExtent &&
        !listScrollController.position.outOfRange) {
      print("llegar al arriba");
      setState(() {
      });
    }
  }



  Future<bool> onBackPress() {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
      //user..chattingWith=null..updateChattingWith();
      Navigator.pop(context);
    }

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: ChatAppBar(peer!),
        body: WillPopScope(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  // List of messages
                  buildListMessage(),
                ],
              ),
            ],
          ),
          onWillPop: onBackPress,
        ));
  }


  Widget buildListMessage() {
    return Flexible(
        child: groupChatId == ''
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.red
                  )
                )
              )
            : ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemBuilder: (context, index) => SentMessage(messages[index]),
                itemCount: messages.length,
                reverse: true,
                controller: listScrollController,
                )
    );
  }

}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_live_chat/Common/Keys.dart';
import 'package:flutter_live_chat/Modelo/MessageChat.dart';
import 'package:flutter_live_chat/Modelo/UserChat.dart';
import 'package:flutter_live_chat/Widget/ChatAppBar.dart';
import 'package:flutter_live_chat/Widget/ReceivedMessage.dart';
import 'package:flutter_live_chat/Widget/SentMessage.dart';
import 'package:flutter_live_chat/Widget/StickerGridView.dart';
import 'package:flutter_live_chat/Widget/TextFieldChat.dart';

class ChatPage extends StatefulWidget {
  UserChat? user;
  UserChat? peer;

  ChatPage({this.user, this.peer}) : super(key: chatState);

  @override
  State createState() => ChatState(user!, peer!);
}

class ChatState extends State<ChatPage> {
  UserChat user;
  UserChat peer;

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
      groupChatId = (user.id.hashCode <= peer.id.hashCode)
          ? '${user.id}-${peer.id}'
          : '${peer.id}-${user.id}';
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
        appBar: ChatAppBar(peer),
        body: WillPopScope(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  // List of messages
                  buildListMessage(),
                  (isShowSticker)
                    ? StickerGridView()
                    : SizedBox.shrink(),
                  TextFieldChat(),
                ],
              ),
            ],
          ),
          onWillPop: onBackPress,
        ));
  }

  showSticker (bool isShowSticker) {
    setState(() {
      this.isShowSticker = isShowSticker;
    });
  }

  buildItem(MessageChat messageChat) {
    return (messageChat.idFrom == user.id)
      ? SentMessage(messageChat)
      : ReceivedMessage(messageChat);
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
                itemBuilder: (context, index) => buildItem(messages[index]),
                itemCount: messages.length,
                reverse: true,
                controller: listScrollController,
                )
    );
  }

  void onSendMessage(int type, {String? content}) {
    content = (content == null) ? textEditingController.text : content;
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.isNotEmpty) {
      textEditingController.clear();
      MessageChat(
          seen: false,
          idFrom: user.id,
          idTo: peer.id,
          timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
          content: content,
          type: type)
          .save(groupChatId);

      listScrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

}

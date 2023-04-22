
import 'package:flutter_live_chat/DataBase/DataBase.dart';

class MessageChat {
  String? id;
  String? content;
  String? idFrom;
  String? idTo;
  String? timestamp;
  int? type;
  bool? seen;

  MessageChat(
      {this.id,
        this.content ,
        this.idFrom ,
        this.idTo ,
        this.timestamp,
        this.type ,
        this.seen});

  Map<String, dynamic> toMap() {
    return {
      'id': timestamp,
      'content': content,
      'idFrom': idFrom,
      'idTo': idTo,
      'timestamp': timestamp,
      'type': type,
      'seen': seen
    };
  }

  MessageChat.toMessage(var snap) {
    id = snap.key;
    content = snap.value['content'];
    idFrom = snap.value['idFrom'];
    idTo = snap.value['idTo'];
    timestamp = snap.value['timestamp'];
    type = snap.value['type'];
    seen = snap.value['seen'];
  }

  save(String groupChatId) {
    DataBase.tableMessage.child(groupChatId).child(timestamp!).set(toMap());
  }

  static getMessages() {
    return [
      MessageChat(
        id: "1",
        content: "Holiii",
        idFrom: "1",
        idTo: "2",
        timestamp: "1612520639893",
        type: 0,
        seen: false,
      ),
      MessageChat(
        id: "1",
        content: "Holiiuuuuu",
        idFrom: "1",
        idTo: "2",
        timestamp: "1612520639893",
        type: 0,
        seen: false,
      ),
      MessageChat(
        id: "2",
        content: "Hi",
        idFrom: "2",
        idTo: "1",
        timestamp: "1612520639893",
        type: 0,
        seen: false,
      ),
      MessageChat(
        id: "2",
        content: "Hiiuuuu",
        idFrom: "2",
        idTo: "1",
        timestamp: "1612520639893",
        type: 0,
        seen: false,
      ),
    ];
  }
}
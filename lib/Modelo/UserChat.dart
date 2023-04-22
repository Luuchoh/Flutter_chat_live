
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_live_chat/DataBase/DataBase.dart';

class UserChat {
  String? id;
  String? bio;
  String? userName;
  String? photoUrl;
  bool? isOnline;
  String? lastTime;

  UserChat({this.id,
    this.bio,
    this.userName,
    this.photoUrl,
    this.isOnline,
    this.lastTime});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bio': bio,
      'userName': userName,
      'photoUrl': photoUrl,
      'isOnline': isOnline,
      'lastTime': lastTime
    };
  }

  UserChat.toUser(var snap) {
    id = snap.key;
    bio = snap.value['bio'];
    userName = snap.value['userName'];
    photoUrl = snap.value['photoUrl'];
    isOnline = snap.value['isOnline'];
    lastTime = snap.value['lastTime'];
  }

  static getUser(String id) async {
    DatabaseEvent event = await DataBase.tableUser.equalTo(id, key: 'id').once();
    return (event.snapshot.value != null) ? UserChat.toUser(event.snapshot.value): null;
  }

  save() {
    DataBase.tableUser.child(id!).set(toMap());
  }
}

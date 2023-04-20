
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
    return UserChat(
      id: id,
      bio: "Soy desarrollador fullstack",
      userName: "Cody$id",
      lastTime: '1612520639893',
      isOnline: true,
      photoUrl: "https://i.ibb.co/cxj2ysz/unnamed-1.jpg",
    );
  }
}

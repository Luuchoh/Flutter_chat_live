import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live_chat/Modelo/UserChat.dart';

class ChatAppBar extends StatefulWidget implements PreferredSizeWidget {
  UserChat peer;
  ChatAppBar(this.peer);
  @override
  State<StatefulWidget> createState() =>ChatAppBarState(this.peer);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class ChatAppBarState extends State<ChatAppBar>{
  UserChat peer;
  ChatAppBarState(this.peer);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      titleSpacing: 0,
      iconTheme: IconThemeData(color: Colors.black54),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding:EdgeInsets.all(5),
            child:CircleAvatar(
            radius: 17,
            backgroundImage: NetworkImage(peer.photoUrl!),
          )),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  peer.userName!,
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.clip,
                ),
                Text(
                  peer.isOnline! ? "Online" : peer.lastTime!,
                  style: Theme.of(context).textTheme.titleMedium?.apply(
                    color: Colors.green,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.phone),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.videocam),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ],
    );
  }


}
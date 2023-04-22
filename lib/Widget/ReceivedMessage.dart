
import 'package:flutter/material.dart';
import 'package:flutter_live_chat/Common/DateFormatApp.dart';
import 'package:flutter_live_chat/Common/Keys.dart';
import 'package:flutter_live_chat/Modelo/MessageChat.dart';
import 'package:flutter_live_chat/Widget/ContentMessage.dart';

class ReceivedMessage extends StatelessWidget {
  MessageChat message;
  ReceivedMessage(this.message);

  @override
  Widget build(BuildContext context) {
    // print("KEYS " + Keys().chatState.currentState.toString());
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        children: <Widget>[
          Padding(padding:EdgeInsets.only(right: 10),
            child: CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(chatState.currentState!.peer.photoUrl!),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${chatState.currentState!.peer.userName}",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: ContentMessage(message, Colors.black87, Colors.grey.withOpacity(.3))
                /*Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * .6
                  ),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  child: Text(
                    "${message.content}",
                    style: Theme.of(context).textTheme.bodyMedium?.apply(
                      color: Colors.black87
                      ),
                  ),
                ),*/
              ),
            ],
          ),
          Text(
            "${DateFormatApp.getDateFormat(message.timestamp) }",
            style: Theme.of(context).textTheme.bodyMedium?.apply(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_live_chat/Common/DateFormatApp.dart';
import 'package:flutter_live_chat/Modelo/MessageChat.dart';


class SentMessage extends StatelessWidget {
  MessageChat message;
  SentMessage(this.message);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            "${DateFormatApp.getDateFormat(message.timestamp)}",
            style: Theme.of(context).textTheme.bodyMedium?.apply(color: Colors.grey),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * .6
              ),
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
              ),
              child: Text(
                "${message.content}",
                style: Theme.of(context).textTheme.bodyMedium?.apply(
                  color: Colors.white
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

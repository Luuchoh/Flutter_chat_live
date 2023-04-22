import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live_chat/Common/Keys.dart';


class StickerGridView extends StatelessWidget{
  List<String>images=['PD_1','PD_2','PD_3','PD_4','PD_5','PD_6','PD_7','PD_8','PD_9'];

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: GridView.count(
        crossAxisCount: 3,
        children: images.map((value) {
          return ElevatedButton(
            onPressed: () => { chatState.currentState?.onSendMessage(2, content: value) },
            child: Image.asset(
              'images/$value.png',
              fit: BoxFit.cover,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              side: BorderSide.none,
              shape: RoundedRectangleBorder(),
            )
          );
        }).toList()),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.black, width: 0.5
          )
        ),
      ),
      padding: EdgeInsets.all(5.0),
      height: 180.0,
    );
  }
}

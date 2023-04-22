import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live_chat/Common/Keys.dart';


class StickerGridView extends StatelessWidget{
  List<String>images=['CODY_1','CODY_2','CODY_3','CODY_4','CODY_5','CODY_6'];

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

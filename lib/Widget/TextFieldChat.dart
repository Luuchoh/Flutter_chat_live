import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live_chat/Common/Keys.dart';
import 'package:image_picker/image_picker.dart';

class TextFieldChat extends StatefulWidget {
  TextFieldChat();

  @override
  State<StatefulWidget> createState() => TextFieldChatState();
}

class TextFieldChatState extends State<TextFieldChat> {
  TextFieldChatState();

  String imageUrl = "";
  File imageFile = File("") ;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    focusNode.addListener(onFocusChange);
  }

  onFocusChange() {
    if(focusNode.hasFocus) {
      chatState.currentState?.showSticker(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
          TextFieldButton(getImage, Icons.image),
          TextFieldButton(getSticker, Icons.face),

          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                onSubmitted: (value) {
                  chatState.currentState?.onSendMessage(0);
                },
                style: TextStyle(fontSize: 15.0),
                controller: chatState.currentState?.textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Escribe tu mensaje...',
                  hintStyle: TextStyle(color: Colors.black),
                ),
                focusNode: focusNode,
              ),
            ),
          ),

          // Button send message
          TextFieldButton(
            () => { chatState.currentState?.onSendMessage(0) },
            Icons.send,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey, width: 0.5
          )
        ),
      ),
    );
  }

  TextFieldButton(var onPressed, IconData icon) {
    return ElevatedButton(

      onPressed: onPressed,
      child: Icon(icon),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(),
        minimumSize: Size.fromWidth(10.0)
      ),
    );
  }

  Future getImage() async {
    XFile? pickedFile = (await ImagePicker().pickImage(
        source: ImageSource.gallery));
    if (pickedFile != null) imageFile = File(pickedFile.path);

    if (imageFile != null) {
    }
  }

  getSticker() {
    focusNode.unfocus();
    chatState.currentState?.showSticker(!chatState.currentState!.isShowSticker);
  }

}

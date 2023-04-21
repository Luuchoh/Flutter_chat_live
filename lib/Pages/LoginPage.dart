import 'package:flutter/material.dart';
import 'package:flutter_live_chat/Modelo/UserChat.dart';
import 'package:flutter_live_chat/Pages/HomePage.dart';

class LoginPage extends StatefulWidget {

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  bool isLoading = false;

  signIn() async{
    UserChat userChat;
    userChat = await UserChat.getUser("1");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            HomePage(userChat)
      )
    );
  }

  goHomePage(UserChat userChat){
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              HomePage(userChat)
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Center(
              child: ElevatedButton(
                onPressed: signIn,
                child: Text(
                  'INICIAR SESION CON GOOGLE',
                  style: TextStyle(fontSize: 16.0,color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffdd4b39)
                ),
              ),
            ),
            Positioned(
              child: isLoading ? const Center(child:CircularProgressIndicator()) : Container(),
            ),
          ],
        ));
  }
}